#!/bin/bash -e

if [ "$1" == "SQLRight" ]; then

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

    if [ ! -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder MISSING. Please run the fuzzing first to generate the bug output folder. "
        exit 5
    fi

    bugoutdir="$bugoutdir/bug_samples"
    resoutdir="$resoutdir""_bisecting"

    echo "Begin running bisecting. "
    sudo docker run -i --rm \
        -v $(pwd)/$bugoutdir:/home/mysql/bisecting_scripts/bug_samples \
        --name $resoutdir \
        sqlright_mysql_bisecting /bin/bash /home/mysql/scripts/run_mysql_bisecting_helper.sh ${@:2}

elif [ "$1" == "no-ctx-valid" ]; then

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

    if [ ! -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder not existed. Please run the fuzzing first to generate the bug output folder. "
        exit 5
    fi

    bugoutdir="$bugoutdir/bug_samples"
    resoutdir="$resoutdir""_bisecting"

    echo "Begin running bisecting. "
    sudo docker run -i --rm \
        -v $(pwd)/$bugoutdir:/home/mysql/bisecting_scripts/bug_samples \
        --name $resoutdir \
        sqlright_mysql_bisecting /bin/bash /home/mysql/scripts/run_mysql_bisecting_helper.sh ${@:2}

elif [ "$1" == "no-db-par-ctx-valid" ]; then

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

    if [ ! -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder not existed. Please run the fuzzing first to generate the bug output folder. "
        exit 5
    fi

    bugoutdir="$bugoutdir/bug_samples"
    resoutdir="$resoutdir""_bisecting"

    echo "Begin running bisecting. "
    sudo docker run -i --rm \
        -v $(pwd)/$bugoutdir:/home/mysql/bisecting_scripts/bug_samples \
        --name $resoutdir \
        sqlright_mysql_bisecting /bin/bash /home/mysql/scripts/run_mysql_bisecting_helper.sh ${@:2}

elif [ "$1" == "squirrel-oracle" ]; then

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

    if [ ! -d "./$bugoutdir" ]; then
        echo "Detected Results/$bugoutdir folder not existed. Please run the fuzzing first to generate the bug output folder. "
        exit 5
    fi

    bugoutdir="$bugoutdir/bug_samples"
    resoutdir="$resoutdir""_bisecting"

    echo "Begin running bisecting. "
    sudo docker run -i --rm \
        -v $(pwd)/$bugoutdir:/home/mysql/bisecting_scripts/bug_samples \
        --name $resoutdir \
        sqlright_mysql_bisecting /bin/bash /home/mysql/scripts/run_mysql_bisecting_helper.sh ${@:2}

elif [ "$1" == "sqlancer" ]; then

    cd "$(dirname "$0")"/..

    if [ ! -d "./Results" ]; then
        mkdir -p Results
    fi

    cd Results

    if [ ! -d "./sqlancer_mysql" ]; then
        echo "Detected Results/sqlancer_mysql folder not existed. Please run the sqlancer evaluation first to generate the result output folder. "
        exit 5
    fi

    cd sqlancer_mysql

    echo "Outputting all mismatches detected by SQLancer now: ResultSetsAreNotEqual. "

    grep "ResultSetAreNotEqual" -irn ./*

    echo "Output finished. Expected no bugs being detected by SQLancer. "

else
    echo "Wrong arguments: $@"
    echo "Usage: bash run_mysql_bisecting.sh <config> -O <oracle> [--non-deter] "
fi
