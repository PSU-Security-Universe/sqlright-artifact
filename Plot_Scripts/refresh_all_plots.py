import os
import subprocess

ori_dir = os.getcwd()

for subdir, dirs, files in os.walk("./"):
    for file in files:
        
        # cur_file = os.path.join(subdir, file)
        cur_file = file
        if cur_file[-2:] == "py" and "refresh_all_plots" not in cur_file:
            print("Change dir: %s, running: %s" % (subdir, file))
            p = subprocess.Popen(
                ["python3", cur_file],
                cwd = subdir
            )
            p.wait()
            print("Finished")
        

