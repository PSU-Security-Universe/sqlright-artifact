import os
import sys
import shutil

# copy function
def copy_sqlright_contents_in_dir(src:str, dest:str):
    # Copy the plot_data files
    if not os.path.exists(src):
        print("\n\n\nError: The %s folder doesn't exist. Please run the fuzzing first, and then invoke this plot function. \n\n\n" % (src))
        exit(5)
    if not os.path.exists(dest):
        print("Warning: The copy dest: %s folder doesn't exist. Creating the folder %s." % (dest, dest))
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
        print("\n\n\n Warning: time.txt file from: %s not exists. It could be due to the bisecting algorithm not run, or the bisecting bug number is None. Double check whether the bisecting algorithm is called. \n\n\n" % (bug_time_src))
        print("Copy from %s to %s finished. \n" % (src, dest))
        return
        #exit(1)
    bug_time_src = os.path.join(bug_time_src, "time.txt")
    if not os.path.isfile(bug_time_src):
        print("\n\n\n Warning: time.txt file from: %s not exists. It could be due to the bisecting algorithm not run, or the bisecting bug number is None (a more possible reason). Double check whether the bisecting algorithm is called. \n\n\n" % (bug_time_src))
    else:
        shutil.copy(bug_time_src, os.path.join(dest, "time.txt"))

    print("Copy from %s to %s finished. \n" % (src, dest))

def copy_sqlancer_contents_in_dir(src:str, config_name: str, dest:str):
    if not os.path.exists(src):
        print("\n\n\n Error: The %s folder doesn't exist. Please run the fuzzing first, and then invoke this plot function. \n\n\n" % (src))
        exit(5)
    if not os.path.exists(dest):
        print("Warning: The copy dest: %s folder doesn't exist. Creating the folder %s." % (dest))
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
