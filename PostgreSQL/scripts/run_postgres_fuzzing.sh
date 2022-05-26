#!/bin/bash -e

if [ $# == 3 ] && [ "$1" == "SQLRight" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi
    
    cd Results
    
    if [ -d "./sqlright_postgres" ]; then
        echo "Detected Results/sqlright_postgres folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    
    mkdir -p sqlright_postgres
    
    sudo docker run -i --rm \
        -v $(pwd)/sqlright_postgres:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/sqlright_postgres_bugs:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_sqlright_postgres_fuzzing_helper.sh ${@:2}

elif [ $# == 3 ] && [ "$1" == "no-ctx-valid" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi
    
    cd Results
    
    if [ -d "./sqlright_postgres_no_ctx_valid" ]; then
        echo "Detected 'Results/sqlright_postgres_no_ctx_valid' folder existed. Please cleanup the output folder and then retry."
        exit 5
    fi
    
    mkdir -p sqlright_postgres_no_ctx_valid
    
    sudo docker run -i --rm \
        -v $(pwd)/sqlright_postgres_no_ctx_valid:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/sqlright_postgres_no_ctx_valid_bugs:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_no_ctx_valid_postgres_fuzzing_helper.sh ${@:2}

elif [ $# == 3 ] && [ "$1" == "no-db-par-ctx-valid" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi
    
    cd Results
    
    if [ -d "./sqlright_postgres_no_db_par_ctx_valid" ]; then
        echo "Detected 'Results/sqlright_postgres_no_db_par_ctx_valid' folder existed. Please cleanup the output folder and then retry."
        exit 5
    fi
    
    mkdir -p sqlright_postgres_no_db_par_ctx_valid
    
    sudo docker run -i --rm \
        -v $(pwd)/sqlright_postgres_no_db_par_ctx_valid:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/sqlright_postgres_no_db_par_ctx_valid_bugs:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_no_ctx_valid_postgres_fuzzing_helper.sh ${@:2}

elif [ $# == 3 ] && [ "$1" == "squirrel-oracle" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi
    
    cd Results
    
    if [ -d "./squirrel_oracle" ]; then
        echo "Detected 'Results/squirrel_oracle' folder existed. Please cleanup the output folder and then retry."
        exit 5
    fi
    
    mkdir -p squirrel_oracle
    
    sudo docker run -i --rm \
        -v $(pwd)/squirrel_oracle:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/squirrel_oracle_bugs:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_no_ctx_valid_postgres_fuzzing_helper.sh ${@:2}

else
    echo "Usage: bash run_postgres_fuzzing.sh <config> --start-core=<num> --num-concurrent=<num>"
fi
