import os
import subprocess
import re
from pathlib import Path 
import shutil

from Bug_Analysis.bi_config import *
from Bug_Analysis.helper.data_struct import log_out_line, RESULT

DEFAULT_DATA = Path("/data/liusong/postgres/data")

def copy_new_data_dir(postgre_install_dir):
    postgre_install_dir = Path(postgre_install_dir)

    initdb = postgre_install_dir / "bin/initdb"
    postgre_binary = postgre_install_dir / "bin/postgres"
    data_dir = postgre_install_dir / "data"
    data_backup_dir = postgre_install_dir / "data.bak"
    
    if data_backup_dir.exists():
        # use exists data backup.
        os.system(f"rsync -avz -q -hH --delete {data_backup_dir}/ {data_dir}")
        return 
    
    if data_dir.exists():
        shutil.rmtree(data_dir)

    # create data directory layout
    initdb_cmd = "{} -D {}".format(initdb.absolute(), data_dir.absolute())
    print(f"Initialize the data directory layout: {initdb_cmd}")
    os.system(initdb_cmd)
    if not data_dir.exists():
        log_out_line("[x] Failed to initialize data directory.")
        return

    # create database x
    current_run_cmd_list = [str(), "--single", "-D", str(), "template0"]
    print("Run the postgre in single mode: {}".format(" ".join(current_run_cmd_list)))

    create_database_command = 'echo "create database x" | {} --single -D {} template0'.format(postgre_binary.absolute(), data_dir.absolute())
    print(create_database_command)
    try:
        subprocess.check_output(create_database_command, shell=True)
        os.system(f"cp -r {data_dir} {data_backup_dir}")
    except Exception as e:
        log_out_line(e)



class Executor:
    @staticmethod
    def execute_queries(queries: str, postgre_install_dir: str, oracle):
        os.chdir(postgre_install_dir)
        if os.path.isfile(os.path.join(postgre_install_dir, "file::memory:")):
            os.remove(os.path.join(postgre_install_dir, "file::memory:"))

        # use new data directory.
        copy_new_data_dir(postgre_install_dir)
        if not os.path.exists("data"):
            return None, RESULT.SEG_FAULT

        current_run_cmd_list = ["./bin/postgres", "--single", "-D", "data", "x"]
        child = subprocess.Popen(
            current_run_cmd_list,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            stdin=subprocess.PIPE,
            errors="replace",
        )
        try:
            if isinstance(queries, list):
                queries = " ".join(queries)

            result_str = child.communicate(queries, timeout=3)[0]
        except subprocess.TimeoutExpired:
            child.kill()
            log_out_line("ERROR: Postgre time out. \n")
            return None, RESULT.ALL_ERROR
        # print("Query is: \n%s\n\n\n\n\n\n" % (queries))
        # print("Result_str is: \n%s\n\n\n\n\n\n\n\n" % (result_str))
        # print("postgre_install_dir: %s" % (postgre_install_dir))
        # print("return code: %d" % (child.returncode))

        # with open("sample.result.txt", 'w') as f:
        #     f.write(result_str)

        if (
            child.returncode != 0 and child.returncode != 1
        ):  # 1 is the default return code if we terminate the Postgre.
            child.kill()
            return None, RESULT.SEG_FAULT  # Is segmentation fault
        child.kill()

        all_res_str_l, res_flag = oracle.retrive_all_results(result_str)

        return all_res_str_l, res_flag
