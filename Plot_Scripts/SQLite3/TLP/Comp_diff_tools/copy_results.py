import sys

sys.path.insert(1, '../../Shared_Plots_Code')
from copy_funcs import * 

# Identify the fuzzing results directory.
sqlite_results_dir = os.path.join(os.getcwd(), "../../../../SQLite/Results")
if not os.path.exists(sqlite_results_dir):
    print("The SQLite Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(sqlite_results_dir, "sqlright_sqlite_TLP")
sqlancer_res_dir = os.path.join(sqlite_results_dir, "sqlancer_sqlite")
sqlancer_config_str = "sqlancer_sqlite_TLP"
squirrel_oracle_res_dir = os.path.join(sqlite_results_dir, "squirrel_oracle_TLP")


copy_sqlright_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_TLP"))
copy_sqlancer_contents_in_dir(sqlancer_res_dir, sqlancer_config_str, os.path.join(os.getcwd(), "SQLancer_TLP"))
copy_sqlright_contents_in_dir(squirrel_oracle_res_dir, os.path.join(os.getcwd(), "../Comp_diff_tools/Squirrel_with_oracle"))

