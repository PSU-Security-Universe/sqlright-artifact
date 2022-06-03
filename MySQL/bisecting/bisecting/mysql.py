from pathlib import Path

import constants
import utils
# import pymysql
from loguru import logger
import subprocess

def clone_mysql_source():
    repo_url = "https://github.com/mysql/mysql-server"

    if not constants.MYSQL_SOURCE.exists():
        constants.MYSQL_SOURCE.mkdir(parents=True)

    if not constants.MYSQL_SOURCE_BACKUP.exists():
        clone_cmd = f"git clone {repo_url} {constants.MYSQL_SOURCE_BACKUP}"
        utils.execute_command(clone_cmd)
        utils.copy_directory(
            constants.MYSQL_SOURCE_BACKUP, constants.MYSQL_CHECKOUT_ROOT
        )
        constants.MYSQL_BUILD_ROOT.mkdir()

def prepare_mysql_data(install_directory: Path):
    data = install_directory / "data"

    # use exists data backup.
    backup = constants.MYSQL_ORIGIN_DATA
    rsync_cmd = "rsync -avz -q -hH --delete " f"{backup}/ {data}"
    utils.execute_command(rsync_cmd)

    logger.debug(f"Use the exist MySQL data.")
    return data.exists()


def force_copy_data_backup(install_directory: Path):
    data = install_directory / "data"
    backup = constants.MYSQL_ORIGIN_DATA
    utils.remove_directory(data)
    utils.copy_directory(backup, data)


def compile_mysql_source(install_directory: Path):
    run_cmake = "cmake -DDOWNLOAD_BOOST=1 -DWITH_BOOST={boost} {src}".format(
        boost=constants.MYSQL_BOOST_SOURCE, src=constants.MYSQL_CHECKOUT_ROOT
    )
    output_log = install_directory / "make.log"
    utils.execute_command(run_cmake, cwd=install_directory, output_file=str(output_log))

    run_make = f"make -j{constants.COMPILE_THREAD_COUNT}"
    utils.execute_command(run_make, cwd=install_directory, output_file=str(output_log))

    compiled_program = install_directory / "bin/mysqld"
    is_success = compiled_program.exists()

    hexsha = install_directory.name

    if is_success:
        logger.debug(f"Compilation successful: {install_directory}")
        utils.remove_failed_commit(hexsha)
    else:
        logger.warning(f"Failed to compile: {install_directory}")
        utils.dump_failed_commit(hexsha)

    return is_success


def checkout_mysql_commit(hexsha: str):
    # rsync_cmd = "rsync -avz -q -hH --delete {src}/ {dest}".format(
    #     src=constants.MYSQL_SOURCE_BACKUP.absolute(),
    #     dest=constants.MYSQL_CHECKOUT_ROOT.absolute(),
    # )
    # utils.execute_command(rsync_cmd)

    checkout_cmd = f"git checkout {hexsha} --force"
    utils.execute_command(checkout_cmd, cwd=constants.MYSQL_CHECKOUT_ROOT)

    logger.debug(f"Checkout commit completed: {hexsha}")


def setup_mysql_commit(hexsha: str):
    """
    Given the MySQL commit ID, check out the commit and compile the MySQL source code.
    If succeed, return the MySQL binary directory (not included the binary name) str;
    if failed, return empty str.
    """

    install_directory = constants.MYSQL_BUILD_ROOT / hexsha

    def is_commit_already_compiled(hexsha): 
        mysqld_binary = install_directory / "bin/mysqld"
        return mysqld_binary.exists()

    def is_commit_already_failed(hexsha):
        commits = utils.json_load(constants.FAILED_COMPILE_COMMITS)
        return hexsha in commits

    if is_commit_already_failed(hexsha):
        logger.debug(
            f"MySQL with commit {hexsha} already failed to compile, skip it."
        )
        return None
    elif is_commit_already_compiled(hexsha):
        logger.debug(f"MySQL with commit {hexsha} already compiled, skip it.")
        return install_directory

    utils.remove_directory(install_directory)
    install_directory.mkdir(parents=True)

    checkout_mysql_commit(hexsha)
    is_success = compile_mysql_source(install_directory)
    if is_success:
        logger.debug(f"Successful to compile MySQL with commit {hexsha} directly.")
        return install_directory

    compile_mysql_source(install_directory)

    if is_commit_already_compiled(hexsha):
        logger.debug(
            f"Successful to compile MySQL with commit {hexsha}."
        )
        return install_directory
    else:
        logger.debug(
            f"Failed to compile MySQL with commit {hexsha}."
        )
        return None


def start_mysqld_server(install_directory: Path):
    mysql_root_dir = install_directory
    cur_mysql_data_dir = mysql_root_dir / "data"
    cur_output_file = install_directory / "output.txt"
    mysql_command = [
        "./bin/mysqld",
        "--basedir=" + str(mysql_root_dir),
        "--datadir=" + str(cur_mysql_data_dir),
        "--port=" + str(constants.MYSQL_SERVER_PORT),
        "--socket=" + str(constants.MYSQL_CONNECT_SOCKET),
        "&"
    ]

    mysql_command = " ".join(mysql_command)

    p = subprocess.Popen(
                        mysql_command,
                        cwd=mysql_root_dir,
                        shell=True,
                        stderr=str(cur_output_file),
                        stdout=str(cur_output_file),
                        stdin=subprocess.DEVNULL,
                        )

def execute_queries(queries: str, install_directory: Path):

    prepare_success = prepare_mysql_data(install_directory)
    if not prepare_success:
        return None, constants.RESULT.SEG_FAULT

    clean_database_query = (
        "RESET PERSIST", 
        "RESET MASTER", 
        "DROP DATABASE IF NOT EXISTS test_sqlright1",
        "CREATE DATABASE IF NOT EXISTS test_sqlright1", 
        "USE test_sqlright1", 
    )
    logger.debug(clean_database_query)
    logger.debug(queries)
    safe_queries = clean_database_query + "\n" + queries

    mysql_client = "./bin/mysql -u root --socket=/tmp/mysql_0.sock"
    output, status, error_msg = utils.execute_command(
        mysql_client, input_contents=safe_queries, cwd=install_directory
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
