import re
from socket import socket
import time
import os
import shutil
import subprocess
import atexit
import signal
import psutil
import MySQLdb

from afl_config import *

all_fuzzing_p_list = dict()
all_mysql_p_list = dict()
shm_env_list = []

def exit_handler(signal, frame):
    print("########################\n\n\n\n\nRecevied terminate signal. Ignored!!!!!!! \n\n\n\n\n")
    pass

def check_pid_exist(pid: int):
    try:
        os.kill(pid, 0)
    except OSError:
        return False
    else:
        return True

signal.signal(signal.SIGTERM, exit_handler)
signal.signal(signal.SIGINT, exit_handler)
signal.signal(signal.SIGQUIT, exit_handler)
signal.signal(signal.SIGHUP, exit_handler)

if os.path.isfile(os.path.join(os.getcwd(), "shm_env.txt")):
    os.remove(os.path.join(os.getcwd(), "shm_env.txt"))

for cur_inst_id in range(starting_core_id, starting_core_id + parallel_num, 1):
    print("#############\nSetting up core_id: " + str(cur_inst_id))

    # Set up the mysql data folder first. 
    cur_mysql_data_dir_str = os.path.join(mysql_root_dir, "data_all/data_" + str(cur_inst_id))
    if os.path.isdir(cur_mysql_data_dir_str):
        shutil.rmtree(cur_mysql_data_dir_str)
    shutil.copytree(mysql_src_data_dir, cur_mysql_data_dir_str)

    # Set up SQLRight output folder
    cur_output_dir_str = "./outputs_" + str(cur_inst_id - starting_core_id)
    if not os.path.isdir(cur_output_dir_str):
        os.mkdir(cur_output_dir_str)

    cur_output_file = os.path.join(cur_output_dir_str, "output.txt")

    cur_output_file_2 = os.path.join(cur_output_dir_str, "output_AFL.txt")
    cur_output_file_2 = open(cur_output_file_2, "w")
    
    # Prepare for env shared by the fuzzer and mysql. 
    cur_port_num = port_starting_num + cur_inst_id - starting_core_id
    socket_path = "/tmp/mysql_" + str(cur_inst_id) + ".sock"

    modi_env = dict()
    modi_env["AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES"] = "1"

    # Start running the SQLRight fuzzer. 
    # fuzzing_command = "./afl-fuzz -t 300 -m 4000 " \
    #                     + " -P " + str(cur_port_num) \
    #                     + " -K " + socket_path \
    #                     + " -i ./inputs " \
    #                     + " -o " + cur_output_dir_str \
    #                     + " -c " + str(cur_inst_id) \
    #                     + " aaa " \
    #                     + " & "
    fuzzing_command = [
        "./afl-fuzz", 
        "-t", "300", 
        "-m", "4000",
        "-P", str(cur_port_num), 
        "-K", socket_path,
        "-i", "./inputs",
        "-o", cur_output_dir_str,
        "-c", str(cur_inst_id),
        "aaa" , "&"
        ]
    fuzzing_command = " ".join(fuzzing_command)
    print("Running fuzzing command: " + fuzzing_command)
    p = subprocess.Popen(
                        fuzzing_command,
                        cwd=os.getcwd(),
                        shell=True,
                        stderr=cur_output_file_2,
                        stdout=cur_output_file_2,
                        stdin=subprocess.DEVNULL,
                        env=modi_env
                        )
    # cur_proc_l = psutil.Process(p.pid).children()
    # if len(cur_proc_l) == 1:
    #     cur_pid = cur_proc_l[0].pid
    #     all_mysql_p_list[cur_pid] = [cur_inst_id, cur_shm_str]
    #     print("Pid: %d\n\n\n" %(cur_pid))
    # else:
    #     print("Running with %d failed. \n\n\n" % (cur_inst_id))

    # Read the current generated shm_mem_id
    while not (os.path.isfile(os.path.join(os.getcwd(), "shm_env.txt"))):
        time.sleep(1)
    shm_env_fd = open(os.path.join(os.getcwd(), "shm_env.txt"))
    cur_shm_str = shm_env_fd.read()
    shm_env_list.append(cur_shm_str)
    shm_env_fd.close()

    os.remove(os.path.join(os.getcwd(), "shm_env.txt"))

    mysql_bin_dir = os.path.join(mysql_root_dir, "bin/mysqld")

    # mysql_command = "__AFL_SHM_ID=" + cur_shm_str + " " + mysql_bin_dir + " --basedir=" + mysql_root_dir + " --datadir=" + cur_mysql_data_dir_str + " --port=" + str(cur_port_num) + " --socket=" + socket_path + " & "

    mysql_command = [
        "screen",
        "-dmS",
        "test" + str(cur_inst_id),
        "bash", "-c", 
        "'",    # left quote
        mysql_bin_dir,
        "--basedir=" + mysql_root_dir,
        "--datadir=" + cur_mysql_data_dir_str,
        "--port=" + str(cur_port_num),
        "--socket=" + socket_path,
        "--performance_schema=OFF",
        "&>", cur_output_file,
        "'"  # right quote
    ]
    mysql_modi_env = dict()
    mysql_modi_env["__AFL_SHM_ID"] = cur_shm_str

    mysql_command = " ".join(mysql_command)

    print("Running mysql command: __AFL_SHM_ID=" + cur_shm_str + " " + mysql_command)
    
    p = subprocess.Popen(
                        mysql_command,
                        shell=True,
                        stderr=subprocess.DEVNULL,
                        stdout=subprocess.DEVNULL,
                        stdin=subprocess.DEVNULL,
                        env = mysql_modi_env
                        )
    time.sleep(1)
    all_mysql_p_list[cur_inst_id] = cur_shm_str

all_share_mem_file = "./all_share_mem_file.txt"
all_share_mem_file = open(all_share_mem_file, "w")

for cur_inst_id, cur_shm_str in all_mysql_p_list.items():
    all_share_mem_file.write("%s:%s\n" % (cur_inst_id, cur_shm_str))

all_share_mem_file.flush()
all_share_mem_file.close()

all_prev_shut_time_file = open("./all_prev_shut_time_file.txt", "w")
for i in range(starting_core_id, starting_core_id + parallel_num, 1):
    all_prev_shut_time_file.write("%d:%s\n" % (i, time.mktime(time.localtime())))
all_prev_shut_time_file.close()

print("Finished launching the fuzzing. Now monitor the mysql process. ")

while True:
    time.sleep(100)
