#!/bin/bash -e

# This file is used for start the SQLRight MySQL fuzzing inside the Docker env.
# entrypoint: bash

chown -R postgres:postgres /home/postgres/fuzzing/fuzz_root

SCRIPT_EXEC=$(cat << EOF
# Setup data folder
cd /home/postgres/postgres/bld
./bin/initdb -D ./data
./bin/pg_ctl -D ./data start
./bin/createdb x
./bin/pg_ctl -D ./data stop
mkdir -p data_all
mv data data_all/ori_data

cd /home/postgres/fuzzing/fuzz_root

######### Remember to copy from the correct source. Double check.
cp /home/postgres/Validaty_Components_Config/Squirrel_Oracle/src/afl-fuzz ./

echo "\n\n\n\nStart fuzzing with Squirrel_Oracle configuration. \n\n\n\n\n"

python3 run_parallel.py -o /home/postgres/fuzzing/fuzz_root/outputs $@

EOF
)

su -c "$SCRIPT_EXEC" postgres

echo "Finished\n"
