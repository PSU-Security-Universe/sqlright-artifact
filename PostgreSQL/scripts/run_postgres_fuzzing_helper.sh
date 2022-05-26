#!/bin/bash -e

# This file is used for start the SQLRight MySQL fuzzing inside the Docker env. 
# entrypoint: bash

chown -R postgres:postgres /home/postgres/fuzzing/fuzz_root/outputs

su postgres

# Setup data folder
cd /home/postgres/postgres/bld
./bin/initdb -D ./data
./bin/pg_ctl -D ./data start
./bin/createdb x
./bin/pg_ctl -D ./data stop
mkdir -p data_all
mv data data_all/ori_data

cd /home/postgres/fuzzing/fuzz_root

cp /home/postgres/src/afl-fuzz ./

python3 run_parallel.py -o $(pwd)/outputs

echo "Finished\n"
