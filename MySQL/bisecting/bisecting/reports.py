import os
import re
from typing import List

import constants
from loguru import logger


def read_queries_from_files():
    mysql_samples = constants.BISECTING_BUG_SAMPLES
    sample_files = [sample for sample in mysql_samples.glob("*")]
    sample_files = list(filter(lambda x: x.is_file(), sample_files))
    sample_files.sort(key=os.path.getctime)

    def get_contents(file):
        with open(file, errors="replace") as f:
            contents = f.read()

        contents = re.sub(r"[^\x00-\x7F]+", " ", contents)
        contents = contents.replace("\ufffd", " ")
        return contents

    def get_queries(contents):
        # HACK: Improve it.
        current_queries_out = ""
        is_adding = False
        output_all_queries = []
        for query in contents.splitlines():
            if "Result string" in query:
                is_adding = False
                output_all_queries.append(current_queries_out)
                current_queries_out = ""
                continue
            if not re.search(r"\w", query):
                continue
            if "Query" in query or query in (";", " ", "", "\n"):
                is_adding = True
                continue
            if is_adding:
                current_queries_out += query + " \n"
        return output_all_queries

    def seperate_queries(output_all_queries):
        """Next, separate the SELECT statements into different query sequences.
        If one buggy query contains multiple SELECT oracle mismatch,
        these mismatches could due to different reasons,
        """
        output_all_queries_tmp = []
        for cur_query in output_all_queries:
            cur_query_l = cur_query.split("SELECT 'BEGIN VERI 0';")
            database_management_queries = cur_query_l[0]
            for i in range(1, len(cur_query_l)):
                output_queries_out = (
                    database_management_queries + "SELECT 'BEGIN VERI 0';"
                )
                output_queries_out += cur_query_l[i]
                if (i - 1) >= len(output_all_queries_tmp):
                    new_list_tmp = []
                    new_list_tmp.append(output_queries_out)
                    output_all_queries_tmp.append(new_list_tmp)
                else:
                    output_all_queries_tmp[i - 1].append(output_queries_out)

        return output_all_queries_tmp

    def debug_print_queries(queries):
        logger.debug("print queries for debug purpose. \n")
        for cur_output_query in queries:
            for cur_query in cur_output_query:
                logger.debug(cur_query)

            logger.debug("\n\n\n")

    for index, sample in enumerate(sample_files):
        logger.debug(f"Got sample - {index}: {sample}")
        sample_contents = get_contents(sample)
        sample_queries = get_queries(sample_contents)
        sample_queries = seperate_queries(sample_queries)
        debug_print_queries(sample_queries)
        yield sample, sample_queries

    logger.debug("Finished reading all the query files from the bug_samples folder. ")


def dumps_inconsistent_queries(query: str, same_result_query_index: List[int]):
    logger.debug(f"Original query is: \n{query}\n")

    def _get_verify_queries_pairs(query: str) -> List[List[str]]:
        begin_verify_pattern = r"SELECT 'BEGIN VERI [0-9]';"
        end_verify_pattern = r"SELECT 'END VERI [0-9]';"

        # Grab all the verification queries.
        begin_indexes = [m.end() for m in re.finditer(begin_verify_pattern, query)]
        end_indexes = [m.start() for m in re.finditer(end_verify_pattern, query)]

        if len(begin_indexes) != len(end_indexes):
            logger.warning(
                f"the number of 'BEGIN VERI [0-9]' is not "
                f"equal to the number of 'END VERI [0-9]'."
            )

        statements = [query[b:e] for b, e in zip(begin_indexes, end_indexes)]
        statements = map(lambda stmt: stmt.replace("\n", "").strip(), statements)
        statements = list(filter(lambda stmt: stmt, statements))
        # split the list into group of two query.
        queries_pairs = [statements[i : i + 2] for i in range(0, len(statements), 2)]

        logger.debug(f"Got {len(queries_pairs)} pairs of verify queries.")
        return queries_pairs

    verify_queries_pairs = _get_verify_queries_pairs(query)
    valid_index_range = {idx for idx in range(len(verify_queries_pairs))}
    valid_index_range = valid_index_range - set(same_result_query_index)

    start_of_norec = query.find("SELECT 'BEGIN VERI 0';")
    header = query[:start_of_norec]
    tail = "\n" * 4
    for idx in valid_index_range:
        pairs = verify_queries_pairs[idx]
        tail += f'SELECT "--------- {idx} '
        for stmt in pairs:
            tail += stmt
            tail += " " * 4

        tail += "\n"

    return header + tail


