import os
import sys
import getopt

oracle_str_l = ["NOREC", "TLP"]
dbms_str_l = ["sqlite", "mysql"]
non_deter_flags_l = ["", "non_deter"]

for dbms_str in dbms_str_l:
    for oracle_str in oracle_str_l:
        for non_deter_flag in non_deter_flags_l:
#            if non_deter_flag != "":
#                print("\n\n\nRunning with Configuration: SQLRight with oracle: %s and WITH non_deter queries. " % (oracle_str))
#            else:
#                print("\n\n\nRunning with Configuration: SQLRight with oracle: %s and WITHOUT non_deter queries. " % (oracle_str))

            if dbms_str == "sqlite":
                src_dir = "../SQLite/Results/"
            else:
                src_dir = "../MySQL/Results/"

            if not os.path.isdir(src_dir):
                print("Error: The Results dir: %s is not exist. Please run the fuzzing first in order to generate the output folder. " % (src_dir))
                exit(1)

            src_dir += "sqlright_%s" % (dbms_str)

            src_dir += "_" + oracle_str

            if non_deter_flag != "":
                src_dir += "_" + non_deter_flag

            src_dir += "_" + "bugs"

            src_dir = os.path.join(src_dir, "bug_samples/unique_bug_output/")

            if not os.path.isdir(src_dir):
                print("Error: The Results dir: %s is not exist. Please run the fuzzing first in order to generate the output folder. " % (src_dir))
                continue

            # Get number of files.
            num_of_bugs = len(list(os.listdir(src_dir))) - 1 # -1: Remove the time.txt file. 

            if non_deter_flag == "":
                print("\n\nFor DBMS: %s, with oracle: %s, WITHOUT non_deter queries, getting bug number: %d. \n\n" % (dbms_str, oracle_str, num_of_bugs))
            else:
                print("\n\nFor DBMS: %s, with oracle: %s, WITH non_deter queries, getting bug number: %d. \n\n" % (dbms_str, oracle_str, num_of_bugs))
