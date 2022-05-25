#!/bin/bash -e

# This file is used for start the SQLRight MySQL fuzzing inside the Docker env. 
# entrypoint: bash
cd /home/mysql/fuzzing/fuzz_root

pip3 install getopt # move it to the Dockerfile later.

python3 run_parallel.py -o ($pwd)/outputs &

echo "Waiting for the MySQL server to launch.\n"

sleep 60

watch -d -n 30 python3 mysql_rebooter.py

# Use ctrl-C to exit the shell script.

