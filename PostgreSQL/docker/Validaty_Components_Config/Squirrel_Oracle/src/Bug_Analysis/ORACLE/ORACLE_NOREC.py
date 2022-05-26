import re
from pprint import pprint

from Bug_Analysis.helper.data_struct import RESULT, is_string_only_whitespace, log_out_line


class Oracle_NOREC:

    multi_exec_num = 1
    veri_vari_num = 2

    @staticmethod
    def retrive_all_results(result_str):
        if (
            result_str.count("BEGIN VERI") < 1
            or result_str.count("END VERI") < 1
            # or is_string_only_whitespace(result_str)
            or result_str == ""
        ):
            return (
                None,
                RESULT.ALL_ERROR,
            )  # Missing the outputs from the opt or the unopt. Returnning None implying errors.

        result_lines = result_str.splitlines()
        
        # Grab all the opt results.
        opt_results = []
        begin_idx = []
        end_idx = []

        for idx, line in enumerate(result_lines):
            if "BEGIN VERI 0" in line:
                begin_idx.append(idx)

        for idx, line in enumerate(result_lines):
            if "END VERI 0" in line:
                end_idx.append(idx)

        if len(begin_idx) != len(end_idx):
            log_out_line("[!] the number of 'BEGIN VERI 0' is not equal to the number of 'END VERI 0'.")
        
        for i in range(len(begin_idx)):
            current_opt_result_lines = result_lines[begin_idx[i]+1 : end_idx[i]]
            # strip 
            current_opt_result_lines = [line.strip() for line in current_opt_result_lines if line.strip().startswith('1:')]
            if not current_opt_result_lines:
                current_opt_result_int = [-1]
                opt_results.append(current_opt_result_int)
                continue 

            current_opt_result_lines = [line[line.find("=", 1)+1: line.find('(')] for line in current_opt_result_lines]
            current_opt_result_lines = [line.strip().strip('"') for line in current_opt_result_lines]
            # print(current_opt_result_lines)
            # print()
            # input()
            
            try:
                current_opt_result_int = [int(num) for num in current_opt_result_lines]
            except ValueError:
                current_opt_result_int = [-1]
            opt_results.append(current_opt_result_int)
        
        

        # Grab all the unopt results.
        unopt_results = []
        begin_idx = []
        end_idx = []

        for idx, line in enumerate(result_lines):
            if "BEGIN VERI 1" in line:
                begin_idx.append(idx)

        for idx, line in enumerate(result_lines):
            if "END VERI 1" in line:
                end_idx.append(idx)
                
        if len(begin_idx) != len(end_idx):
            log_out_line("[!] the number of 'BEGIN VERI 0' is not equal to the number of 'END VERI 0'.")
        
        for i in range(len(begin_idx)):
            current_unopt_result_lines = result_lines[begin_idx[i]+1 : end_idx[i]]
            # strip 
            current_unopt_result_lines = [line.strip() for line in current_unopt_result_lines if line.strip().startswith('1:')]
            if not current_unopt_result_lines:
                current_unopt_result_int = [-1]
                unopt_results.append(current_unopt_result_int)
                continue 

            current_unopt_result_lines = [line[line.find("=", 1)+1: line.find('(')] for line in current_unopt_result_lines]
            current_unopt_result_lines = [line.strip().strip('"') for line in current_unopt_result_lines]
            # print(current_unopt_result_lines)
            # print()
            # input()
            
            try:
                # Add 0.0001 to avoid inaccurate float to int transform. Transform are towards 0.
                current_unopt_result_int = [int(float(num) + 0.0001) for num in current_unopt_result_lines]
            except ValueError:
                current_unopt_result_int = [-1]
            unopt_results.append(current_unopt_result_int)

        all_results_out = []
        for i in range(min(len(opt_results), len(unopt_results))):
            cur_results_out = [opt_results[i], unopt_results[i]]
            all_results_out.append(cur_results_out)

        # pprint(all_results_out)
        return all_results_out, RESULT.PASS

    @classmethod
    def comp_query_res(cls, queries_l, all_res_lll):
        # Has only one run through
        all_res_ll = all_res_lll[0]

        all_res_out = []
        final_res = RESULT.PASS

        for cur_res_l in all_res_ll:
            opt_int_l = cur_res_l[0]
            unopt_int_l = cur_res_l[1]

            # skip wrong oracle query result
            if len(opt_int_l) > 1 or len(unopt_int_l) > 1:
                continue
            
            opt_int = opt_int_l[0]
            unopt_int = unopt_int_l[0]

            if opt_int == -1 or unopt_int == -1:
                all_res_out.append(RESULT.ERROR)
            elif opt_int != unopt_int:
                all_res_out.append(RESULT.FAIL)
            else:
                all_res_out.append(RESULT.PASS)

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
