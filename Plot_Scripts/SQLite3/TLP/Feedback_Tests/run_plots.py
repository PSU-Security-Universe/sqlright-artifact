import os
import subprocess

all_py = ["map_size.py", "correct_rate.py", "correct_rate_over_time.py", "bug_num.py"]

for cur_py in all_py:
    print("Running on dir: '%s' with file : '%s'" % (os.getcwd(), cur_py))
    p = subprocess.Popen(
        ["python3", os.path.join(os.getcwd(), cur_py)],
        cwd = os.getcwd()
    )
    p.wait()
print("Finished")
