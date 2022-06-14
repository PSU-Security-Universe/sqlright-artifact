from typing import List, Tuple

import constants
import norec
from ORACLE import Oracle_NoREC
import reports
import utils
from loguru import logger
import os

uniq_bug_id_int = 0
all_unique_results_dict = dict()
all_previous_compile_failure = []


def check_query_execute_correctness(queries_l: List[str], hexsha: str):
    install_directory = os.path.join(constants.MYSQL_ROOT, hexsha)

    cur_mysqld_binary_dir = os.path.join(install_directory, "bin/mysqld")
    if not os.path.isfile(cur_mysqld_binary_dir):
        logger.warning("Cannot find MySQL version %s in the install_directory: %s" % (hexsha, install_directory))
        return constants.RESULT.SEG_FAULT, [], []
    
    mysql.start_mysqld_server(hexsha)

    all_res_str_l: List[str] = []
    for queries in queries_l:
        all_res_str, result = mysql.execute_queries(queries, hexsha)
        all_res_str_l.append(all_res_str)

    if result == constants.RESULT.SEG_FAULT:
        logger.debug("Commit Segmentation fault. \n")
        return constants.RESULT.SEG_FAULT, [], []

    if not all_res_str_l or result == constants.RESULT.ALL_ERROR:
        logger.debug("Result all Errors. \n")
        return constants.RESULT.ALL_ERROR, [], []

    final_flag, all_res_flags = Oracle_NoREC.comp_query_res(all_res_str_l)
    return final_flag, all_res_flags, all_res_str_l


def cross_compare(buggy_commit: str):
    global uniq_bug_id_int
    global all_unique_results_dict

    def get_valid_uniq_id():
        return (
            max(v for v in all_unique_results_dict.values()) + 1
            if all_unique_results_dict
            else 0
        )

    is_unique_commit = False
    if buggy_commit in all_unique_results_dict:
        return all_unique_results_dict[buggy_commit], is_unique_commit

    is_unique_commit = True
    uniq_id = get_valid_uniq_id()
    all_unique_results_dict[buggy_commit] = uniq_id

    return uniq_id, is_unique_commit


def start_bisect(queries: List[str], all_commits):
    # newer_tag_commit, older_tag_commit = bisect_tags(queries)
    # current_bisecting_result = bisect_commits(queries, newer_tag_commit, older_tag_commit)
    current_bisecting_result = bi_secting_commits(queries, all_commits)
    if current_bisecting_result.is_bisecting_error:
        # Unique bug id is Unknown. Meaning unsorted or unknown bug.
        # current_bisecting_result.uniq_bug_id_int = "Unknown"
        # reports.dump_unique_bugs(current_bisecting_result)
        return True

    # The unique bug id will be appended to current_bisecting_result when running cross_compare
    buggy_commit = current_bisecting_result.first_buggy_commit_id
    uniq_id, is_unique_commit = cross_compare(buggy_commit)
    current_bisecting_result.unique_bug_id_int = uniq_id

    if is_unique_commit:
        reports.dump_unique_bugs(current_bisecting_result)

    return is_unique_commit


def bisect_tags(queries: List[str]):
    all_commits_hexsha = vcs.get_all_commits_hexsha()
    all_sorted_tags = vcs.get_all_sorted_tags()

    # The oldest buggy commit, which is the commit that introduce the bug.
    newer_commit = ""
    # The latest correct commit.
    older_commit = ""

    for tagref in all_sorted_tags[::-1]:
        # From the latest tag to the earliest tag.
        commit_hexsha = tagref.commit.hexsha
        commit_index = all_commits_hexsha.index(commit_hexsha)
        is_successfully_executed = False
        is_commit_found = False

        while not is_successfully_executed:
            current_commit_str = all_commits_hexsha[commit_index]

            (
                rn_correctness,
                all_res_flags,
                all_res_str_l,
            ) = check_query_execute_correctness(queries, commit_hexsha)

            logger.info(
                f"[*] {rn_correctness} : {tagref} : {commit_index} : {commit_hexsha}"
            )

            if rn_correctness == constants.RESULT.PASS:  # Execution result is correct.
                is_successfully_executed = True
                is_commit_found = True
                logger.debug(f"For commit {current_commit_str}. Bisecting Pass. \n")
                break
            elif rn_correctness == constants.RESULT.FAIL:  # Execution result is buggy
                is_successfully_executed = True
                if all_res_str_l != None:
                    last_buggy_res_l = all_res_str_l
                last_buggy_all_result_flags = all_res_flags
                logger.debug(f"For commit {current_commit_str}. Bisecting Buggy. \n")
                break
            elif (
                rn_correctness == constants.RESULT.ALL_ERROR
            ):  # Execution queries all return errors. Treat it similar to execution result is correct.
                is_successfully_executed = True
                is_commit_found = True
                is_error_returned_from_exec = True
                logger.debug(
                    f"For commit {current_commit_str}. Bisecting ALL_ERROR. \n"
                )
                break
            elif rn_correctness == constants.RESULT.FAIL_TO_COMPILE:
                is_successfully_executed = False
                is_commit_found = False
                logger.debug(
                    f"For commit {current_commit_str}, Bisecting FAIL_TO_COMPILE. \n"
                )
                utils.dump_failed_commit(commit_hexsha)
                break
            else:
                is_successfully_executed = False
                is_commit_found = False
                is_error_returned_from_exec = True
                logger.debug(
                    f"For commit {current_commit_str}, Bisecting Segmentation Fault. \n"
                )
                break

        if is_commit_found:
            break

    logger.info(f"bisect tags: {newer_commit} - {older_commit}")
    return newer_commit, older_commit