def dump_unique_bugs(current_bisecting_result: constants.BisectingResults):
    def _pretty_process(bisecting_result: constants.BisectingResults):

        if not bisecting_result.last_buggy_res_str_l:
            return

        # Ignore the result with the same output, and ignore the result that
        # are negative. (-1 Error Execution for most cases)
        consistent_queries_indexes = [
            idx
            for idx, result in enumerate(bisecting_result.last_buggy_res_flags_l)
            if result != constants.RESULT.FAIL
        ]

        logger.debug(f"res_flags: {bisecting_result.last_buggy_res_flags_l}")
        logger.debug(f"same_idx: {consistent_queries_indexes}")
        logger.debug(f"res: {bisecting_result.last_buggy_res_str_l}")

        bisecting_result.query = list(
            map(
                lambda q: dumps_inconsistent_queries(q, consistent_queries_indexes),
                bisecting_result.query,
            )
        )

        # HACK: improve it.
        consistent_queries_indexes.reverse()
        for i in consistent_queries_indexes:
            for j in range(len(bisecting_result.last_buggy_res_str_l)):
                if i >= len(bisecting_result.last_buggy_res_str_l[j]):
                    # sometimes the idx can larger than
                    # the length of last_buggy_res_str_l[j]
                    continue
                bisecting_result.last_buggy_res_str_l[j].pop(i)

    _pretty_process(current_bisecting_result)

    report_contents = []
    report_contents.append("-------------------------------\n")
    report_contents.append(f"Bug ID: {current_bisecting_result.unique_bug_id_int}.\n\n")
    for idx, query in enumerate(current_bisecting_result.query):
        report_contents.append(f"Query {idx}:")
        report_contents.append(query)

    if current_bisecting_result.final_res_flag == constants.RESULT.SEG_FAULT:
        report_contents.append(
            "Error: The early commit failed to compile, or crashing. "
            "Failed to find the bug introduced commit."
        )

    if current_bisecting_result.last_buggy_res_str_l:
        for i, cur_run_res in enumerate(current_bisecting_result.last_buggy_res_str_l):
            for j, cur_res in enumerate(cur_run_res):
                report_contents.append(f"Last Buggy Result Num: {j}")
                for k, cur_r in enumerate(cur_res):
                    report_contents.append(f"RES {k}: \n{cur_r[0]}")

    else:
        report_contents.append(
            "Last buggy results: None. Possibly because the latest commit already fix the bug."
        )
        report_contents.append("")

    if current_bisecting_result.first_buggy_commit_id:
        report_contents.append(
            f"First buggy commit ID: {current_bisecting_result.first_buggy_commit_id}"
        )
    else:
        report_contents.append("First buggy commit ID:Unknown\n\n")

    if current_bisecting_result.first_corr_commit_id:
        report_contents.append(
            f"First correct (or crashing) commit ID: {current_bisecting_result.first_corr_commit_id}"
        )
    else:
        report_contents.append("First correct commit ID:Unknown\n\n")

    if (
        current_bisecting_result.is_bisecting_error
        or current_bisecting_result.bisecting_error_reason
    ):
        report_contents.append(
            "Bisecting Error. \n\n"
            f"Besecting error reason: {current_bisecting_result.bisecting_error_reason}. \n"
        )

    bug_id = current_bisecting_result.unique_bug_id_int
    current_unique_bug_output = constants.UNIQUE_BUG_OUTPUT_DIR / f"bug_{bug_id}"
    with open(current_unique_bug_output, "a+") as f:
        f.write("\n".join(report_contents))
