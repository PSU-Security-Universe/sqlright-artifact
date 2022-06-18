import sys

sys.path.insert(1, '../../Shared_Plots_Code')
from copy_funcs import * 

# Identify the fuzzing results directory.
mysql_results_dir = os.path.join(os.getcwd(), "../../../../MySQL/Results")
if not os.path.exists(mysql_results_dir):
    print("The MySQL Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(mysql_results_dir, "sqlright_mysql_NOREC")
sqlright_non_deter_res_dir = os.path.join(mysql_results_dir, "sqlright_mysql_NOREC_non_deter")
no_ctx_valid_res_dir = os.path.join(mysql_results_dir, "sqlright_mysql_no_ctx_valid_NOREC")
no_db_par_ctx_valid_res_dir = os.path.join(mysql_results_dir, "sqlright_mysql_no_db_par_ctx_valid_NOREC")
squirrel_oracle_res_dir = os.path.join(mysql_results_dir, "squirrel_oracle_NOREC")


copy_sqlright_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_MySQL_NoREC"))
copy_sqlright_contents_in_dir(sqlright_non_deter_res_dir, os.path.join(os.getcwd(), "./non_deter"))
copy_sqlright_contents_in_dir(no_ctx_valid_res_dir, os.path.join(os.getcwd(), "./SQLRight_with_squ_valid"))
copy_sqlright_contents_in_dir(no_db_par_ctx_valid_res_dir, os.path.join(os.getcwd(), "./SQLRight_with_squ_parser"))
copy_sqlright_contents_in_dir(squirrel_oracle_res_dir, os.path.join(os.getcwd(), "../Comp_diff_tools/squirrel"))

