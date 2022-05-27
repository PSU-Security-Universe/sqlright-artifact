#!/bin/bash -e

# This file is used for start the SQLRight MySQL fuzzing inside the Docker env.
# entrypoint: bash

chown -R postgres:postgres /home/postgres/sqlancer

oracle_str='NoREC'

for var in "$@":
do
    if [ "$var" == "NoREC" ]; then
        oracle_str='NoREC'
    elif [ "$var" == "TLP" ]; then
        oracle_str='QUERY_PARTITIONING'
    fi
done

SCRIPT_EXEC=$(cat << EOF
# Setup data folder
cd /home/postgres/postgres/bld
./bin/initdb -D ./data
./bin/pg_ctl -D ./data start
./bin/createdb x
echo "CREATE USER sqlancer; ALTER USER sqlancer with SUPERUSER; ALTER USER sqlancer with LOGIN; CREATE DATABASE test;" | ./bin/psql postgres 
./bin/pg_ctl -D ./data stop

mkdir -p data_all
mv data data_all/ori_data
cp -r data_all/ori_data data_all/data_100

./bin/postgres -D ./data_all/data_100 -p 5432 &

cd /home/postgres/sqlancer/sqlancer/target

mkdir -p logs

java -jar sqlancer-1.1.0.jar --log-execution-time false --num-threads 1 --num-tries 999999 --timeout-seconds 999999 postgres --oracle $oracle_str > ./logs/output.txt &

cd /home/postgres/sqlancer/sqlancer_cov

printf "\n\n\n\nStart fuzzing. \n\n\n\n\n"

python3 run_coverage.py

EOF
)

su -c "$SCRIPT_EXEC" postgres

echo "Finished\n"

