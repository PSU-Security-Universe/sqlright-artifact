from Bug_Analysis.helper.version_control import VerCon
from Bug_Analysis.helper.data_struct import BisectingResults, RESULT, log_out_line
from Bug_Analysis.helper.executor import Executor
from Bug_Analysis.helper.io import IO


class Bisect:

    uniq_bug_id_int = 0
    all_unique_results_dict = dict()
    all_previous_compile_failure = []

    @staticmethod
    def _check_query_exec_correctness_under_commitID(queries_l, commit_ID: str, oracle):
        INSTALL_DEST_DIR = VerCon.setup_SQLITE_with_commit(hexsha=commit_ID)

        if INSTALL_DEST_DIR == "":
            log_out_line("Commit failed to compile. \n")
            return RESULT.FAIL_TO_COMPILE, None, None  # Failed to compile commit.

        all_res_str_l = []
        for queries in queries_l:
            all_res_str, res = Executor.execute_queries(
                queries=queries, sqlite_install_dir=INSTALL_DEST_DIR, oracle=oracle
            )
            all_res_str_l.append(all_res_str)

        if res == RESULT.SEG_FAULT:
            log_out_line("Commit Segmentation fault. \n")
            return RESULT.SEG_FAULT, None, None

        if len(all_res_str_l) == 0 or res == RESULT.ALL_ERROR:
            log_out_line("Result all Errors. \n")
            return RESULT.ALL_ERROR, None, None

        final_flag, all_res_flags = oracle.comp_query_res(queries_l, all_res_str_l)

        # log_out_line("All_res_str_l: " + str(all_res_str_l) + "\n")
        # log_out_line("Result with final_flag: " + str(final_flag))
        return final_flag, all_res_flags, all_res_str_l

    @classmethod
    def bi_secting_commits(
        cls, queries_l, oracle, vercon
    ):  # Returns Bug introduce commit_ID:str, is_error_result:bool
        all_commits_str = vercon.all_commits_hexsha
        all_tags = vercon.all_tags
        # The oldest buggy commit, which is the commit that introduce the bug.
        newer_commit_str = ""
        older_commit_str = ""  # The latest correct commit.
        last_buggy_res_l = None
        last_buggy_all_result_flags = None
        is_error_returned_from_exec = False
        current_commit_str = ""

        rn_correctness = RESULT.PASS

        current_bisecting_result = BisectingResults()

        for current_tag in reversed(
            all_tags
        ):  # From the latest tag to the earliest tag.
            current_commit_str = current_tag.commit.hexsha
            current_commit_index = all_commits_str.index(current_commit_str)
            is_successfully_executed = False
            is_commit_found = False

            while not is_successfully_executed:
                current_commit_str = all_commits_str[current_commit_index]
                if current_commit_str in cls.all_previous_compile_failure:
                    rn_correctness = RESULT.FAIL_TO_COMPILE
                else:
                    (
                        rn_correctness,
                        all_res_flags,
                        all_res_str_l,
                    ) = cls._check_query_exec_correctness_under_commitID(
                        queries_l=queries_l, commit_ID=current_commit_str, oracle=oracle
                    )
                if rn_correctness == RESULT.PASS:  # Execution result is correct.
                    older_commit_str = current_commit_str
                    is_successfully_executed = True
                    is_commit_found = True
                    break
                elif rn_correctness == RESULT.FAIL:  # Execution result is buggy
                    newer_commit_str = current_commit_str
                    is_successfully_executed = True
                    if all_res_str_l != None:
                        last_buggy_res_l = all_res_str_l
                    last_buggy_all_result_flags = all_res_flags
                    break
                elif (
                    rn_correctness == RESULT.ALL_ERROR
                ):  # Execution queries all return errors. Treat it similar to execution result is correct.
                    older_commit_str = current_commit_str
                    is_successfully_executed = True
                    is_commit_found = True
                    is_error_returned_from_exec = True
                    break
                elif (rn_correctness == RESULT.FAIL_TO_COMPILE):
                    cls.all_previous_compile_failure.append(current_commit_str)
                    newer_commit_str = current_commit_str
                    is_successfully_executed = False
                    is_commit_found = False
                    break
                else:  # Compilation failed or Segmentation Fault!!!!  rn_correctness == -2. Treat it as RESULT.FAIL.
                    newer_commit_str = current_commit_str
                    is_successfully_executed = False
                    is_commit_found = False
                    break
            if is_commit_found:
                break

        if newer_commit_str == "":
            # Error_reason = "Error: The latest commit: %s already fix this bug, or the latest commit is returnning errors!!! \nOpt: \"%s\", \nunopt: \"%s\". \nReturning None. \n" % (older_commit_str, opt_unopt_queries[0], opt_unopt_queries[1])
            Error_reason = (
                "Error: The latest commit: %s already fix this bug, or the latest commit is returnning errors!!!\n\n\n"
                % (current_commit_str)
            )
            log_out_line(Error_reason)

            current_bisecting_result.query = queries_l
            current_bisecting_result.first_corr_commit_id = current_commit_str
            current_bisecting_result.is_error_returned_from_exec = (
                is_error_returned_from_exec
            )
            current_bisecting_result.is_bisecting_error = True
            current_bisecting_result.bisecting_error_reason = Error_reason
            current_bisecting_result.last_buggy_res_str_l = last_buggy_res_l
            current_bisecting_result.last_buggy_res_flags_l = (
                last_buggy_all_result_flags
            )
            current_bisecting_result.final_res_flag = rn_correctness

            return current_bisecting_result

        if older_commit_str == "":
            # Error_reason = "Error: Cannot find the bug introduced commit (already iterating to the earliest version for queries \nopt: %s, \nunopt: %s. \nReturning None. \n" % (opt_unopt_queries[0], opt_unopt_queries[1])
            Error_reason = "Error: Cannot find the bug introduced commit (already iterating to the earliest version)!!!\n\n\n"
            log_out_line(Error_reason)

            current_bisecting_result.query = queries_l
            current_bisecting_result.is_error_returned_from_exec = (
                is_error_returned_from_exec
            )
            current_bisecting_result.is_bisecting_error = True
            current_bisecting_result.bisecting_error_reason = Error_reason
            current_bisecting_result.last_buggy_res_str_l = last_buggy_res_l
            current_bisecting_result.last_buggy_res_flags_l = (
                last_buggy_all_result_flags
            )
            current_bisecting_result.final_res_flag = rn_correctness

            return current_bisecting_result

        newer_commit_index = all_commits_str.index(newer_commit_str)
        older_commit_index = all_commits_str.index(older_commit_str)

        is_buggy_commit_found = False
        current_ignored_commit_number = 0

        while not is_buggy_commit_found:
            if (newer_commit_index - older_commit_index) <= 1:
                is_buggy_commit_found = True
                break
            tmp_commit_index = int(
                (newer_commit_index + older_commit_index) / 2
            )  # Approximate towards 0 (older).

            is_successfully_executed = False
            while not is_successfully_executed:
                commit_ID = all_commits_str[tmp_commit_index]
                if commit_ID in cls.all_previous_compile_failure:
                    rn_correctness = RESULT.FAIL_TO_COMPILE
                else:
                    (
                        rn_correctness,
                        all_res_flags,
                        all_res_str_l,
                    ) = cls._check_query_exec_correctness_under_commitID(
                        queries_l=queries_l, commit_ID=commit_ID, oracle=oracle
                    )
                if rn_correctness == RESULT.PASS:  # The correct version.
                    older_commit_index = tmp_commit_index
                    is_successfully_executed = True
                    break
                elif rn_correctness == RESULT.FAIL:  # The buggy version.
                    newer_commit_index = tmp_commit_index
                    is_successfully_executed = True
                    if all_res_str_l != None:
                        last_buggy_res_l = all_res_str_l
                    last_buggy_all_result_flags = all_res_flags
                    break
                elif rn_correctness == RESULT.ERROR:
                    older_commit_index = tmp_commit_index
                    is_successfully_executed = True
                    is_error_returned_from_exec = True
                    break
                elif rn_correctness == RESULT.FAIL_TO_COMPILE:
                    cls.all_previous_compile_failure.append(tmp_commit_index)
                    newer_commit_index = tmp_commit_index
                    is_successfully_executed = False
                    is_error_returned_from_exec = True
                    break
                else:  # Compilation failed or Segmentation Fault!!!!  rn_correctness == -2. Treat it as Passing with no mismatched.
                    newer_commit_index = tmp_commit_index
                    is_successfully_executed = False
                    is_error_returned_from_exec = True
                    break

        if is_buggy_commit_found:
            log_out_line(
                "Found the bug introduced commit: %s \n\n\n"
                % (all_commits_str[newer_commit_index])
            )

            current_bisecting_result.query = queries_l
            current_bisecting_result.first_buggy_commit_id = all_commits_str[
                newer_commit_index
            ]
            current_bisecting_result.first_corr_commit_id = all_commits_str[
                older_commit_index
            ]
            current_bisecting_result.is_error_returned_from_exec = (
                is_error_returned_from_exec
            )
            current_bisecting_result.is_bisecting_error = False
            current_bisecting_result.last_buggy_res_str_l = last_buggy_res_l
            # log_out_line("All_res_str_l: " + str(current_bisecting_result.last_buggy_res_str_l) + "\n")
            current_bisecting_result.last_buggy_res_flags_l = (
                last_buggy_all_result_flags
            )
            # log_out_line("All_res_flags: " + str(current_bisecting_result.last_buggy_res_flags_l) + "\n")
            current_bisecting_result.final_res_flag = rn_correctness

            return current_bisecting_result
        else:
            Error_reason = "Error: Returnning is_buggy_commit_found == False. Possibly related to compilation failure. \n\n\n"
            log_out_line(Error_reason)

            current_bisecting_result.query = queries_l
            current_bisecting_result.is_error_returned_from_exec = (
                is_error_returned_from_exec
            )
            current_bisecting_result.is_bisecting_error = True
            current_bisecting_result.bisecting_error_reason = Error_reason
            current_bisecting_result.last_buggy_res_str_l = last_buggy_res_l
            current_bisecting_result.last_buggy_res_flags_l = (
                last_buggy_all_result_flags
            )
            current_bisecting_result.final_res_flag = rn_correctness

            return current_bisecting_result

    @classmethod
    def cross_compare(cls, current_bisecting_result):
        current_commit_ID = current_bisecting_result.first_buggy_commit_id
        if current_commit_ID not in cls.all_unique_results_dict:
            cls.all_unique_results_dict[current_commit_ID] = cls.uniq_bug_id_int
            current_bisecting_result.uniq_bug_id_int = cls.uniq_bug_id_int
            cls.uniq_bug_id_int += 1
            return current_bisecting_result, False # Not duplicated results. 
        else:
            current_bug_id_int = cls.all_unique_results_dict[current_commit_ID]
            current_bisecting_result.uniq_bug_id_int = current_bug_id_int
            return current_bisecting_result, True # Duplicated results. 

    @classmethod
    def run_bisecting(cls, queries_l, oracle, vercon):
        log_out_line(
            "\n\n\nBeginning testing with query (sampled with only the first one): \n%s \n"
            % queries_l[0]
        )
        current_bisecting_result = cls.bi_secting_commits(
            queries_l=queries_l, oracle=oracle, vercon=vercon
        )
        is_dup_commit = True
        if not current_bisecting_result.is_bisecting_error:
            current_bisecting_result, is_dup_commit = cls.cross_compare(
                current_bisecting_result
            )  # The unique bug id will be appended to current_bisecting_result when running cross_compare
            if not is_dup_commit:
                IO.write_uniq_bugs_to_files(current_bisecting_result, oracle)
        else:
            current_bisecting_result.uniq_bug_id_int = (
                "Unknown"  # Unique bug id is Unknown. Meaning unsorted or unknown bug.
            )
            # IO.write_uniq_bugs_to_files(current_bisecting_result, oracle)
        return is_dup_commit

    @classmethod
    def pure_add_commit(cls, commit_id_l):
        for commit_id in commit_id_l:
            if commit_id != "Unknown":
                cls.all_unique_results_dict[commit_id] = cls.uniq_bug_id_int
                cls.uniq_bug_id_int += 1
