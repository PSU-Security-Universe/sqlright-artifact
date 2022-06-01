import sys

sys.path.insert(1, '../../Shared_Plots_Code')
from copy_funcs import * 

# Identify the fuzzing results directory.
postgres_results_dir = os.path.join(os.getcwd(), "../../../../PostgreSQL/Results")
if not os.path.exists(postgres_results_dir):
    print("The PostgreSQL Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_NOREC")
sqlancer_res_dir = os.path.join(postgres_results_dir, "sqlancer_postgres")
sqlancer_config_str = "sqlancer_postgres_NOREC"
squirrel_oracle_res_dir = os.path.join(postgres_results_dir, "squirrel_oracle_NOREC")


copy_sqlright_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_NoREC"))
copy_sqlancer_contents_in_dir(sqlancer_res_dir, sqlancer_config_str, os.path.join(os.getcwd(), "SQLancer"))
copy_sqlright_contents_in_dir(squirrel_oracle_res_dir, os.path.join(os.getcwd(), "../Comp_diff_tools_NoREC/Squirrel_with_oracle"))