def bisect_commits(queries: List[str], newer_tag_commit: str, older_tag_commit: str):
    last_buggy_res_l = None
    last_buggy_all_result_flags = None
    rn_correctness = constants.RESULT.PASS
    all_commits_str = vcs.get_all_commits_hexsha()

    newer_commit_index = all_commits_str.index(newer_tag_commit)
    older_commit_index = all_commits_str.index(older_tag_commit)

    logger.info(
        f"{older_tag_commit} : {older_commit_index} - {newer_commit_index} : {newer_tag_commit}"
    )

    is_buggy_commit_found = False
    while not is_buggy_commit_found:

        if (newer_commit_index - older_commit_index) <= 1:
            is_buggy_commit_found = True
            break

        # Approximate towards 0 (older).
        tmp_commit_index = int((newer_commit_index + older_commit_index) / 2)

        commit_hexsha = all_commits_str[tmp_commit_index]
        older_commit_str = all_commits_str[older_commit_index]
        newer_commit_str = all_commits_str[newer_commit_index]
        logger.info(
            f"{older_commit_str} : {older_commit_index} - {tmp_commit_index} {commit_hexsha} - {newer_commit_index} : {newer_commit_str}"
        )

        (
            rn_correctness,
            all_result_flags,
            all_result_strings,
        ) = check_query_execute_correctness(queries, commit_hexsha)

        logger.info(f"[*] {rn_correctness} : {tmp_commit_index} : {commit_hexsha}")

        if any(
            [
                rn_correctness == constants.RESULT.FAIL,
                rn_correctness == constants.RESULT.FAIL_TO_COMPILE,
                # Compilation failed or Segmentation Fault!!!!
                # rn_correctness == -2. Treat it as RESULT.FAIL.
                not constants.RESULT.has_value(rn_correctness),
            ]
        ):
            newer_commit_index = tmp_commit_index

            if rn_correctness == constants.RESULT.FAIL:
                if all_result_strings:
                    last_buggy_res_l = all_result_strings
                last_buggy_all_result_flags = all_result_flags

            if rn_correctness == constants.RESULT.FAIL_TO_COMPILE:
                utils.dump_failed_commit(commit_hexsha)

        if rn_correctness in (constants.RESULT.PASS, constants.RESULT.ERROR):
            # The correct version.
            older_commit_index = tmp_commit_index

    current_bisecting_result = constants.BisectingResults()

    current_bisecting_result.query = queries
    current_bisecting_result.last_buggy_res_str_l = last_buggy_res_l
    current_bisecting_result.last_buggy_res_flags_l = last_buggy_all_result_flags
    current_bisecting_result.final_res_flag = rn_correctness

    current_bisecting_result.is_bisecting_error = bool(not is_buggy_commit_found)

    if is_buggy_commit_found:
        buggy_commit = all_commits_str[newer_commit_index]
        correct_commit = all_commits_str[older_commit_index]
        logger.info(
            f"Found the bug introduced commit: {buggy_commit} \n\n\n"
            f"Found the correct commit: {correct_commit} \n\n\n"
        )
        current_bisecting_result.first_buggy_commit_id = buggy_commit
        current_bisecting_result.first_corr_commit_id = correct_commit
    else:
        Error_reason = "Error: Returnning is_buggy_commit_found == False. Possibly related to compilation failure. \n\n\n"
        logger.debug(Error_reason)
        current_bisecting_result.bisecting_error_reason = Error_reason

    return current_bisecting_result


