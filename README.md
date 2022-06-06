# sqlright-artifact: The code, analysis scripts and results for USENIX 2022 Artifact Evaluation

Version: 1.0\
Update: May 24, 2022
Paper: Detecting Logical Bugs of DBMS with Coverage-based Guidance

This document is to help users reproduce the results we reported in our submission. 
It contains the following descriptions:

## Getting Started

### Operating System configuration and Source Code setup

All of the experiments are evaluated on a `X86-64` `Ubuntu 20.04 LTS` operating system. All the experiments are evaluated in a Docker env, we recommend using Docker version above 20.10.16 to reproduce the results. Before the start of the experiment, we need to configure a few system settings. 
```sh
# Open a terminal from the Ubuntu system if you are using a Desktop distribution. 
sudo apt-get install build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc
sudo apt-get install -y libpq-dev

# Disable On-demand CPU scaling
cd /sys/devices/system/cpu
echo performance | sudo tee cpu*/cpufreq/scaling_governor

# Avoid having crashes misinterpreted as hangs
sudo sh -c " echo core >/proc/sys/kernel/core_pattern "
```

We need to reset the system settgings every time we restart the computer. If the system settings are not setup correctly, the fuzzing process would failed to run. 

And then, go to the path where you want to dump the sqlright source code:

```sh
cd ~ # Assuming the home directory
git clone git@github.com:PSU-Security-Universe/sqlright-artifact.git  # TODO: May refer to other link if we are using Zenodo. 
```

## 0. Artifact Expectation

## 1. Artifact Overview

Our paper presents `SQLRight`, a tool that combines coverage-based guidance, validity-oriented mutations and oracles to detect logical bugs in Database Management Systems. For Artifact Evaluation, we release:

- (1) The `SQLRight` source code. 
- (2) The paper's final version. 
- (3) Information and the script to reproduce the evaluated benchmarks. 

## 2. Build the Docker environment to run the evaluations:

### Building the Docker image that contains the SQLite3 fuzzing scripts. 

```sh
cd <sqlright_root>/SQLite/scripts/
bash setup_sqlite.sh
```

### Building the Docker image that contains the PostgreSQL fuzzing scripts.

```sh
cd <sqlright_root>/PostgreSQL/scripts/
bash setup_postgres.sh
```

### Building the Docker image that contains the MySQL fuzzing scripts.

```sh
cd <sqlright_root>/MySQL/scripts/
bash setup_mysql.sh
bash setup_mysql_bisecting.sh
```

## 3. Comparison between different tools:

### SQLite, NoREC oracle (Figure 6c, f, i)

#### Run the SQLRight SQLite3 fuzzing for 72 hours.

Explanation of the command:

The `start-core` flag binds the fuzzing process to the specific CPU core. 

The `num-concurrent` flag determines the number of concurrent fuzzing processes. 

The `oracle` flag determines the oracle used for the fuzzing. Current supported: `NOREC` and `TLP`. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### Run the Squirrel SQLite3 fuzzing for 72 hours. 
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

### SQLRight Postgres:

Run 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash ./setup_postgres.sh
```

## 2. Comparison between different tools

### Comparison between different tools in `SQLite` with `NoREC` oracle: (Figure 6 a, c, f, i)

### Run `SQLRight Postgres` with `NoREC` oracle:

Run

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

Wait the running process for 72 hours. The results output will be dumped inside `<sqlright_root>/PostgreSQL/Results/sqlright_postgres` and `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_bugs`.

## 3. Contribution of code coverage feedback:

### Run `SQLRight Postgres` with `NoREC` oracle, but use `drop_all` feedback:

Run 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback drop_all
```

Wait the running process for 72 hours. The results output will be dumped inside `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_drop_all` and `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_drop_all_bugs`.

### Run `SQLRight Postgres` with `NoREC` oracle, but use `random_save` feedback:

Run 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback random_save
```

Wait the running process for 72 hours. The results output will be dumped inside `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_random_save` and `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_random_save_bugs`.

### Run `SQLRight Postgres` with `NoREC` oracle, but use `save_all` feedback:

Run 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback save_all
```

Wait the running process for 72 hours. The results output will be dumped inside `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_save_all` and `<sqlright_root>/PostgreSQL/Results/sqlright_postgres_save_all_bugs`.

## 4. Contribution of Validity components:

### Run `SQLRight Postgres no-ctx-valid` configuration with `NoREC` oracle:

Run

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

### Run `SQLRight Postgres no-db-par-ctx-valid` configuration with `NoREC` oracle:

Run

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

### Run `SQLRight Postgres squirrel-oracle` configuration with `NoREC` oracle:

Run

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

