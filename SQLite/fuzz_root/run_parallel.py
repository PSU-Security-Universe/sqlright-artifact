import re
import time
import os
import shutil
import subprocess
import atexit

oracle_str = "TLP"


sqlite_root_dir = "/home/luy70/Squirrel_DBMS_Project/sqlite3_source/sqlite/bld/384f5c26f48b92e8bfcb168381d4a8caf3ea59e7_NOR_EARLY"
sqlite_bin = os.path.join(sqlite_root_dir, "sqlite3")
current_workdir = os.getcwd()

starting_core_id = 0
parallel_num = 5

timeout_ms = 2000

for cur_inst_id in range(starting_core_id, starting_core_id + parallel_num, 1):
    print("###############\nSetting up core_id: " + str(cur_inst_id))

    # Set up SQLRight output folder
    cur_output_dir_str = "./outputs_" + str(cur_inst_id - starting_core_id)
    if not os.path.isdir(cur_output_dir_str):
        os.mkdir(cur_output_dir_str)
    
    cur_output_file = os.path.join(cur_output_dir_str, "output.txt")
    cur_output_file = open(cur_output_file, "w")

    modi_env = dict()
    modi_env["AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES"] = "1"

    fuzzing_command = [
        "./afl-fuzz",
        "-i", "./inputs",
        "-o", cur_output_dir_str,
        "-c", str(cur_inst_id),
        "-O", str(oracle_str),
        "-t", str(timeout_ms),
        " -- ", sqlite_bin,
        "&"
    ]

    fuzzing_command = " ".join(fuzzing_command)
    print("Running fuzzing command: " + fuzzing_command)

    p = subprocess.Popen(
                        fuzzing_command,
                        cwd=os.getcwd(),
                        shell=True,
                        stderr=cur_output_file,
                        stdout=cur_output_file,
                        stdin=subprocess.DEVNULL,
                        env=modi_env
                        )

print("Finished launching the fuzzing. Now monitor the mysql process. ")

print("#############\nFinished launching the fuzzing. \n\n\n")
while True:
        time.sleep(100)
        pass
