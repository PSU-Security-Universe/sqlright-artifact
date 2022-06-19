#!/bin/bash -e

if [ $# > 4 ] && [ "$1" == "SQLRight" ]; then

    cd "$(dirname "$0")"/..

    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="sqlright_mysql"
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

    for var in "$@"
    do
        if [ "$var" == "--non-deter" ]; then
            resoutdir="$resoutdir""_non_deter"
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
        -v $(pwd)/$resoutdir:/home/mysql/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/mysql/fuzzing/Bug_Analysis \
        --name $resoutdir \
        sqlright_mysql /bin/bash /home/mysql/scripts/run_sqlright_mysql_fuzzing_helper.sh ${@:2}

elif [ $# > 4 ] && [ "$1" == "no-ctx-valid" ]; then

    cd "$(dirname "$0")"/..

    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="sqlright_mysql_no_ctx_valid"

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
        -v $(pwd)/$resoutdir:/home/mysql/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/mysql/fuzzing/Bug_Analysis \
        --name $resoutdir \
        sqlright_mysql /bin/bash /home/mysql/scripts/run_no_ctx_valid_mysql_fuzzing_helper.sh ${@:2}

elif [ $# > 4 ] && [ "$1" == "no-db-par-ctx-valid" ]; then

    cd "$(dirname "$0")"/..

    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    resoutdir="sqlright_mysql_no_db_par_ctx_valid"

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
        -v $(pwd)/$resoutdir:/home/mysql/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/mysql/fuzzing/Bug_Analysis \
        --name $resoutdir \
        sqlright_mysql /bin/bash /home/mysql/scripts/run_no_db_par_ctx_valid_mysql_fuzzing_helper.sh ${@:2}

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
        -v $(pwd)/$resoutdir:/home/mysql/fuzzing/fuzz_root/outputs \
        -v $(pwd)/$bugoutdir:/home/mysql/fuzzing/Bug_Analysis \
        --name $resoutdir \
        sqlright_mysql /bin/bash /home/mysql/scripts/run_squirrel_oracle_mysql_fuzzing_helper.sh ${@:2}

elif [ "$1" == "sqlancer" ]; then

    cd "$(dirname "$0")"/..

    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    cd Results

    if [ ! -d "./sqlancer_mysql" ]; then
        mkdir -p sqlancer_mysql
    fi

    cd sqlancer_mysql

    # Get concurrent number from arguments.
    num_concurrent=5
    for var in "$@"
    do
        if [ -v check ]; then
            num_concurrent=$((var))
            break
        elif [ "$var" == "--num-concurrent" ]; then
            check=1
        fi
    done

    echo "Running with num-concurrent = $num_concurrent"

    # Check the output dir.
    for i in $(seq 1 $num_concurrent);
    do
        resoutdir="sqlancer_mysql"

        for var in "$@"
        do
            if [ "$var" == "NOREC" ]; then
                resoutdir="$resoutdir""_NOREC"
            elif [ "$var" == "TLP" ]; then
                resoutdir="$resoutdir""_TLP"
            fi
        done

        covoutdir="$resoutdir""_cov_$i"
        resoutdir="$resoutdir""_raw_$i"


        if [ -d "./$resoutdir" ]; then
            echo "Detected Results/sqlancer/$resoutdir folder existed. Please cleanup the output folder and then retry. "
            exit 5
        fi
        if [ -d "./$covoutdir" ]; then
            echo "Detected Results/sqlancer/$covoutdir folder existed. Please cleanup the output folder and then retry. "
            exit 5
        fi

    done

    # Run the program.
    for i in $(seq 1 $num_concurrent);
    do

        resoutdir="sqlancer_mysql"

        for var in "$@"
        do
            if [ "$var" == "NOREC" ]; then
                resoutdir="$resoutdir""_NOREC"
            elif [ "$var" == "TLP" ]; then
                resoutdir="$resoutdir""_TLP"
            fi
        done

        covoutdir="$resoutdir""_cov_$i"
        resoutdir="$resoutdir""_raw_$i"

        sudo -b docker run -it --rm \
            -v $(pwd)/$resoutdir:/home/mysql/sqlancer/sqlancer/target/logs \
            -v $(pwd)/$covoutdir:/home/mysql/sqlancer/sqlancer_cov/outputs_0 \
            --name $resoutdir \
            sqlright_mysql /bin/bash /home/mysql/scripts/run_sqlancer_helper.sh ${@:2}

    done

    echo "Finished launching the SQLancer processes."

    while : 
    do
        sleep 100
    done

else
    echo "Wrong arguments: $@"
        echo "Usage: bash run_mysql_fuzzing.sh <config> --start-core <num> --num-concurrent <num> -O <oracle> [--non-deter] "
fi
