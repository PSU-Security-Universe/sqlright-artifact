import os
import sys
import shutil

# copy function
def copy_sqlright_contents_in_dir(src:str, dest:str):
    # Copy the plot_data files
    if not os.path.exists(src):
        print("The %s folder doesn't exist. Please run the fuzzing first, and then invoke this plot function." % (src))
        exit(5)
    if not os.path.exists(dest):
        print("The copy dest: %s folder doesn't exist. Creating the folder %s." % (dest, dest))
        os.mkdir(dest)

    i = 0
    for out_dir in os.listdir(src):
        dir = os.path.join(src, out_dir)
        if out_dir[:7] != "outputs" or not os.path.isdir(dir):
            continue
        plot_file = os.path.join(dir, "plot_data")

        # actual copy
        shutil.copy(plot_file, os.path.join(dest, "plot_data_%d" % (i)))
        i += 1
    
    if src[-1] == "/":
        src = src[:-1]
    bug_time_src = src + "_bugs"

    bug_time_src = os.path.join(bug_time_src, "bug_samples/unique_bug_output")
    if not os.path.isdir(bug_time_src):
        print("Error: time.txt file from: %s not exists. Please run the bisecting algorithm first before calling the copy_results.py. " % (bug_time_src))
        print("Copy from %s to %s finished. \n" % (src, dest))
        return
        #exit(1)
    bug_time_src = os.path.join(bug_time_src, "time.txt")
    if not os.path.isfile(bug_time_src):
        print("Warning: time.txt file from: %s not exists. Did you finish the bisecting algorithm? " % (bug_time_src))
    else:
        shutil.copy(bug_time_src, os.path.join(dest, "time.txt"))

    print("Copy from %s to %s finished. \n" % (src, dest))

def copy_sqlancer_contents_in_dir(src:str, config_name: str, dest:str):
    if not os.path.exists(src):
        print("The %s folder doesn't exist. Please run the fuzzing first, and then invoke this plot function." % (src))
    if not os.path.exists(dest):
        print("The copy dest: %s folder doesn't exist. Creating the folder %s." % (dest))
        os.mkdir(dest)

    i = 0
    for out_dir in os.listdir(src):
        if config_name not in out_dir or "cov" not in out_dir:
            continue
        dir = os.path.join(src, out_dir)
        if not os.path.isdir(dir):
            continue
        plot_file = os.path.join(dir, "plot_data")

        # actual copy
        shutil.copy(plot_file, os.path.join(dest, "plot_data_%d" % (i)))
        i += 1

    i = 0
    for out_dir in os.listdir(src):
        if config_name not in out_dir or "raw" not in out_dir:
            continue
        dir = os.path.join(src, out_dir)
        if not os.path.isdir(dir):
            continue
        plot_file = os.path.join(dir, "output.txt")

        # actual copy
        shutil.copy(plot_file, os.path.join(dest, "logs_%d" % (i)))
        i += 1
    print("Copy from %s to %s finished. \n" % (src, dest))
