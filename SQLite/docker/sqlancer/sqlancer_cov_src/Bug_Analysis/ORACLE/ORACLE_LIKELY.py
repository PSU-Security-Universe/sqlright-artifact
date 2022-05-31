import re
from enum import Enum
from sys import maxsize

from Bug_Analysis.helper.data_struct import RESULT, is_string_only_whitespace


class VALID_TYPE_LIKELY(Enum):
    NORM = 1
    UNIQUE = 2


class Oracle_LIKELY:

    multi_exec_num = 1
    veri_vari_num = 3

    @staticmethod
    def retrive_all_results(result_str):
        if (
            result_str.count("BEGIN VERI") < 1
            or result_str.count("END VERI") < 1
            or is_string_only_whitespace(result_str)
            or result_str == ""
        ):
            return (
                None,
                RESULT.ALL_ERROR,
            )  # Missing the outputs from the opt or the unopt. Returnning None implying errors.

        # Grab all the ori results.
        ori_results = []
        begin_idx = []
        end_idx = []
        for m in re.finditer(r"BEGIN VERI 0", result_str):
            begin_idx.append(m.end())
        for m in re.finditer(r"END VERI 0", result_str):
            end_idx.append(m.start())
        for i in range(min(len(begin_idx), len(end_idx))):
            current_opt_result = result_str[begin_idx[i] : end_idx[i]]
            if "Error" in current_opt_result:
                ori_results.append("Error")
            else:
                ori_results.append(current_opt_result)

        # Grab all the LIKELY results.
        likely_results = []
        begin_idx = []
        end_idx = []
        for m in re.finditer(r"BEGIN VERI 1", result_str):
            begin_idx.append(m.end())
        for m in re.finditer(r"END VERI 1", result_str):
            end_idx.append(m.start())
        for i in range(min(len(begin_idx), len(end_idx))):
            current_unopt_result = result_str[begin_idx[i] : end_idx[i]]
            if "Error" in current_unopt_result:
                likely_results.append("Error")
            else:
                likely_results.append(current_unopt_result)

        # Grab all the UNLIKELY results.
        unlikely_results = []
        begin_idx = []
        end_idx = []
        for m in re.finditer(r"BEGIN VERI 2", result_str):
            begin_idx.append(m.end())
        for m in re.finditer(r"END VERI 2", result_str):
            end_idx.append(m.start())
        for i in range(min(len(begin_idx), len(end_idx))):
            current_unopt_result = result_str[begin_idx[i] : end_idx[i]]
            if "Error" in current_unopt_result:
                unlikely_results.append("Error")
            else:
                unlikely_results.append(current_unopt_result)

        all_results_out = []
        for i in range(min(len(ori_results), len(likely_results))):
            cur_results_out = [ori_results[i], likely_results[i], unlikely_results[i]]
            all_results_out.append(cur_results_out)

        return all_results_out, RESULT.PASS

    @classmethod
    def comp_query_res(cls, queries_l, all_res_str_l):
        queries = queries_l[0]
        valid_type_list = cls._get_valid_type_list(queries)

        # Has only one run through
        all_res_str_l = all_res_str_l[0]

        all_res_out = []
        final_res = RESULT.PASS

        for idx, valid_type in enumerate(valid_type_list):
            # print(opt_result)
            # if idx >= len(opt_result) or idx >= len(unopt_result):
            #     break
            if valid_type == VALID_TYPE_LIKELY.NORM:
                curr_res = cls._check_result_NORM(
                    all_res_str_l[idx][0], all_res_str_l[idx][1], all_res_str_l[idx][2]
                )
                all_res_out.append(curr_res)
            elif valid_type == VALID_TYPE_LIKELY.UNIQUE:
                curr_res = cls._check_result_UNIQ(
                    all_res_str_l[idx][0],
                    all_res_str_l[idx][1],
                    all_res_str_l[idx][2],
                    valid_type,
                )
                all_res_out.append(curr_res)
            else:
                raise ValueError(
                    "Encounter unknown VALID_TYPE_LIKELY in the check_query_exec_correctness_under_commitID func. "
                )

        for curr_res_out in all_res_out:
            if curr_res_out == RESULT.FAIL:
                final_res = RESULT.FAIL
                break

        is_all_query_return_errors = True
        for curr_res_out in all_res_out:
            if curr_res_out != RESULT.ERROR:
                is_all_query_return_errors = False
                break
        if is_all_query_return_errors:
            final_res = RESULT.ALL_ERROR

        return final_res, all_res_out

    @classmethod
    def _get_valid_type_list(cls, query: str):
        if (
            query.count("BEGIN VERI") < 1
            or query.count("END VERI") < 1
            or is_string_only_whitespace(query)
            or query == ""
        ):
            return []  # query is not making sense at all.

        # Grab all the opt queries, detect its valid_type, and return.
        valid_type_list = []
        begin_idx = []
        end_idx = []
        for m in re.finditer(r"SELECT 'BEGIN VERI 0';", query):
            begin_idx.append(m.end())
        for m in re.finditer(
            r"SELECT 'END VERI 0';", query
        ):  # Might contains additional unnecessary characters, such as SELECT in the SELECT 97531;
            end_idx.append(m.start())
        for i in range(min(len(begin_idx), len(end_idx))):
            current_opt_query = query[begin_idx[i] : end_idx[i]]
            valid_type_list.append(cls._get_valid_type(current_opt_query))

        return valid_type_list

    @classmethod
    def _get_valid_type(cls, query: str):
        if re.match(
            r"""^[\s;]*SELECT\s*(DISTINCT\s*)?MIN(.*?)$""", query, re.IGNORECASE
        ):
            # print("For query: %s, returning valid_type: MIN" % (query))
            return VALID_TYPE_LIKELY.UNIQUE
        elif re.match(
            r"""^[\s;]*SELECT\s*(DISTINCT\s*)?MAX(.*?)$""", query, re.IGNORECASE
        ):
            # print("For query: %s, returning VALID_TYPE_LIKELY: MAX" % (query))
            return VALID_TYPE_LIKELY.UNIQUE
        elif re.match(
            r"""^[\s;]*SELECT\s*(DISTINCT\s*)?SUM(.*?)$""", query, re.IGNORECASE
        ):
            # print("For query: %s, returning VALID_TYPE_LIKELY: SUM" % (query))
            return VALID_TYPE_LIKELY.UNIQUE
        elif re.match(
            r"""^[\s;]*SELECT\s*(DISTINCT\s*)?COUNT(.*?)$""", query, re.IGNORECASE
        ):
            # print("For query: %s, returning VALID_TYPE_LIKELY: COUNT" % (query))
            return VALID_TYPE_LIKELY.UNIQUE
        else:
            # print("For query: %s, returning VALID_TYPE_LIKELY: NORM" % (query))
            return VALID_TYPE_LIKELY.NORM

    @classmethod
    def _check_result_NORM(cls, ori: str, likely: str, unlikely: str) -> RESULT:
        if "Error" in ori or "Error" in likely or "Error" in unlikely:
            return RESULT.ERROR

        ori_out_int = 0
        likely_out_int = 0
        unlikely_out_int = 0

        ori_list = ori.split("\n")
        likely_list = likely.split("\n")
        unlikely_list = unlikely.split("\n")

        for cur_ori in ori_list:
            if re.match(
                r"""^[\|\s]*$""", cur_ori, re.MULTILINE | re.IGNORECASE
            ):  # Only spaces or | (separator)
                continue
            ori_out_int += 1
        for cur_likely in likely_list:
            if re.match(
                r"""^[\|\s]*$""", cur_likely, re.MULTILINE | re.IGNORECASE
            ):  # Only spaces or | (separator)
                continue
            likely_out_int += 1
        for cur_unlikely in unlikely_list:
            if re.match(
                r"""^[\|\s]*$""", cur_unlikely, re.MULTILINE | re.IGNORECASE
            ):  # Only spaces or | (separator)
                continue
            unlikely_out_int += 1

        if ori_out_int != likely_out_int or ori_out_int != unlikely_out_int:
            return RESULT.FAIL
        else:
            return RESULT.PASS

    @classmethod
    def _check_result_UNIQ(
        cls, ori: str, likely: str, unlikely: str, valid_type
    ) -> RESULT:
        if "Error" in ori or "Error" in likely or "Error" in unlikely:
            return RESULT.ERROR

        if ori != likely or ori != unlikely:
            return RESULT.FAIL
        else:
            return RESULT.PASS
