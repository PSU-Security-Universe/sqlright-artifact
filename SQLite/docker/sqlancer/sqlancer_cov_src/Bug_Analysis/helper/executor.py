import os
import subprocess
import re

from Bug_Analysis.bi_config import *
from Bug_Analysis.helper.data_struct import log_out_line, RESULT


class Executor:
    @staticmethod
    def execute_queries(queries: str, sqlite_install_dir: str, oracle):
        os.chdir(sqlite_install_dir)
        if os.path.isfile(os.path.join(sqlite_install_dir, "file::memory:")):
            os.remove(os.path.join(sqlite_install_dir, "file::memory:"))
        current_run_cmd_list = ["./sqlite3"]
        child = subprocess.Popen(
            current_run_cmd_list,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            stdin=subprocess.PIPE,
            errors="replace",
        )
        try:
            result_str = child.communicate(queries, timeout=3)[0]
        except subprocess.TimeoutExpired:
            child.kill()
            log_out_line("ERROR: SQLite3 time out. \n")
            return None, RESULT.ALL_ERROR
        # print("Query is: \n%s\n\n\n\n\n\n" % (queries))
        # print("Result_str is: \n%s\n\n\n\n\n\n\n\n" % (result_str))
        # print("sqlite_install_dir: %s" % (sqlite_install_dir))
        # print("return code: %d" % (child.returncode))

        if (
            child.returncode != 0 and child.returncode != 1
        ):  # 1 is the default return code if we terminate the SQLite3.
            child.kill()
            return None, RESULT.SEG_FAULT  # Is segmentation fault
        child.kill()

        all_res_str_l, res_flag = oracle.retrive_all_results(result_str)

        return all_res_str_l, res_flag
