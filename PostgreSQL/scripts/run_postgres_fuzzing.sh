#!/bin/bash -e
cd "$(dirname "$0")"/.. 

if [ ! -d "./Results" ]; then
    mkdir -p Results
fi

cd Results

if [ -d "./sqlright_postgres" ]; then
    echo "Detected Results/sqlright_postgres folder existed. Will remove the original folder and create a new one."
    rm -rf sqlright_postgres
fi

mkdir -p sqlright_postgres

cat ../scripts/run_postgres_fuzzing_helper.sh | \
    sudo docker run -i --rm \
    -v $(pwd)/sqlright_postgres:/home/postgres/fuzzing/fuzz_root/outputs \
    -v $(pwd)/sqlright_postgres_bugs:/home/postgres/fuzzing/Bug_Analysis \
    sqlright_postgres /bin/bash
