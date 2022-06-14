from pathlib import Path
import os

import constants
import utils
# import pymysql
from loguru import logger
import subprocess

def force_copy_data_backup(hexsha: str):
    backup_data = os.path.join(constants.MYSQL_ROOT, hexsha, "data")
    cur_data = os.path.join(constants.MYSQL_ROOT, hexsha, "data_0")
    utils.remove_directory(cur_data)
    utils.copy_directory(backup_data, cur_data)


#def checkout_mysql_commit(hexsha: str):
#    # rsync_cmd = "rsync -avz -q -hH --delete {src}/ {dest}".format(
#    #     src=constants.MYSQL_SOURCE_BACKUP.absolute(),
#    #     dest=constants.MYSQL_CHECKOUT_ROOT.absolute(),
#    # )
#    # utils.execute_command(rsync_cmd)
#
#    checkout_cmd = f"git checkout {hexsha} --force"
#    utils.execute_command(checkout_cmd, cwd=constants.MYSQL_CHECKOUT_ROOT)
#
#    logger.debug(f"Checkout commit completed: {hexsha}")

def start_mysqld_server(hexsha: str):
    cur_mysql_root = os.path.join(constants.MYSQL_ROOT, hexsha)
    cur_mysql_data_dir = os.path.join(cur_mysql_root, "data_0")
    cur_output_file = os.path.join(constants.BISECTING_SCRIPTS_ROOT, "mysql_output.txt")

    # Firstly, restore the database backup. 
    force_copy_data_backup(hexsha)

    # And then, call MySQL server process. 
    mysql_command = [
        "./bin/mysqld",
        "--basedir=" + str(cur_mysql_root),
        "--datadir=" + str(cur_mysql_data_dir),
        "--port=" + str(constants.MYSQL_SERVER_PORT),
        "--socket=" + str(constants.MYSQL_SERVER_SOCKET),
        "&"
    ]

    mysql_command = " ".join(mysql_command)

    p = subprocess.Popen(
                        mysql_command,
                        cwd=cur_mysql_root,
                        shell=True,
                        stdin=subprocess.DEVNULL,
                        )
    # Do not block the Popen, let it run and return. We will later use `pkill` to kill the mysqld process.

def execute_queries(queries: str, hexsha: str):
    
    cur_mysql_root = os.path.join(constants.MYSQL_ROOT, hexsha)

    clean_database_query = "RESET PERSIST; " + \
        "RESET MASTER; " + \
        "DROP DATABASE IF NOT EXISTS test_sqlright1; " + \
        "CREATE DATABASE IF NOT EXISTS test_sqlright1; " + \
        "USE test_sqlright1; "

    safe_queries = clean_database_query + "\n" + queries
    logger.debug("Running query: \n%s\n" % clean_database_query)

    mysql_client = "./bin/mysql -u root --socket=%s" % (MYSQL_SERVER_SOCKET)
    output, status, error_msg = utils.execute_command(
        mysql_client, input_contents=safe_queries, cwd=install_directory, timeout=3  # 3 seconds timeout. 
    )
    # mysql_client = pymysql.connect(host="127.0.0.1", user="root", port=constants.MYSQL_SERVER_PORT, charset='utf8',unix_socket=str(constants.MYSQL_CONNECT_SOCKET))

    logger.debug(f"Query:\n\n{queries}")
    logger.debug(f"Result: \n\n{output}\n")
    logger.debug(f"Directory: {install_directory}")
    logger.debug(f"Return Code: {status}")

    if not output:
        return None, constants.RESULT.ALL_ERROR

    if status not in (0, 1):
        # 1 is the default return code if we terminate the MySQL.
        return None, constants.RESULT.SEG_FAULT

    return parse_mysql_result(output)


def parse_mysql_result(mysql_output: str):
    def is_output_missing():
        return any(
            [
                mysql_output == "",
                mysql_output.count("BEGIN VERI") < 1,
                mysql_output.count("END VERI") < 1,
                # utils.is_string_only_whitespace(mysql_output)
            ]
        )

    if is_output_missing():
        # Missing the outputs from the opt or the unopt.
        # Returning None implying errors.
        return None, constants.RESULT.ALL_ERROR

    output_lines = mysql_output.splitlines()

    def parse_output_lines(opt: bool):
        i = int(not opt)
        begin_indexes = [
            idx for idx, line in enumerate(output_lines) if f"BEGIN VERI {i}" in line
        ]
        end_indexes = [
            idx for idx, line in enumerate(output_lines) if f"END VERI {i}" in line
        ]

        if len(begin_indexes) != len(end_indexes):
            logger.warning(
                f"the number of 'BEGIN VERI {i}' is not "
                f"equal to the number of 'END VERI {i}'."
            )

        result = []
        for begin_idx, end_idx in zip(begin_indexes, end_indexes):
            current_lines_int = [-1]

            current_lines = output_lines[begin_idx + 1 : end_idx]
            current_lines = map(lambda l: l.strip(), current_lines)
            current_lines = list(filter(lambda l: ' = "' in l, current_lines))

            if current_lines:
                current_lines = map(lambda l: l[l.find("=", 1) + 1 :], current_lines)
                current_lines = map(lambda l: l[: l.find("(")], current_lines)
                current_lines = map(lambda l: l.strip(), current_lines)
                current_lines = map(lambda l: l.strip('"'), current_lines)

                try:
                    if opt:
                        current_lines_int = list(map(lambda n: int(n), current_lines))
                    else:
                        current_lines_int = list(
                            map(lambda n: int(float(n) + 0.0001), current_lines)
                        )
                except ValueError:
                    pass

            result.append(current_lines_int)

        return result

    opt_results = parse_output_lines(opt=True)
    unopt_results = parse_output_lines(opt=False)
    logger.debug(f"opt_results: {opt_results}")
    logger.debug(f"unopt_results: {unopt_results}")
    all_result_pairs = [[opt, unopt] for opt, unopt in zip(opt_results, unopt_results)]

    return all_result_pairs, constants.RESULT.PASS
