import sys
import os
import time
from git import Repo

print(os.getcwd())
sys.path.append(os.getcwd())

from bi_config import *
from helper import VerCon, IO, log_out_line, Bisect
from ORACLE import Oracle_NOREC


def main():

    IO.gen_unique_bug_output_dir(is_removed_uniq_ori=True)

    if len(sys.argv) <= 1:
        oracle = Oracle_NOREC()
        oracle_str = "NOREC"
    elif sys.argv[1] == "NOREC":
        oracle = Oracle_NOREC()
        oracle_str = "NOREC"
    # elif sys.argv[1] == "TLP":
    #     oracle = Oracle_TLP()
    #     oracle_str = "TLP"
    # elif sys.argv[1] == "ROWID":
    #     oracle = Oracle_ROWID()
    #     oracle_str = "ROWID"
    # elif sys.argv[1] == "INDEX":
    #     oracle = Oracle_INDEX()
    #     oracle_str = "INDEX"
    # elif sys.argv[1] == "LIKELY":
    #     oracle = Oracle_LIKELY()
    #     oracle_str = "LIKELY"
    # Add your own oracle here:
    else:
        print("Oracle not specified or not recognized. Defaulting NOREC. ")
        log_out_line("Oracle not specified or not recognized. Defaulting NOREC. ")
        oracle = Oracle_NOREC()
        oracle_str = "NOREC"

    # Fuzzer.setup_and_run_fuzzing(oracle_str)
    if not os.path.exists(POSTGRE_DIR):
        os.system(f"cp -r {POSTGRE_PURE_DIR} {POSTGRE_DIR}")

    repo = Repo(POSTGRE_DIR)
    assert not repo.bare

    vercon = VerCon()
    all_commits_hexsha, all_tags = vercon.get_all_commits(repo=repo)
    log_out_line(
        "Getting %d number of commits, and %d number of tags. \n\n"
        % (len(all_commits_hexsha), len(all_tags))
    )

    log_out_line(
        "Beginning processing files in the target folder. (Infinite Loop) \n\n"
    )
    while True:
        # Read one file at a time.
        all_new_queries, current_file_d = IO.read_queries_from_files(file_directory=QUERY_SAMPLE_DIR)
        if all_new_queries == [] and current_file_d == "Done":
            print("Done")
            break
        elif all_new_queries == []:
            time.sleep(1.0)
            continue
        if (
            "randomblob" in all_new_queries[0]
            or "random" in all_new_queries[0]
            or "julianday" in all_new_queries[0]
        ):
            continue
        is_dup_commit = Bisect.run_bisecting(queries_l=all_new_queries, oracle=oracle, vercon=vercon)
        if is_dup_commit == True:
            IO.remove_file_from_abs_path(current_file_d)
            
        IO.status_print()


if __name__ == "__main__":
    main()
