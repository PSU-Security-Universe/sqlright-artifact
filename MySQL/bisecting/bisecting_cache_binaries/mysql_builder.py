from pathlib import Path
import constants
import utils
from loguru import logger
import subprocess
import os
import shutil

def checkout_and_clean_mysql_repo(hexsha: str):
    checkout_cmd = f"git checkout {hexsha} --force && git clean -xdf"
    utils.execute_command(checkout_cmd, cwd=constants.MYSQL_ROOT)

    logger.debug(f"Checkout commit completed: {hexsha}")

def compile_mysql_source(hexsha: str):
    BLD_PATH = os.path.join(constants.MYSQL_ROOT, "bld")

    run_cmake = "cmake -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost .."
    utils.execute_command(run_cmake, cwd=BLD_PATH)

    run_make = "make -j$(nproc)"
    utils.execute_command(run_make, cwd=BLD_PATH)

    compiled_program_path = os.path.join(BLD_PATH, "bin/mysqld")
    is_success = os.path.isfile(compiled_program_path)

    if is_success:
        logger.debug("Compilation succeed: %s." % (hexsha))
    else:
        logger.warning("Failed to compile: %s" % (hexsha))

    return is_success

def copy_binaries (hexsha: str):
    # Setup the output folder. 
    cur_output_dir = os.path.join(constants.OUTPUT_DIR, hexsha)
    utils.execute_command("mkdir -p %s" % (cur_output_dir), cwd = constants.OUTPUT_DIR)

    cur_output_bin = os.path.join(cur_output_dir, "bin")
    utils.execute_command("mkdir -p %s" % (cur_output_bin), cwd = cur_output_dir)

    cur_output_data = os.path.join(cur_output_dir, "data")
    utils.execute_command("mkdir -p %s" % (cur_output_data), cwd = cur_output_dir)

    shutil.copy("/home/mysql/mysql-server/bld/bin/mysqld", cur_output_bin)
    shutil.copy("/home/mysql/mysql-server/bld/bin/mysql", cur_output_bin)
    shutil.copy("/home/mysql/mysql-server/bld/bin/mysql_ssl_rsa_setup", cur_output_bin)

    for lib_file in os.listdir("/home/mysql/mysql-server/bld/library_output_directory"):
        if "libprotobuf-lite" in lib_file:
            shutil.copy(os.path.join("/home/mysql/mysql-server/bld/library_output_directory", lib_file), cur_output_bin)
    return True


def setup_mysql_commit(hexsha: str):

    logger.debug("Checkout and clean up MySQL root dir.")
    checkout_and_clean_mysql_repo(hexsha)
    utils.execute_command("mkdir -p bld", cwd=constants.MYSQL_ROOT)

    logger.debug("Compile MySQL root dir.")
    is_success = compile_mysql_source(hexsha)

    if not is_success:
        logger.warning("Failed to compile MySQL with commit %s directly." % (hexsha))
        return False

    # Copy the necessary files to the output repo. 
    is_success = copy_binaries(hexsha)

    if not is_success:
        logger.warning("Failed to copy binary MySQL with commit %s directly." % (hexsha))
        return False

    return is_success

