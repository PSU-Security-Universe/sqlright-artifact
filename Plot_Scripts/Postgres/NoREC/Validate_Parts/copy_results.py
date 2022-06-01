import sys

sys.path.insert(1, '../../Shared_Plots_Code')
from copy_funcs import * 

# Identify the fuzzing results directory.
postgres_results_dir = os.path.join(os.getcwd(), "../../../../PostgreSQL/Results")
if not os.path.exists(postgres_results_dir):
    print("The PostgreSQL Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_NOREC")
no_ctx_valid_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_no_ctx_valid_NOREC")
no_db_par_ctx_valid_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_no_db_par_ctx_valid_NOREC")
squirrel_oracle_res_dir = os.path.join(postgres_results_dir, "squirrel_oracle_NOREC")


copy_sqlright_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_NoREC"))
copy_sqlright_contents_in_dir(no_ctx_valid_res_dir, os.path.join(os.getcwd(), "./SQLRight_with_squ_valid"))
copy_sqlright_contents_in_dir(no_db_par_ctx_valid_res_dir, os.path.join(os.getcwd(), "./SQLRight_with_squ_parser"))
copy_sqlright_contents_in_dir(squirrel_oracle_res_dir, os.path.join(os.getcwd(), "../Comp_diff_tools_NoREC/Squirrel_with_oracle"))

