import os
import shutil

# Identify the fuzzing results directory.
postgres_results_dir = os.path.join(os.getcwd(), "../../../../PostgreSQL/Results")
if not os.path.exists(postgres_results_dir):
    print("The PostgreSQL Results folder doesn't exist. Please run the fuzzing first, and then invoke this plot function.")
    exit(1)

sqlright_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_NOREC")
no_ctx_valid_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_no_ctx_valid_NOREC")
no_db_par_ctx_valid_res_dir = os.path.join(postgres_results_dir, "sqlright_postgres_no_db_par_ctx_valid_NOREC")
squirrel_oracle_res_dir = os.path.join(postgres_results_dir, "squirrel_oracle_NOREC")

# copy function
def copy_contents_in_dir(src:str, dest:str):
    if not os.path.exists(src):
        print("The %s folder doesn't exist. Please run the fuzzing first, and then invoke this plot function." % (src))
    if not os.path.exists(dest):
        print("The %s folder doesn't exist. Please run the fuzzing first, and then invoke this plot function." % (dest))

    i = 0
    for out_dir in os.listdir(src):
        dir = os.path.join(src, out_dir)
        if out_dir[:7] != "outputs" or not os.path.isdir(dir):
            continue
        plot_file = os.path.join(dir, "plot_data")

        # actual copy
        shutil.copy(plot_file, os.path.join(dest, "plot_data_%d" % (i)))
        i += 1
    print("Copy from %s to %s finished. \n" % (src, dest))
    
#copy_contents_in_dir(sqlright_res_dir, os.path.join(os.getcwd(), "../SQLRight_NoREC"))
copy_contents_in_dir(no_ctx_valid_res_dir, os.path.join(os.getcwd(), "./SQLRight_with_squ_valid"))
copy_contents_in_dir(no_db_par_ctx_valid_res_dir, os.path.join(os.getcwd(), "./SQLRight_with_squ_parser"))
copy_contents_in_dir(squirrel_oracle_res_dir, os.path.join(os.getcwd(), "../Comp_diff_tools_NoREC/Squirrel_with_oracle"))

