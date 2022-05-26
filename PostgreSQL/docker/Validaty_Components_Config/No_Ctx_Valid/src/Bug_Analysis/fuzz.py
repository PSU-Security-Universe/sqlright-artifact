import atexit
import subprocess

import constants
import utils


def create_fuzzer_instances(start_id, stop_id):
    fuzzer_instances = []

    for i in range(start_id, stop_id):
        fuzzing_command = (
            constants.FUZZING_COMMAND
            + f" -c {i} "
            + f" -O NOREC "
            + f" -- {constants.POSTGRE_FUZZING_BINARY_PATH} &"
        )
        fuzzing_workdir = constants.FUZZING_ROOT_DIR / f"fuzz_root_{i}"

        p = subprocess.Popen(
            [fuzzing_command],
            cwd=fuzzing_workdir,
            shell=True,
            stderr=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stdin=subprocess.DEVNULL,
        )

        fuzzer_instances.append(p)

    def exit_handler():
        for instance in fuzzer_instances:
            instance.kill()

    atexit.register(exit_handler)


def setup_fuzzing_env(start_id, stop_id):
    def clean_old_folders():
        for i in range(start_id, stop_id):
            fuzz_root_dir = constants.FUZZING_ROOT_DIR / f"fuzz_root_{i}"
            utils.remove_directory(fuzz_root_dir)

    def copy_new_folders():
        for i in range(start_id, stop_id):
            utils.copy_directory(
                constants.FUZZING_ROOT_DIR / "fuzz_root",
                constants.FUZZING_ROOT_DIR / f"fuzz_root_{i}",
            )

    clean_old_folders()
    copy_new_folders()


def run_fuzzer():
    start_id = constants.CORE_ID_BEGIN
    stop_id = start_id + constants.MAX_FUZZING_INSTANCE

    setup_fuzzing_env(start_id, stop_id)
    create_fuzzer_instances(start_id, stop_id)
