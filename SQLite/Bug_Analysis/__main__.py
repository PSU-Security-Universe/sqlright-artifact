import sys
import os
import time
from git import Repo

print(os.getcwd())
sys.path.append(os.getcwd())

from bi_config import *
from helper import VerCon, IO, log_out_line, Bisect, Fuzzer
from ORACLE import Oracle_TLP, Oracle_NOREC, Oracle_ROWID, Oracle_INDEX, Oracle_LIKELY


def main():

    IO.gen_unique_bug_output_dir(is_removed_uniq_ori=True)

    if len(sys.argv) <= 1:
        oracle = Oracle_NOREC()
        oracle_str = "NOREC"
    elif sys.argv[1] == "NOREC":
        oracle = Oracle_NOREC()
        oracle_str = "NOREC"
    elif sys.argv[1] == "TLP":
        oracle = Oracle_TLP()
        oracle_str = "TLP"
    elif sys.argv[1] == "ROWID":
        oracle = Oracle_ROWID()
        oracle_str = "ROWID"
    elif sys.argv[1] == "INDEX":
        oracle = Oracle_INDEX()
        oracle_str = "INDEX"
    elif sys.argv[1] == "LIKELY":
        oracle = Oracle_LIKELY()
        oracle_str = "LIKELY"
    # Add your own oracle here:
    else:
        print("Oracle not specified or not recognized. Defaulting NOREC. ")
        log_out_line("Oracle not specified or not recognized. Defaulting NOREC. ")
        oracle = Oracle_NOREC()
        oracle_str = "NOREC"

    # all_existed_commits_l = IO.retrive_existing_commid_id(file_directory=UNIQUE_BUG_OUTPUT_DIR)
    # Bisect.pure_add_commit(commit_id_l=all_existed_commits_l)

    # all_existed_commits_l.clear()
    # Fuzzer.setup_and_run_fuzzing(oracle_str)

    repo = Repo(SQLITE_DIR)
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
        all_new_queries, current_file_d = IO.read_queries_from_files(
            file_directory=QUERY_SAMPLE_DIR, 
            is_removed_read=True
        )
        if all_new_queries == [] and current_file_d == "Done":
            print("Done")
            break
        elif all_new_queries == []:
            time.sleep(1.0)
            continue

        start_time = time.time()


        """ Every cur_new_queries is a pair of oracle statement. 
            If the oracle requires multiple runs, then the cur_new_queries contains
            multiple queries. If the oracle queries contains only one sequence, then 
            cur_new_queries has only one SQL sequence.

            Here, we are iterating SELECT oracle pairs. If the afl-fuzz uses 100 SELECT
            statement pairs, here we will have 100 iterations. 
        """
        iter_idx = 0
        for cur_new_queries in all_new_queries:
            is_dup_commit = Bisect.run_bisecting(
                queries_l=cur_new_queries,
                oracle=oracle,
                vercon=vercon,
                current_file=current_file_d,
                iter_idx = iter_idx
            )
            iter_idx += 1
        end_time = time.time()
        with open(os.path.join(UNIQUE_BUG_OUTPUT_DIR, "time.txt"), "a") as f:
            f.write(
                "{} {}\n".format(
                    os.path.basename(current_file_d), end_time - start_time
                )
            )

        IO.status_print()


if __name__ == "__main__":
    main()
