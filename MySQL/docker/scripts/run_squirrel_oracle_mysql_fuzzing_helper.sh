#!/bin/bash -e

# This file is used for start the SQLRight MySQL fuzzing inside the Docker env.
# entrypoint: bash

chown -R mysql:mysql /home/mysql/fuzzing/fuzz_root

SCRIPT_EXEC=$(cat << EOF
# Setup data folder
cd /home/mysql/fuzzing/fuzz_root

cp /home/mysql/Validaty_Components_Config/Squirrel_Oracle/src/afl-fuzz ./

printf "\n\n\n\nStart fuzzing. \n\n\n\n\n"

python3 run_parallel.py -o /home/mysql/fuzzing/fuzz_root/outputs $@ &

sleep 60

watch -d -n 60 python3 mysql_rebooter.py

EOF
)

su -c "$SCRIPT_EXEC" mysql

echo "Finished\n"
