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

And then, here is some required python modules required for the figures plotting:
```sh
sudo apt-get install python3
sudo apt-get install python3-pip

# Use root to run pip3 if necessary. 
pip3 install matplotlib
pip3 install numpy
pip3 install pandas
pip3 install paramiko
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

### 3.1 SQLite, NoREC oracle (Figure 6c, f, i)

#### 3.1.1 Run the SQLRight SQLite3 fuzzing for 72 hours.

Explanation of the command:

The `start-core` flag binds the fuzzing process to the specific CPU core. 

The `num-concurrent` flag determines the number of concurrent fuzzing processes. 

The `oracle` flag determines the oracle used for the fuzzing. Current supported: `NOREC` and `TLP`. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### 3.1.2 Run the Squirrel SQLite3 fuzzing for 72 hours. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### 3.1.3 Run the SQLancer SQLite3 for 72 hours. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh sqlancer --num-concurrent 5 --oracle NOREC
```

#### 3.1.4 Plot the figures. 

```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/NoREC/Comp_diff_tools_NoREC
python3 copy_results.py
python3 run_plots.py
```

The plots would be generated in folder `plots`.

### 3.2 PostgreSQL, NoREC oracle (Figure 6d, g, j)

#### 3.2.1 Run the SQLRight PostgreSQL fuzzing for 72 hours. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### 3.2.2 Run the Squirrel with oracle PostgreSQL fuzzing for 72 hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### 3.2.3 Run the SQLancer PostgreSQL for 72 hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh sqlancer --num-concurrent 5 --oracle NOREC
```

#### 3.2.4 Plot the figures. 

```sh
cd <sqlright_root>/Plot_Scripts/Postgres/NoREC/Comp_diff_tools_NoREC
python3 copy_results.py
python3 run_plots.py
```

The plots would be generated in folder `plots`.

### 3.3 MySQL, NoREC oracle (Figure 6d, g, j)

#### 3.3.1 Run the SQLRight MySQL fuzzing for 72 hours. 

```sh
cd <sqlright_root>/MySQL/scripts
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### 3.3.2 Run the Squirrel with oracle MySQL fuzzing for 72 hours.

```sh
cd <sqlright_root>/MySQL/scripts
bash run_mysql_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

#### 3.3.3 Plot the figures. 

```sh
cd <sqlright_root>/Plot_Scripts/MySQL/NoREC/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

### 3.4 SQLite, TLP oracle (Figure 9c, f, i)

#### 3.4.1 Run the SQLRight SQLite3 fuzzing for 72 hours.

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

#### 3.4.2 Run the Squirrel SQLite3 fuzzing for 72 hours. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

#### 3.4.3 Run the SQLancer SQLite3 for 72 hours. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

#### 3.4.4 Plot the figures. 

```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Comp_diff_tool
python3 copy_results.py
python3 run_plots.py
```

The plots would be generated in folder `plots`.

### 3.5 PostgreSQL, TLP oracle (Figure 9d, g, j)

#### 3.5.1 Run the SQLRight PostgreSQL fuzzing for 72 hours. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

#### 3.5.2 Run the Squirrel with oracle PostgreSQL fuzzing for 72 hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

#### 3.5.3 Run the SQLancer PostgreSQL for 72 hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

#### 3.5.4 Plot the figures. 

```sh
cd <sqlright_root>/Plot_Scripts/Postgres/TLP/Comp_diff_tools_TLP
python3 copy_results.py
python3 run_plots.py
```

The plots would be generated in folder `plots`.

### 3.6 MySQL, NoREC oracle (Figure 9d, g, j)

#### 3.6.1 Run the SQLRight MySQL fuzzing for 72 hours. 

```sh
cd <sqlright_root>/MySQL/scripts
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

#### 3.6.2 Run the Squirrel with oracle MySQL fuzzing for 72 hours.

```sh
cd <sqlright_root>/MySQL/scripts
bash run_mysql_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

#### 3.6.3 Run the SQLancer MySQL for 72 hours.

```sh
cd <sqlright_root>/MySQL/scripts
bash run_mysql_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

#### 3.6.4 Plot the figures. 

```sh
cd <sqlright_root>/Plot_Scripts/MySQL/TLP/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

## 4. Contribution of code-coverage feedback:

### 4.1 Using NoREC oracle:

#### 4.1.1 Run the SQLRight SQLite3 Drop All configiguration, for 24 hours:
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback drop_all 
```

#### 4.1.2 Run the SQLRight SQLite3 Random Save configiguration, for 24 hours:
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback random_save
```

#### 4.1.3 Run the SQLRight SQLite3 Save All configiguration, for 24 hours:
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback save_all
```

#### 4.1.4 Plot the figures:
```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/NoREC/Feedback_Test
python3 copy_results.py
python3 run_plots.py
```

### 4.2 Using TLP oracle:

#### 4.2.1 Run the SQLRight SQLite3 Drop All configiguration, for 24 hours:
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback drop_all 
```

#### 4.2.2 Run the SQLRight SQLite3 Random Save configiguration, for 24 hours:
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback random_save
```

#### 4.2.3 Run the SQLRight SQLite3 Save All configiguration, for 24 hours:
```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback save_all
```

#### 4.2.4 Plot the figures:
```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Feedback_Test
python3 copy_results.py
python3 run_plots.py
```


## 5. Contribution of Validity components:

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