def bi_secting_commits(queries: List[str], all_commits_str):
    # Returns Bug introduce commit_ID:str, is_error_result:bool
    all_commits_str
    # The oldest buggy commit, which is the commit that introduce the bug.
    newer_commit_str = all_commits_str[0]  # The oldest buggy commit.
    older_commit_str = all_commits_str[-1]  # The latest correct commit.
    newer_commit_index = 0
    older_commit_index = len(all_commits_str)-1
    last_buggy_res_l = None
    last_buggy_all_result_flags = None
    is_error_returned_from_exec = False
    current_commit_str = ""

    rn_correctness = constants.RESULT.PASS

    current_bisecting_result = constants.BisectingResults()

    is_buggy_commit_found = False

    logger.debug("Bisecting on pre-compiled binaries. \n")

    while not is_buggy_commit_found:
        if abs(newer_commit_index - older_commit_index) <= 1:
            logger.debug(
                f"found buggy_commit: {newer_commit_index} : {older_commit_index}"
            )
            is_buggy_commit_found = True
            break

        # Approximate towards 0 (older).
        tmp_commit_index = int((newer_commit_index + older_commit_index) / 2)

        is_successfully_executed = False
        while not is_successfully_executed:
            commit_ID = all_commits_str[tmp_commit_index]
            (
                rn_correctness,
                all_res_flags,
                all_res_str_l,
            ) = check_query_execute_correctness(queries, commit_ID)
            if rn_correctness == constants.RESULT.PASS:  # The correct version.
                older_commit_index = tmp_commit_index
                is_successfully_executed = True
                logger.debug(f"For commit {commit_ID}. Bisecting Pass. \n")
                break
            elif rn_correctness == constants.RESULT.FAIL:  # The buggy version.
                newer_commit_index = tmp_commit_index
                is_successfully_executed = True
                if all_res_str_l != None:
                    last_buggy_res_l = all_res_str_l
                last_buggy_all_result_flags = all_res_flags
                logger.debug(f"For commit {commit_ID}. Bisecting Buggy. \n")
                break
            elif rn_correctness == constants.RESULT.ERROR:
                older_commit_index = tmp_commit_index
                is_successfully_executed = True
                is_error_returned_from_exec = True
                logger.debug(f"For commit {commit_ID}. Bisecting ERROR. \n")
                break
            elif rn_correctness == constants.RESULT.FAIL_TO_COMPILE:
                newer_commit_index = tmp_commit_index
                is_successfully_executed = False
                is_error_returned_from_exec = True

                logger.debug(f"For commit {commit_ID}. Bisecting FAIL_TO_COMPILE. \n")
                utils.dump_failed_commit(commit_ID)
                break
            else:
                older_commit_index = tmp_commit_index
                is_successfully_executed = False
                is_error_returned_from_exec = True
                logger.debug(
                    f"For commit {commit_ID}, Bisecting Segmentation Fault. \n"
                )
                break

    if is_buggy_commit_found:
        logger.info(
            "Found the bug introduced commit: %s \n\n\n"
            % (all_commits_str[newer_commit_index])
        )
        logger.info(
            f"Found the correct commit: {all_commits_str[older_commit_index]} \n\n\n"
        )

        current_bisecting_result.query = queries
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
        # logger.debug("All_res_str_l: " + str(current_bisecting_result.last_buggy_res_str_l) + "\n")
        current_bisecting_result.last_buggy_res_flags_l = last_buggy_all_result_flags
        # logger.debug("All_res_flags: " + str(current_bisecting_result.last_buggy_res_flags_l) + "\n")
        current_bisecting_result.final_res_flag = rn_correctness

        return current_bisecting_result
    else:
        Error_reason = "Error: Returnning is_buggy_commit_found == False. Possibly related to compilation failure. \n\n\n"
        logger.debug(Error_reason)

        current_bisecting_result.query = queries
        current_bisecting_result.is_error_returned_from_exec = (
            is_error_returned_from_exec
        )
        current_bisecting_result.is_bisecting_error = True
        current_bisecting_result.bisecting_error_reason = Error_reason
        current_bisecting_result.last_buggy_res_str_l = last_buggy_res_l
        current_bisecting_result.last_buggy_res_flags_l = last_buggy_all_result_flags
        current_bisecting_result.final_res_flag = rn_correctness

        return current_bisecting_result
