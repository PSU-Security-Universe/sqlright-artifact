import sys

sys.path.insert(1, '../../Shared_Plots_Code')
from copy_funcs import * 

# Identify the fuzzing results directory.
mysql_results_dir = os.path.join(os.getcwd(), "../../../../MySQL/Results")
if not os.path.exists(mysql_results_dir):
    print("The MySQL Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(mysql_results_dir, "sqlright_mysql_NOREC")
squirrel_oracle_res_dir = os.path.join(mysql_results_dir, "squirrel_oracle_NOREC")


copy_sqlright_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_MySQL_NoREC"))
copy_sqlright_contents_in_dir(squirrel_oracle_res_dir, os.path.join(os.getcwd(), "squirrel"))

