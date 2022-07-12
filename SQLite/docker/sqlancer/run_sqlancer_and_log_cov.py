import os
import shutil
import subprocess
import atexit
import time
import sys
import getopt

# Parse the command line arguments:
output_dir_str = "./outputs_0"
oracle_str = "NoREC"
feedback_str = ""

try:
    opts, args = getopt.getopt(sys.argv[1:], "o:c:n:O:F:", ["odir=", "start-core=", "num-concurrent=", "oracle=", "feedback="])
except getopt.GetoptError:
    print("Arguments parsing error")
    exit(1)
for opt, arg in opts:
    if opt in ("-o", "--odir"):
        output_dir_str = arg
        print("Using output dir: %s" % (output_dir_str))
    elif opt in ("-c", "--start-core"):
        # ignored
        pass
    elif opt in ("-n", "--num-concurrent"):
        # ignored
        pass
    elif opt in ("-O", "--oracle"):
        if arg == "NOREC" or arg == "NoREC":
            oracle_str = "NoREC"
        elif arg == "TLP" or arg == "QUERY_PARTITIONING":
            oracle_str = "QUERY_PARTITIONING"
        print("Using oracle: %s " % (oracle_str))
    elif opt in ("-F", "--feedback"):
        # ignored
        pass
    else:
        print("Error. Input arguments not supported. \n")
        exit(1)

sys.stdout.flush()

cur_root_dir = os.getcwd()

"""Assuming we have coverage and sqlancer folder placed in the current workdir. """

# Set up dir
new_sql_dir = os.path.join(cur_root_dir, "sqlancer")
new_cov_dir = os.path.join(cur_root_dir, "sqlancer_cov")

cur_log_file = open(os.path.join(new_sql_dir, "target/logs/output.txt"), 'w', errors = 'ignore')
# run sqlancer
sqlancer_command = "java -jar sqlancer-1.1.0.jar --log-execution-time false --num-threads 1 --num-tries 999999 --timeout-seconds 999999 sqlite3 --oracle %s " % (oracle_str)
print("Runnning SQLancer command: %s" % (sqlancer_command))
p = subprocess.Popen([sqlancer_command], 
                     cwd = os.path.join(new_sql_dir, "target"),
                     shell = True,
                     stdin = subprocess.DEVNULL,
                     stdout = cur_log_file,
                     stderr = cur_log_file
                    )

time.sleep(5)

modi_env = dict()
modi_env["AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES"] = "1"
modi_env["AFL_SKIP_CPUFREQ"] = "1"

if not os.path.isdir(os.path.join(new_cov_dir, output_dir_str)):
    os.mkdir(os.path.join(new_cov_dir, output_dir_str))

fuzzer_output_log = os.path.join(new_cov_dir, output_dir_str, "output.txt")
fuzzer_output_log = open(fuzzer_output_log, 'w', errors='ignore')


#run coverage logger. 
cov_command = "./afl-fuzz -i ./inputs/ " \
             + " -o " + output_dir_str \
             + " -I " + os.path.join(new_sql_dir, "target/logs/sqlite3/") \
             + " -- /home/sqlite/sqlite/sqlite3 "
print("Runnning cov command: %s" % (cov_command))
p = subprocess.Popen([cov_command],
                     cwd = new_cov_dir,
                     shell = True,
                     stderr = fuzzer_output_log,
                     stdout = fuzzer_output_log,
                     stdin = subprocess.DEVNULL,
                     env = modi_env
                    )

print("Finished launching the sqlancer and the afl-fuzz. ")

while True:
    time.sleep(300)
