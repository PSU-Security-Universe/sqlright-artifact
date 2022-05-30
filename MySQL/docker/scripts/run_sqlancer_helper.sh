#!/bin/bash -e

# This file is used for start the SQLRight MySQL fuzzing inside the Docker env.
# entrypoint: bash

chown -R mysql:mysql /home/mysql/sqlancer

oracle_str='TLP_WHERE'

for var in "$@";
do
    if [ "$var" == "TLP" ]; then
        oracle_str='TLP_WHERE'
    fi
done


SCRIPT_EXEC=$(cat << EOF
# Setup data folder
cd /home/mysql/mysql-server/bld/
cp -r data_all/ori_data data_all/data_100

./bin/mysqld --basedir=./ --datadir=./data_all/data_100/ --socket=/tmp/mysql_sqlancer.sock &
sleep 5

./bin/mysql -u root -e "CREATE USER 'sqlancer'@'localhost' IDENTIFIED BY 'sqlancer'; GRANT ALL PRIVILEGES ON * . * TO 'sqlancer'@'localhost';" --socket=/tmp/mysql_sqlancer.sock


cd /home/mysql/sqlancer/sqlancer/target
mkdir -p logs
java -jar sqlancer-1.1.0.jar --log-execution-time false --num-threads 1 --num-tries 999999 --timeout-seconds 999999 mysql --oracle $oracle_str > ./logs/output.txt &

cd /home/mysql/sqlancer/sqlancer_cov

printf "\n\n\n\nStart fuzzing. \n\n\n\n\n"

python3 run_coverage.py

EOF
)

su -c "$SCRIPT_EXEC" mysql

echo "Finished\n"

