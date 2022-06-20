import os
import subprocess

ori_dir = os.getcwd()

for subdir, dirs, files in os.walk("./"):
    for cur_file in files:
        if cur_file[-2:] == "py" and "refresh_all_plots" not in cur_file:
            if "copy_results.py" in cur_file: # Only calls run_plots.py
                print("Change dir: %s, running: copy_results.py and run_plots.py" % (subdir))
                p = subprocess.Popen(
                    ["python3", cur_file],
                    cwd = subdir
                )
                p.wait()

                run_plot = "run_plots.py"
                p = subprocess.Popen(
                    ["python3", cur_file],
                    cwd = subdir
                )
                p.wait()

print("Finished all plots.")
        

