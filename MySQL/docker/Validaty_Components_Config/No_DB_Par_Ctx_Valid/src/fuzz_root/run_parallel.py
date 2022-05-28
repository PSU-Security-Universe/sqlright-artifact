import re
import time
import os
import shutil
import subprocess
import atexit

mysql_root_dir = "/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld"
mysql_src_data_dir = os.path.join(mysql_root_dir, "data_all/ori_data")
current_workdir = os.getcwd()

starting_core_id = 50
parallel_num = 1
port_starting_num = 8100

all_fuzzing_p_list = []
all_mysql_p_list = []
shm_env_list = []

def exit_handler():
    for fuzzing_instance in all_fuzzing_p_list:
        fuzzing_instance.kill()
    for mysql_instance in all_mysql_p_list:
        mysql_instance.kill()


def check_pid(pid:int):
    """Check whether pid are still running. """
    try:
        os.kill(pid, 0)
    except OSError:
        return False
    else:
        return True

atexit.register(exit_handler)

if os.path.isfile(os.path.join(os.getcwd(), "shm_env.txt")):
    os.remove(os.path.join(os.getcwd(), "shm_env.txt"))

for cur_inst_id in range(starting_core_id, starting_core_id + parallel_num, 1):
    print("Setting up core_id: " + str(cur_inst_id))

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
    cur_output_file = open(cur_output_file, "w")
    
    # Prepare for env shared by the fuzzer and mysql. 
    cur_port_num = port_starting_num + cur_inst_id - starting_core_id
    socket_path = "/tmp/mysql_" + str(cur_inst_id) + ".sock "

    # Start running the SQLRight fuzzer. 
    fuzzing_command = "AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 ./afl-fuzz -t 100 -m 4000 " \
                        + " -P " + str(cur_port_num) \
                        + " -K " + socket_path \
                        + " -i ./inputs " \
                        + " -o " + cur_output_dir_str \
                        + " -c " + str(cur_inst_id) \
                        + " aaa " \
                        + " & "
    print("Running fuzzing command: " + fuzzing_command)
    p = subprocess.Popen(
                        [fuzzing_command],
                        cwd=os.getcwd(),
                        shell=True,
                        stderr=cur_output_file,
                        stdout=cur_output_file,
                        stdin=subprocess.DEVNULL
                        )
    all_fuzzing_p_list.append(p)

    # Read the current generated shm_mem_id
    while not (os.path.isfile(os.path.join(os.getcwd(), "shm_env.txt"))):
        time.sleep(1)
    shm_env_fd = open(os.path.join(os.getcwd(), "shm_env.txt"))
    cur_shm_str = shm_env_fd.read()
    shm_env_list.append(cur_shm_str)
    shm_env_fd.close()

    os.remove(os.path.join(os.getcwd(), "shm_env.txt"))

    # Start the MySQL instance
    ori_workdir = os.getcwd()
    os.chdir(mysql_root_dir)

    mysql_bin_dir = os.path.join(mysql_root_dir, "bin/mysqld")
    mysql_command = "__AFL_SHM_ID=" + cur_shm_str + " " + mysql_bin_dir + " --basedir=" + mysql_root_dir + " --datadir=" + cur_mysql_data_dir_str + " --port=" + str(cur_port_num) + " --socket=" + socket_path + " & "
    print("Running mysql command: " + mysql_command, end="\n\n")
    p = subprocess.Popen(
                        [mysql_command],
                        cwd=mysql_root_dir,
                        shell=True,
                        stderr=subprocess.DEVNULL,
                        stdout=subprocess.DEVNULL,
                        stdin=subprocess.DEVNULL,
                        )
    all_mysql_p_list.append(p)
    os.chdir(ori_workdir)

print("Finished launching the fuzzing. Now monitor the mysql process. ")

while True:
    time.sleep(100)
