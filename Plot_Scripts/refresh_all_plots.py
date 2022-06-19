import os
import subprocess

ori_dir = os.getcwd()

for subdir, dirs, files in os.walk("./"):
    for cur_file in files:
        if cur_file[-2:] == "py" and "refresh_all_plots" not in cur_file:
            if "run_plot" in cur_file: # Only calls run_plots.py
                print("Change dir: %s, running: %s" % (subdir, cur_file))
                p = subprocess.Popen(
                    ["python3", cur_file],
                    cwd = subdir
                )
                p.wait()

print("Finished all plots.")
        

