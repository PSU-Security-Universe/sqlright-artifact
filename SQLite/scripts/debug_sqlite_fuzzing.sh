cd "$(dirname "$0")"/.. 

if [ ! -d "./Results" ]; then
    mkdir -p Results
fi

cd Results

if [ ! -d "./sqlancer_sqlite" ]; then
    mkdir -p sqlancer_sqlite
fi

cd sqlancer_sqlite

# Get concurrent number from arguments.
num_concurrent=1

echo "Running with num-concurrent = $num_concurrent"

for i in $(seq 1 $num_concurrent);
do
    resoutdir="sqlancer_sqlite"

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

for i in $(seq 1 $num_concurrent);
do
    resoutdir="sqlancer_sqlite"

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
    
    sudo docker run -it --rm \
        -v $(pwd)/$resoutdir:/home/sqlite/sqlancer/sqlancer/target/logs \
        -v $(pwd)/$covoutdir:/home/sqlite/sqlancer/sqlancer_cov/outputs_0 \
        --name $resoutdir \
        sqlright_sqlite /bin/bash /home/sqlite/scripts/run_sqlancer_helper.sh ${@:2}

done

echo "Finished launching the SQLancer processes."
