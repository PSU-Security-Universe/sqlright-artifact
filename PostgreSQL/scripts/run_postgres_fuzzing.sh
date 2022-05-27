#!/bin/bash -e

if [ $# > 4 ] && [ "$1" == "SQLRight" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="sqlright_postgres"
    for var in "$@"
    do
        if [ "$var" == "drop_all" ]; then
            resoutdir="$resoutdir""_drop_all"
        elif [ "$var" == "random_save" ]; then
            resoutdir="$resoutdir""_random_save"
        elif [ "$var" == "save_all" ]; then
            resoutdir="$resoutdir""_save_all"
        fi
    done

    for var in "$@"
    do
        if [ "$var" == "NOREC" ]; then
            resoutdir="$resoutdir""_NOREC"
        elif [ "$var" == "TLP" ]; then
            resoutdir="$resoutdir""_TLP"
        fi
    done

    bugoutdir="$resoutdir""_bugs"
    
    cd Results
    
    if [ -d "./$resoutdir" ]; then
        echo "Detected Results/$resoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    if [ -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    
    sudo docker run -i --rm \
        -v $(pwd)/$resoutdir:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_sqlright_postgres_fuzzing_helper.sh ${@:2}

elif [ $# > 4 ] && [ "$1" == "no-ctx-valid" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="sqlright_postgres_no_ctx_valid"

    for var in "$@"
    do
        if [ "$var" == "NOREC" ]; then
            resoutdir="$resoutdir""_NOREC"
        elif [ "$var" == "TLP" ]; then
            resoutdir="$resoutdir""_TLP"
        fi
    done

    bugoutdir="$resoutdir""_bugs"
    
    cd Results

    if [ -d "./$resoutdir" ]; then
        echo "Detected Results/$resoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    if [ -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    
    sudo docker run -i --rm \
        -v $(pwd)/$resoutdir:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_no_ctx_valid_postgres_fuzzing_helper.sh ${@:2}

elif [ $# > 4 ] && [ "$1" == "no-db-par-ctx-valid" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi
    
    resoutdir="sqlright_postgres_no_db_par_ctx_valid"

    for var in "$@"
    do
        if [ "$var" == "NOREC" ]; then
            resoutdir="$resoutdir""_NOREC"
        elif [ "$var" == "TLP" ]; then
            resoutdir="$resoutdir""_TLP"
        fi
    done

    bugoutdir="$resoutdir""_bugs"
    
    cd Results

    if [ -d "./$resoutdir" ]; then
        echo "Detected Results/$resoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    if [ -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    
    
    sudo docker run -i --rm \
        -v $(pwd)/$resoutdir:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_no_ctx_valid_postgres_fuzzing_helper.sh ${@:2}

elif [ $# > 4 ] && [ "$1" == "squirrel-oracle" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="squirrel_oracle"

    for var in "$@"
    do
        if [ "$var" == "NOREC" ]; then
            resoutdir="$resoutdir""_NOREC"
        elif [ "$var" == "TLP" ]; then
            resoutdir="$resoutdir""_TLP"
        fi
    done

    bugoutdir="$resoutdir""_bugs"
    
    cd Results

    if [ -d "./$resoutdir" ]; then
        echo "Detected Results/$resoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    if [ -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    
    sudo docker run -i --rm \
        -v $(pwd)/$resoutdir:/home/postgres/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/postgres/fuzzing/Bug_Analysis \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_no_ctx_valid_postgres_fuzzing_helper.sh ${@:2}

elif [ $# > 4 ] && [ "$1" == "sqlancer" ]; then

    cd "$(dirname "$0")"/.. 
    
    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="sqlancer_postgres"

    for var in "$@"
    do
        if [ "$var" == "NOREC" ]; then
            resoutdir="$resoutdir""_NOREC"
        elif [ "$var" == "TLP" ]; then
            resoutdir="$resoutdir""_TLP"
        fi
    done

    covoutdir="$resoutdir""_cov"
    resoutdir="$resoutdir""_raw"
    
    cd Results

    if [ -d "./$resoutdir" ]; then
        echo "Detected Results/$resoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    if [ -d "./$covoutdir" ]; then
        echo "Detected Results/$covoutdir folder existed. Please cleanup the output folder and then retry. "
        exit 5
    fi
    
    sudo docker run -i --rm \
        -v $(pwd)/$resoutdir:/home/postgres/sqlancer/sqlancer/target/logs \
        -v $(pwd)/$covoutdir:/home/postgres/sqlancer/sqlancer_cov/outputs_0 \
        sqlright_postgres /bin/bash /home/postgres/scripts/run_sqlancer_helper.sh ${@:2}

else
    echo "Usage: bash run_postgres_fuzzing.sh <config> --start-core <num> --num-concurrent <num> -O <oracle> [-F <feedback>] "
fi
