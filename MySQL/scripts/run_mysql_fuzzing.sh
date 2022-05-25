#!/bin/bash -e
cd "$(dirname "$0")"/.. 

if [! -d "./Results"]; then
    mkdir -p Results
fi

cd Results

if [ -d "./sqlright_mysql"]; then
    echo "Detected Results/sqlright_mysql folder existed. Will remove the original folder and create a new one."
    rm -rf sqlright_mysql
fi

mkdir -p sqlright_mysql

cat ./run_mysql_fuzzing_helper.sh | \
    docker run -it --rm \
    -v $(pwd)/sqlright_mysql:/home/mysql/fuzzing/fuzz_root/outputs \
    sqlright_mysql 
