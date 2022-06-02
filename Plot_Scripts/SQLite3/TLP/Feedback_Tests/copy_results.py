import sys

sys.path.insert(1, '../../Shared_Plots_Code')
from copy_funcs import * 

# Identify the fuzzing results directory.
sqlite_results_dir = os.path.join(os.getcwd(), "../../../../SQLite/Results")
if not os.path.exists(sqlite_results_dir):
    print("The SQLite Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(sqlite_results_dir, "sqlright_sqlite_TLP")
drop_all_res_dir = os.path.join(sqlite_results_dir, "sqlright_sqlite_drop_all_TLP")
random_save_res_dir = os.path.join(sqlite_results_dir, "sqlright_sqlite_random_save_TLP")
save_all_res_dir = os.path.join(sqlite_results_dir, "sqlright_sqlite_save_all_TLP")

copy_sqlright_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_TLP"))
copy_sqlright_contents_in_dir(drop_all_res_dir, os.path.join(os.getcwd(), "drop_all"))
copy_sqlright_contents_in_dir(random_save_res_dir, os.path.join(os.getcwd(), "random_save"))
copy_sqlright_contents_in_dir(save_all_res_dir, os.path.join(os.getcwd(), "save_all"))

