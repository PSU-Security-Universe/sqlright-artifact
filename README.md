# sqlright-artifact: The code, analysis scripts and results for USENIX 2022 Artifact Evaluation

<a href="Paper/paper_no_names.pdf"><img src="Paper/paper_no_names.png" align="right" width="250"></a>

Version: 1.0\
Update: Jun 19, 2022\
Paper: Detecting Logical Bugs of DBMS with Coverage-based Guidance

This document is to help users reproduce the results we reported in our submission. 

Currently supported DBMS:
1. SQLite3
2. PostgreSQL
3. MySQL

<br/><br/>
## Table of Contents
<!--ts-->
  * [Getting Started](#getting-started)
    + [Operating System configuration and Source Code setup](#operating-system-configuration-and-source-code-setup)
    + [Troubleshooting](#troubleshooting)
  * [0. Artifact Expectations](#0-artifact-expectations)
  * [1. Artifact Overview](#1-artifact-overview)
  * [2.  Build the Docker Images](#2--build-the-docker-images)
    + [2.1  Build the Docker Image for SQLite3 evaluations](#21--build-the-docker-image-for-sqlite3-evaluations)
    + [2.2  Build the Docker Image for PostgreSQL evaluations](#22--build-the-docker-image-for-postgresql-evaluations)
    + [2.3  Build the Docker Images for MySQL evaluations](#23--build-the-docker-images-for-mysql-evaluations)
  * [3. Comparison Between Different Tools](#3-comparison-between-different-tools)
    + [3.1 SQLite NoREC oracle](#31-sqlite-norec-oracle)
      - [3.1.1 SQLRight](#311-sqlright)
      - [3.1.2 Squirrel-Oracle](#312-squirrel-oracle)
      - [3.1.3 SQLancer](#313-sqlancer)
      - [3.1.4 Figures](#314-figures)
    + [3.2 PostgreSQL NoREC](#32-postgresql-norec)
      - [3.2.1 SQLRight](#321-sqlright)
      - [3.2.2 Squirrel-Oracle](#322-squirrel-oracle)
      - [3.2.3 SQLancer](#323-sqlancer)
      - [3.2.4 Figures](#324-figures)
    + [3.3 MySQL NoREC](#33-mysql-norec)
      - [3.3.1 SQLRight](#331-sqlright)
      - [3.3.2 Squirrel-Oracle](#332-squirrel-oracle)
      - [3.3.3 Figures](#333-figures)
    + [3.4 SQLite TLP](#34-sqlite-tlp)
      - [3.4.1 SQLRight](#341-sqlright)
      - [3.4.2 Squirrel-Oracle](#342-squirrel-oracle)
      - [3.4.3 SQLancer](#343-sqlancer)
      - [3.4.4 Figures](#344-figures)
    + [3.5 PostgreSQL TLP](#35-postgresql-tlp)
      - [3.5.1 SQLRight](#351-sqlright)
      - [3.5.2 Squirrel-Oracle](#352-squirrel-oracle)
      - [3.5.3 SQLancer](#353-sqlancer)
      - [3.5.4 Figures](#354-figures)
    + [3.6 MySQL TLP](#36-mysql-tlp)
      - [3.6.1 SQLRight](#361-sqlright)
      - [3.6.2 Squirrel-Oracle](#362-squirrel-oracle)
      - [3.6.3 SQLancer](#363-sqlancer)
      - [3.6.4 Figures](#364-figures)
  * [4. Contribution of Code-Coverage Feedback](#4-contribution-of-code-coverage-feedback)
    + [4.1 NoREC](#41-norec)
      - [4.1.1 SQLRight](#411-sqlright)
      - [4.1.2 SQLRight Drop All](#412-sqlright-drop-all)
      - [4.1.3 SQLRight Random Save](#413-sqlright-random-save)
      - [4.1.4 SQLRight Save All](#414-sqlright-save-all)
      - [4.1.5 Figures](#415-figures)
    + [4.2 TLP](#42-tlp)
      - [4.2.1 SQLRight](#421-sqlright)
      - [4.2.2 SQLRight Drop All](#422-sqlright-drop-all)
      - [4.2.3 SQLRight Random Save](#423-sqlright-random-save)
      - [4.2.4 SQLRight Save All](#424-sqlright-save-all)
      - [4.2.5 Figures](#425-figures)
    + [4.3. Mutation Depth](#43-mutation-depth)
  * [5. Contribution of Validity Components](#5-contribution-of-validity-components)
    + [5.1 SQLite NoREC](#51-sqlite-norec)
      - [5.1.1 SQLRight](#511-sqlright)
      - [5.1.2 SQLRight No-Ctx-Valid](#512-sqlright-no-ctx-valid)
      - [5.1.3 SQLRight No-DB-Par-Ctx-Valid](#513-sqlright-no-db-par-ctx-valid)
      - [5.1.4 Squirrel-Oracle](#514-squirrel-oracle)
      - [5.1.5 SQLRight Non-Deter](#515-sqlright-non-deter)
      - [5.1.6 Figures](#516-figures)
    + [5.2 PostgreSQL NoREC](#52-postgresql-norec)
      - [5.2.1 SQLRight](#521-sqlright)
      - [5.2.2 SQLRight No-Ctx-Valid](#522-sqlright-no-ctx-valid)
      - [5.2.3 SQLRight No-DB-Par-Ctx-Valid](#523-sqlright-no-db-par-ctx-valid)
      - [5.2.4 Squirrel-Oracle](#524-squirrel-oracle)
      - [5.2.5 Figures](#525-figures)
    + [5.3 MySQL NoREC](#53-mysql-norec)
      - [5.3.1 SQLRight](#531-sqlright)
      - [5.3.2 SQLRight No-Ctx-Valid](#532-sqlright-no-ctx-valid)
      - [5.3.3 SQLRight No-DB-Par-Ctx-Valid](#533-sqlright-no-db-par-ctx-valid)
      - [5.3.4 Squirrel-Oracle](#534-squirrel-oracle)
      - [5.3.5 SQLRight Non-Deter](#535-sqlright-non-deter)
      - [5.3.6 Figures](#536-figures)
    + [5.4 SQLite TLP](#54-sqlite-tlp)
      - [5.4.1 SQLRight](#541-sqlright)
      - [5.4.2 SQLRight No-Ctx-Valid](#542-sqlright-no-ctx-valid)
      - [5.4.3 SQLRight No-DB-Par-Ctx-Valid](#543-sqlright-no-db-par-ctx-valid)
      - [5.4.4 Squirrel-Oracle](#544-squirrel-oracle)
      - [5.4.5 SQLRight Non-Deter](#545-sqlright-non-deter)
      - [5.4.6 Figures](#546-figures)
    + [5.5 PostgreSQL TLP](#55-postgresql-tlp)
      - [5.5.1 SQLRight](#551-sqlright)
      - [5.5.2 SQLRight No-Ctx-Valid](#552-sqlright-no-ctx-valid)
      - [5.5.3 SQLRight No-DB-Par-Ctx-Valid](#553-sqlright-no-db-par-ctx-valid)
      - [5.5.4 Squirrel-Oracle](#554-squirrel-oracle)
      - [5.5.5 Figures](#555-figures)
    + [5.6 MySQL TLP](#56-mysql-tlp)
      - [5.6.1 SQLRight](#561-sqlright)
      - [5.6.2 SQLRight No-Ctx-Valid](#562-sqlright-no-ctx-valid)
      - [5.6.3 SQLRight No-DB-Par-Ctx-Valid](#563-sqlright-no-db-par-ctx-valid)
      - [5.6.4 Squirrel-Oracle](#564-squirrel-oracle)
      - [5.6.5 SQLRight Non-Deter](#565-sqlright-non-deter)
      - [5.6.6 Figures](#566-figures)
    + [5.7 False Positives from Non-Deter](#57-false-positives-from-non-deter)
- [End of the Artifact Evaluation Instructions](#end-of-the-artifact-evaluation-instructions)
<!--te-->

<br/><br/>
## Getting Started

### Operating System configuration and Source Code setup

All of the experiments are evaluated on a `x86-64` CPU with `Ubuntu 20.04 LTS` operating system. We recommend to reserve `>= 20` cores of CPUs, `>= 600GB` of memory and `>= 1.5TB` hard drive storage (preferably SSDs) for the evaluations. All the experiments are evaluated in Docker envs. We recommend to use Docker with version `>= 20.10.16` to reproduce the results. Before the start of the evaluations, we firstly need to configure a few system settings on the host operating system. 

```bash
# Basic Dependencies. 
# Open the terminal app from the Ubuntu host system, if you are using a Ubuntu Desktop distribution. 
sudo apt-get install -y build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc
sudo apt-get install -y libpq-dev
```

```bash
# System Configurations. 
# Open the terminal app from the Ubuntu host system, if you are using a Ubuntu Desktop distribution. 
# Disable On-demand CPU scaling
cd /sys/devices/system/cpu
echo performance | sudo tee cpu*/cpufreq/scaling_governor

# Avoid having crashes being misinterpreted as hangs
sudo sh -c " echo core >/proc/sys/kernel/core_pattern "
```

**WARNING**: Since the operating system will automatically reset some settings upon restarts, we need to reset the system settgings using the above scripts **EVERY TIME** after the computer restarted. If the system settings are not being setup correctly, all the fuzzing processes inside Docker will failed. 

We use python3 scripts in the host operating system to generate the paper Figures. Therefore, we should install the python3 dependencies in the host operating system. 

```bash
sudo apt-get install -y python3
sudo apt-get install -y python3-pip

# Use `sudo` to run pip3 if necessary. 
pip3 install matplotlib
pip3 install numpy
pip3 install pandas
pip3 install paramiko
pip3 install datetime
```

The whole Artifact Evaluations are built within the `Docker` virtualized environment. If the host system does not have the `Docker` application installed, here is the command to install `Docker` in `Ubuntu`. 

```bash
# The script is grabbed from Docker official documentation: https://docs.docker.com/engine/install/ubuntu/

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# The next script could fail on some machines. However, the following installation process should still succeed. 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Receiving a GPG error when running apt-get update?
# Your default umask may not be set correctly, causing the public key file for the repo to not be detected. Run the following command and then try to update your repo again: sudo chmod a+r /etc/apt/keyrings/docker.gpg.

# To test the Docker installation. 
sudo docker run hello-world
# Expected outputs 'Hello from Docker!'
``` 

By default, interacting with `Docker` requires the `root` privilege from the host system. For a normal (non-root) user, calling `docker` requires the `sudo` command prefix. 

For every evaluations we applied in this Artifact, due to their long runtime, we recommend to use a `terminal multiplexer` tool to hold the command running shell, so that the terminal doesn't need to be kept open while waiting for the long evaluation time to end. Here we show two `terminal multiplexer` tools we suggested:

```bash
# screen
# screen install
sudo apt install screen
# screen usage
screen -S test_id_0 # Create a new screen session named test_id_0
# Run whatever commands in the hosted shell
<Ctrl-a> <Ctrl-d> # Detach from the running shell. 
screen -r test_id_0 # reattach to the running shell. 
exit # Exit and close the running screen session. 

# tmux
# tmux install
sudo apt install tmux
# tmux usage
tmux new-session -s test_id_0 # Session name is test_id_0
# Run whatever commands in the hosted shell
<Ctrl-b> <d> # Detach from the running tmux session.
tmux attach -t test_id_0
exit # Exit and close the running tmux session.
```

At last, go to the path where you want to download the `SQLRight` source code:

```bash
cd ~ # Assuming the home directory
git clone https://github.com/PSU-Security-Universe/sqlright-artifact.git  # TODO: May refer to other link if we are using Zenodo. 
```

### Troubleshooting

- If the Docker Image building process failed or stuck at some steps for a couple hours, consider to clean the Docker environments. The following command will clean up the Docker cache, and we can rebuild another Docker Images from scratch. 

```bash
sudo docker system prune --all
```

- If any fuzzing processes failed to launch, immediately return errors, or never output any results while running, please check whether the `System Configuration` has been setup correctly. Specifically, please repeat the steps of `Disable On-demand CPU scaling` and `Avoid having crashes being misinterpreted as hangs` before retrying the fuzzing scripts. 

<br/><br/>
## 0. Artifact Expectations

This Artifact Evaluation is expected to consume a total of `8834` CPU hours. We recommend using a machine with `>= 20` cores of CPU, `>= 600GB` of memory and `>= 1.5TB` of storage space(preferably SSDs) to reproduce the results. All the code and the scripts of our built tool `SQLRight` are being released in this repository. Using the instructions below, one should be able to reproduce all the evaluations (Figures, Tables) shown in our Final Paper. 


<br/><br/>
## 1. Artifact Overview

Our paper presents `SQLRight`, a tool that combines coverage-based guidance, validity-oriented mutations and oracles to detect logical bugs in Database Management Systems. For Artifact Evaluation, we release:

- (1) The `SQLRight` source code. 
- (2) The baselines' source code. 
- (3) The paper's final version. [Paper Link inside This Repo](Paper/paper_no_names.pdf)
- (4) Information and the scripts to reproduce the evaluated benchmarks. 

*Session 2* contains the instructions to build all the Docker images required for our evaluation. These are the prerequisite steps before we run any fuzzing evaluations. 

*Session 3* contains the instructions to evaluate `Comparison with Existing Tools` (*Section 5.2* in the paper). It includes the steps to generate the figures from *Figure 5* and *Figure 8* in the paper. It consumes about `6152` CPU hours. 

*Session 4* contains the instructions to evaluate `Contribution of Coverage Feedback` (*Section 5.3* in the paper). It includes the steps to generate *Figure 6* and *Table 3* in the paper. It consumes about `726` CPU hours. 

*Session 5* contains the instructions to evalute `Contribution of Validity` (*Section 5.4* in the paper). It includes the steps to generate *Figure 7*, *Figure 9* and *Table 4* in the paper. It consumes about `1956` CPU hours. 


<br/><br/>
## 2.  Build the Docker Images

### 2.1  Build the Docker Image for SQLite3 evaluations

Execute the following commands before running any SQLite3 related evaluations. 

The Docker build process can last for about `1` hour. Expect long runtime when executing the commands. 
```bash
cd <sqlright_root>/SQLite/scripts/
bash setup_sqlite.sh
```

After the command finihsed, a Docker Image named `sqlright_sqlite` is created. 

--------------------------------------------------------------------------
### 2.2  Build the Docker Image for PostgreSQL evaluations

Execute the following commands before running any PostgreSQL related evaluations. 

The Docker build process can last for about `1` hour. Expect long runtime when executing the commands. 
```bash
cd <sqlright_root>/PostgreSQL/scripts/
bash setup_postgres.sh
```

After the command finihsed, a Docker Image named `sqlright_postgres` is created. 

--------------------------------------------------------------------------
### 2.3  Build the Docker Images for MySQL evaluations

Execute the following commands before running any MySQL related evaluations. 

The Docker build process can last for about `3` hour. Expect long runtime when executing the commands. The created Docker Image will have around `70GB` of storage space. 

We expect some **Warnings** being returned from the MySQL compilation process. The **Warnings** won't impact the build process. 

```bash
cd <sqlright_root>/MySQL/scripts/
bash setup_mysql.sh
bash setup_mysql_bisecting.sh
```

After the command finihsed, two Docker Images named `sqlright_mysql` and `sqlright_mysql_bisecting` are created. 



<br/><br/>
## 3. Comparison Between Different Tools

### 3.1 SQLite NoREC oracle

#### 3.1.1 SQLRight   

<sub>`361` CPU hours</sub>

Run the following commands. 

The following bash scripts will wake the fuzzing script inside `sqlright_sqlite` Docker image. Let the fuzzing processes run for `72` hours. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based)
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

Explanation of the command:

- The argument `SQLRight` determines the current running configurations. Currently support `SQLRight`, `no-ctx-valid`, `no-db-par-ctx-valid`, `squirrel-oracle` and `sqlancer`. Other configurations will be demonstrated in the subsequent testing scripts. 

- The `start-core` flag binds the fuzzing process to the specific CPU core. The index starts with `0`. Using `start-core 0` will bind the first fuzzing process to the first CPU core on your machine. Combined with `num-concurrent`, the script will bind each fuzzing process to a unique CPU core, in order to avoid performance penalty introduced by running mutliple processes on one CPU core. For example, flags: `--start-core 0 --num-concurrent 5` will bind `5` fuzzing processes to CPU core `1~5`. Throughout all the evaluation scripts we show in this instruction, we use a default value of `0` for `--start-core`. However, please adjust the CORE-ID based on your testing scenarios, and avoid conflicted CORE-ID already used by other running evaluation processes. 

- The `num-concurrent` flag determines the number of concurrent fuzzing processes. If the testing machine is constrainted by CPU cores, memory size or hard drive space, consider using a lower value for this flag. In our paper evaluations, we use the value of `5` across all the configurations. 

- **Attention**: Make sure `start-core + num-concurrent` won't exceed the total CPU core count of your machine. Otherwise, the script will return error and the fuzzing process will failed to launch. 

- The `oracle` flag determines the oracle used for the fuzzing. Currently support: `NOREC` and `TLP`. 

Back to the current evaluation. :-)

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_NOREC
# Run bug bisecting
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour. The bisecting script doesn't require `--start-core` and `--num-concurrent` flags. And it will auto exit upon finished. 

#### 3.1.2 Squirrel-Oracle 

<sub>`361` CPU hours</sub>

Run the following commands. Let the fuzzing processes run for 72 hours.

**WARNING**: The `Squirrel-Oracle` process consumes a large amount of memory. In our evaluation, we observed a maximum of `190GB` of memory usage PER `Squirrel-Oracle` process after running for 72 hours. With 5 concurrent processes, the evalution could use in total of `600GB` of memory within 72 hours. If not enough memory is available, consider using a smaller number of `--num-concurrent` to avoid Out-Of-Memory (OOM) kill.  

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop squirrel_oracle_NOREC
# Run bug bisecting
bash run_sqlite_bisecting.sh squirrel-oracle --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.1.3 SQLancer 

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data. And it will save these cache to the local file system. We expected around `80GB` of cache being generated from EACH SQLancer instances. Following the command below, we call 5 instances of SQLancer, which will dump `400GB` of cache data to the hard disk. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```bash
cd <sqlright_root>/SQLite/scripts
# Call 5 instances of SQLancer. 
bash run_sqlite_fuzzing.sh sqlancer --num-concurrent 5 --oracle NOREC
```

**Attention**: Expect some error messages: `unable to setup input stream: unable to set IO streams as raw terminal: input/output error`. It won't impact the evaluation process. 

After `72` hours, stop the Docker container instance. 

```bash
# Stop the sqlancer process
sudo docker ps --filter name=sqlancer_sqlite_NOREC_raw_* --filter status=running -aq | xargs sudo docker stop
```

#### 3.1.4 Figures

The following scripts will generate *Figure 5a, c, f, i* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/SQLite/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/SQLite3/NoREC/Comp_diff_tools_NoREC
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/SQLite3/NoREC/Comp_diff_tools_NoREC/plots`.

**Expectations**:

- For SQLite logical bugs figure: `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 3` bugs being detected by `SQLRight` in `72` hours. 
- For SQLite code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For SQLite query validity: `SQLancer` have the highest query validity, while `SQLRight` performs better than `Squirrel-oracle`. 
- For SQLite valid stmts / hr: `SQLancer` have the highest valid stmts / hr, while `SQLRight` performs better than `Squirrel-oracle`.


--------------------------------------------------------------------------
### 3.2 PostgreSQL NoREC

#### 3.2.1 SQLRight

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `72` hours.

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker stop sqlright_postgres_NOREC
```

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 3.2.2 Squirrel-Oracle

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker stop squirrel_oracle_NOREC
```

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 3.2.3 SQLancer

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `50GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `250GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```bash
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh sqlancer --num-concurrent 5 --oracle NOREC
```

**Attention**: Expect some error messages: `unable to setup input stream: unable to set IO streams as raw terminal: input/output error`. It won't impact the evaluation process. 

After `72` hours, stop the Docker container instances. 

```bash
sudo docker ps --filter name=sqlancer_postgres_NOREC_raw_* --filter status=running -aq | xargs sudo docker stop
```

#### 3.2.4 Figures 

The following scripts will generate *Figure 5e, h, k* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/PostgreSQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/Postgres/NoREC/Comp_diff_tools_NoREC
python3 copy_results.py
python3 run_plots.py
```

The plots will be generated in folder `<sqlright_root>/Plot_Scripts/Postgres/NoREC/Comp_diff_tools_NoREC/plots`. 

**Expectations**:

- For PostgreSQL code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For PostgreSQL query validity: `SQLancer` have the highest query validity, while `SQLRight` performs better than `Squirrel-oracle`. 
- For PostgreSQL valid stmts / hr: `SQLancer` have the highest valid stmts / hr, while `SQLRight` performs better than `Squirrel-oracle`.

--------------------------------------------------------------------------
### 3.3 MySQL NoREC

#### 3.3.1 SQLRight

<sub>`367` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. And then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_NOREC
# Run bug bisecting
bash run_mysql_bisecting.sh SQLRight --oracle NOREC
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.3.2 Squirrel-Oracle

<sub>`367` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop squirrel_oracle_NOREC
# Run bug bisecting
bash run_mysql_bisecting.sh squirrel-oracle --oracle NOREC
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.3.3 Figures 

The following scripts will generate *Figure 5b, d, g, j* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/MySQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/MySQL/NoREC/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/MySQL/NoREC/Comp_diff_tools/plots`. 

**Expectations**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. But in general, `SQLRight` should detect the most bugs (`>= 2` bugs in 72 hours).  
- For MySQL code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For MySQL query validity: `SQLRight` has higher validity than `Squirrel-oracle`. 
- For MySQL valid stmts / hr: `SQLRight` has more valid_stmts / hr than `Squirrel-oracle`.

---------------------------------------
### 3.4 SQLite TLP

#### 3.4.1 SQLRight   

<sub>`361` CPU hours</sub>

Run the following command. 

The bash command will invoke the fuzzing script inside Docker. Let the fuzzing processes run for `72` hours. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations.

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_TLP
# Run bug bisecting
bash run_sqlite_bisecting.sh SQLRight --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.4.2 Squirrel-Oracle 

<sub>`361` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**WARNING**: The `Squirrel-Oracle` process consumes a large amount of memory. In our evaluation, we observed a maximum of `100GB` of memory usage PER `Squirrel-Oracle` process after running for 72 hours. With 5 concurrent processes, the evalution could use in total of `600GB` of memory within 72 hours. If not enough memory is available, consider using a smaller number of `--num-concurrent`.  

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluation. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop squirrel_oracle_TLP
# Run bug bisecting
bash run_sqlite_bisecting.sh squirrel-oracle --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.4.3 SQLancer 

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `50GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `250GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluation. 

**Attention**: Expect some error messages: `unable to setup input stream: unable to set IO streams as raw terminal: input/output error`. It won't impact the evaluation process. 

```bash
cd <sqlright_root>/SQLite/scripts
# Call 5 instances of SQLancer. 
bash run_sqlite_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker ps --filter name=sqlancer_sqlite_TLP_raw_* --filter status=running -aq | xargs sudo docker stop
```

#### 3.4.4 Figures

The following scripts will generate *Figure 8a, c, f, i* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/SQLite/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/SQLite3/TLP/Comp_diff_tools/plots`.

**Expectations**:

- For SQLite logical bugs figure: `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 1` bugs being detected by `SQLRight` in `72` hours. 
- For SQLite code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For SQLite query validity: `SQLancer` have the highest query validity, while `SQLRight` performs better than `Squirrel-oracle`. 
- For SQLite valid stmts / hr: `SQLancer` have the highest valid stmts / hr, while `SQLRight` performs better than `Squirrel-oracle`.


--------------------------------------------------------------------------
### 3.5 PostgreSQL TLP

#### 3.5.1 SQLRight

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `72` hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker stop sqlright_postgres_TLP
```

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 3.5.2 Squirrel-Oracle

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker stop squirrel_oracle_TLP
```

#### 3.5.3 SQLancer

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `50GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `250GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

**Attention**: Expect some error messages: `unable to setup input stream: unable to set IO streams as raw terminal: input/output error`. It won't impact the evaluation process. 

```bash
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker ps --filter name=sqlancer_postgres_TLP_raw_* --filter status=running -aq | xargs sudo docker stop
```

#### 3.5.4 Figures 

The following scripts will generate *Figure 8e, h, k* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/PostgreSQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/Postgres/TLP/Comp_diff_tools_TLP
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/Postgres/TLP/Comp_diff_tools_TLP/plots`. 

**Expectations**:

- For PostgreSQL code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For PostgreSQL query validity: `SQLancer` have the highest query validity, while `SQLRight` performs better than `Squirrel-oracle`. 
- For PostgreSQL valid stmts / hr: `SQLancer` have the highest valid stmts / hr, while `SQLRight` performs better than `Squirrel-oracle`.

--------------------------------------------------------------------------
### 3.6 MySQL TLP

#### 3.6.1 SQLRight

<sub>`367` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. And then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_TLP
# Run bug bisecting
bash run_mysql_bisecting.sh SQLRight --oracle TLP
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.6.2 Squirrel-Oracle

<sub>`367` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop squirrel_oracle_TLP
# Run bug bisecting
bash run_mysql_bisecting.sh squirrel-oracle --oracle TLP
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.6.3 SQLancer

<sub>`360` CPU hours</sub>

Run the following command. Let the SQLancer processes run for 72 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

**WARNING**: The SQLancer process will generate a large amount of cache data, and it will save the cache to the file system. We expected around `20GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call `5` instances of SQLancer, which will dump `100GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`.

**Attention**: Expect some error messages: `unable to setup input stream: unable to set IO streams as raw terminal: input/output error`. It won't impact the evaluation process. 

```bash
cd <sqlright_root>/MySQL/scripts
bash run_mysql_fuzzing.sh sqlancer  --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

```bash
sudo docker ps --filter name=sqlancer_mysql_TLP_raw_* --filter status=running -aq | xargs sudo docker stop
```

#### 3.6.4 Figures

The following scripts will generate *Figure 8b, d, g, j* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/MySQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/MySQL/TLP/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/MySQL/TLP/Comp_diff_tools/plots`. 

**Expectations**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. But in general, `SQLRight` should detect the most bugs (`>= 1` bugs in 72 hours).  
- For MySQL code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For MySQL query validity: `SQLRight` has a higher validity than `Squirrel-oracle`. 
- For MySQL valid stmts / hr: `SQLRight` has more valid_stmts / hr than `Squirrel-oracle`.

<br/><br/>
## 4. Contribution of Code-Coverage Feedback

### 4.1 NoREC

#### 4.1.1 SQLRight

Make sure you have finished *Session 3.1.1* in this Artifact Evaluation. 

#### 4.1.2 SQLRight Drop All

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback drop_all 
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_drop_all_NOREC
# Run bug bisecting
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --feedback drop_all 
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.1.3 SQLRight Random Save

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategy, the `SQLRight` Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `15GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `75GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback random_save
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_random_save_NOREC
# Run bug bisecting
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --feedback random_save
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.1.4 SQLRight Save All

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategy, the `SQLRight` Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `20GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `100GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback save_all
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_save_all_NOREC
# Run bug bisecting
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --feedback save_all
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.1.5 Figures

Make sure you have finished the steps in `Session 4.1.1 - 4.1.4`. 

The following scripts will generate *Figure 6a, c* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/SQLite/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/SQLite3/NoREC/Feedback_Test
python3 copy_results.py
python3 run_plots.py
```

The figures will be saved in folder: `Plot_Scripts/SQLite3/NoREC/Feedback_Test/plots`.

**Expectations**:

- For bugs of SQLite (NoREC): `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 2` bugs being detected by `SQLRight` in `24` hours. 
- For coverage of SQLite (NoREC): `SQLRight` should have the highest code coverage among the other baselines. 

--------------------------------------
### 4.2 TLP

#### 4.2.1 SQLRight

Make sure you have finished `Session 3.4.1` in this Artifact Evaluation. 

#### 4.2.2 SQLRight Drop All

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback drop_all 
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_drop_all_TLP
# Run bug bisecting
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --feedback drop_all 
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.2.3 SQLRight Random Save

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategy, the `SQLRight` Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `15GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `75GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback random_save
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_random_save_TLP
# Run bug bisecting
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --feedback random_save
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.2.4 SQLRight Save All
<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategy, the `SQLRight` Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `20GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `100GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback save_all
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_save_all_TLP
# Run bug bisecting
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --feedback save_all
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.2.5 Figures

Make sure you have finished the steps in `Session 4.2.1 - 4.2.4`. 

The following scripts will generate *Figure 6b, d* in the paper. 

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/SQLite/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Feedback_Tests
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `Plot_Scripts/SQLite3/TLP/Feedback_Tests/plots`. 

**Expectations**:

- For bugs of SQLite (TLP): `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 2` bugs being detected by `SQLRight` in `24` hours. 
- For coverage of SQLite (TLP): `SQLRight` should have the highest code coverage among the other baselines. 

---------------------------------------------
### 4.3. Mutation Depth

Get the mutation depth information shown in the *Table 3* in the paper. 

Make sure you have finished all tests in *Session 4.1 and 4.2*. 

```bash
cd <sqlright_root>/Plot_scripts
python3 count_queue_depth.py
```

**Expectations**:

- The Queue Depth information will be returned. 
- The mutation depth number returned could be slightly different between each run. 
- The `Max Depth` from SQLRight NoREC and TLP should be larger than other baselines
- SQLRight NoREC and TLP should have more queue seeds located in a deeper depth, compared to other baselines. 


<br/><br/>
## 5. Contribution of Validity Components

### 5.1 SQLite NoREC

#### 5.1.1 SQLRight 

Make sure you have finished *Session 3.1.1* in this Artifact Evaluation. 

#### 5.1.2 SQLRight No-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_no_ctx_valid_NOREC
# Run bug bisecting
bash run_sqlite_bisecting.sh no-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.1.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_no_db_par_ctx_valid_NOREC
# Run bug bisecting
bash run_sqlite_bisecting.sh no-db-par-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.1.4 Squirrel-Oracle

Make sure you have finished *Session 3.1.2* in this Artifact Evaluation. 

#### 5.1.5 SQLRight Non-Deter

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_NOREC_non_deter
# Run bug bisecting
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --non-deter
```

The bug bisecting process is expected to finish in `1` hour. 

#### 5.1.6 Figures

The following scripts will generate *Figure 7a, c, f, i* in the paper.

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/SQLite/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/SQLite3/NoREC/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder: `<sqlright_root>/Plot_Scripts/SQLite3/NoREC/Validate_Parts/plots`. 

**Expectations**:

- For SQLite logical bugs figure: `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 2` bugs being detected by `SQLRight` in `24` hours. Additionally, we have muted the `SQLRight non-deter` config in the Artifact logical bugs figure. Because sometimes `non-deter` could produce tens of False Positives, which would destory the plot region and render the script outputs an unreadable plots. 
- For SQLite code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. `SQLRight non-ctx-valid` could have a coverage very close to the `SQLRight` config, but in general, `SQLRight non-ctx-valid` is slightly worse in coverage compared to `SQLRight`. 
- For SQLite query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For SQLite valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

--------------------------------------------------------------
### 5.2 PostgreSQL NoREC

#### 5.2.1 SQLRight

Make sure you have finished *Session 3.2.1* in this Artifact Evaluation. 

#### 5.2.2 SQLRight No-Ctx-Valid

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. 

```bash
sudo docker stop sqlright_postgres_no_ctx_valid_NOREC
```

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 5.2.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `24` hours.

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `24` hours, stop the Docker container instance. 

```bash
sudo docker stop sqlright_postgres_no_db_par_ctx_valid_NOREC
```

#### 5.2.4 Squirrel-Oracle

Make sure you have finished *Session 3.2.2* in this Artifact Evaluation. 

#### 5.2.5 Figures

Because we did not detect False Positives when using `SQLRight non-deter` in our PostgreSQL evaluations, the current `SQLRight non-deter` implementation is basically identical to `SQLRight`. We therefore skip `SQLRight non-deter` in this Artifact Evaluation. 

The following scripts will generate *Figure 7e, h, k* in the paper.

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/PostgreSQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/Postgres/NoREC/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder: `<sqlright_root>/Plot_Scripts/Postgres/NoREC/Validate_Parts/plots`. 

**Expectations**:

- For PostgreSQL code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. `SQLRight non-ctx-valid` could have a coverage very close to the `SQLRight` config, but in general, `SQLRight non-ctx-valid` is slightly worse in coverage compared to `SQLRight`. 
- For PostgreSQL query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For PostgreSQL valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

--------------------------------------------------------------------------
### 5.3 MySQL NoREC

#### 5.3.1 SQLRight

Make sure you have finished *Session 3.3.1* in this Artifact Evaluation. 

#### 5.3.2 SQLRight No-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_no_ctx_valid_NOREC
# Run bug bisecting
bash run_mysql_bisecting.sh no-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `5` hours.

#### 5.3.3 SQLRight No-DB-Par-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process.
bash run_mysql_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_no_db_par_ctx_valid_NOREC
# Run bug bisecting
bash run_mysql_bisecting.sh no-db-par-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.3.4 Squirrel-Oracle 

Make sure you have finished *Session 3.3.2* in this Artifact Evaluation. 

#### 5.3.5 SQLRight Non-Deter

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_NOREC_non_deter
# Run bug bisecting
bash run_mysql_bisecting.sh SQLRight --oracle NOREC --non-deter
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.3.6 Figures

The following scripts will generate *Figure 7b, d, g, j* in the paper.

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/MySQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/MySQL/NoREC/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

**Expectations**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. In general, `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 1` bugs being detected by `SQLRight` in `24` hours. Additionally, we have muted the `SQLRight non-deter` config in the Artifact logical bugs figure. Because sometimes `non-deter` could produce tens of False Positives, which would destory the plot region and render the script outputs an unreadable plots. 
- For MySQL code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. `SQLRight non-ctx-valid` could have a coverage very close to the `SQLRight` config, but in general, `SQLRight non-ctx-valid` is slightly worse in coverage compared to `SQLRight`. 
- For MySQL query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For MySQL valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

--------------------------------------------------
### 5.4 SQLite TLP

#### 5.4.1 SQLRight 

Make sure you have finished *Session 3.4.1* in this Artifact Evaluation. 

#### 5.4.2 SQLRight No-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_no_ctx_valid_TLP
# Run bug bisecting
bash run_sqlite_bisecting.sh no-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.4.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_no_db_par_ctx_valid_TLP
# Run bug bisecting
bash run_sqlite_bisecting.sh no-db-par-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.4.4 Squirrel-Oracle

Make sure you have finished *Session 3.4.2* in this Artifact Evaluation. 

#### 5.4.5 SQLRight Non-Deter

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_sqlite_TLP_non_deter
# Run bug bisecting
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --non-deter
```

The bug bisecting process is expected to finish in `1` hour. 

#### 5.4.6 Figures

The following scripts will generate *Figure 9a, c, f, i* in the paper.

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/SQLite/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder: `<sqlright_root>/Plot_Scripts/SQLite3/TLP/Validate_Parts/plots`. 

**Expectations**:

- For SQLite logical bugs figure: `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 2` bugs being detected by `SQLRight` in `24` hours. Additionally, we have muted the `SQLRight non-deter` config in the Artifact logical bugs figure. Because sometimes `non-deter` could produce tens of False Positives, which would destory the plot region and render the script outputs an unreadable plots. 
- For SQLite code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. 
- For SQLite query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For SQLite valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

--------------------------------------------------------------
### 5.5 PostgreSQL TLP

#### 5.5.1 SQLRight

Make sure you have finished *Session 3.5.1* in this Artifact Evaluation. 

#### 5.5.2 SQLRight No-Ctx-Valid

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. 

```bash
sudo docker stop sqlright_postgres_no_ctx_valid_TLP
```

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 5.5.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `24` hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After `24` hours, stop the Docker container instance. 

```bash
sudo docker stop sqlright_postgres_no_db_par_ctx_valid_TLP
```

#### 5.5.4 Squirrel-Oracle

Make sure you have finished *Session 3.5.2* in this Artifact Evaluation. 

#### 5.5.5 Figures

Because we did not detect False Positives when using `SQLRight non-deter` in our PostgreSQL evaluations, the current `SQLRight non-deter` implementation is basically identical to `SQLRight`. We therefore skip `SQLRight non-deter` in this Artifact Evaluation. 

The following scripts will generate *Figure 9e, h, k* in the paper.

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/PostgreSQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/Postgres/TLP/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder: `<sqlright_root>/Plot_Scripts/Postgres/NoREC/Validate_Parts/plots`. 

**Expectations**:

- For PostgreSQL code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. `SQLRight non-ctx-valid` could have a coverage very close to the `SQLRight` config, but in general, `SQLRight non-ctx-valid` is slightly worse in coverage compared to `SQLRight`. 
- For PostgreSQL query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For PostgreSQL valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

--------------------------------------------------------------------------
### 5.6 MySQL TLP

#### 5.6.1 SQLRight

Make sure you have finished *Session 3.6.1* in this Artifact Evaluation. 

#### 5.6.2 SQLRight No-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_no_ctx_valid_TLP
# Run bug bisecting
bash run_mysql_bisecting.sh no-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `5` hours.

#### 5.6.3 SQLRight No-DB-Par-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process.
bash run_mysql_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_no_db_par_ctx_valid_TLP
# Run bug bisecting
bash run_mysql_bisecting.sh no-db-par-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.6.4 Squirrel-Oracle 

Make sure you have finished *Session 3.6.2* in this Artifact Evaluation. 

#### 5.6.5 SQLRight Non-Deter

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```bash
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```bash
# Stop the fuzzing process
sudo docker stop sqlright_mysql_TLP_non_deter
# Run bug bisecting
bash run_mysql_bisecting.sh SQLRight --oracle TLP --non-deter
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.6.6 Figures

The following scripts will generate *Figure 9b, d, g, j* in the paper.

```bash
# If you use the `root` user to execute the docker command. It is possible that you need to change the privilege access for the Results output folder. 
cd <sqlright_root>/MySQL/Results
sudo chown -R <your_user_name> ./*

# Plot the figures
cd <sqlright_root>/Plot_Scripts/MySQL/TLP/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

**Expectations**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. In general, `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 1` bugs being detected by `SQLRight` in `24` hours. Additionally, we have muted the `SQLRight non-deter` config in the Artifact logical bugs figure. Because sometimes `non-deter` could produce tens of False Positives, which would destory the plot region and render the script outputs an unreadable plots. 
- For MySQL code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. `SQLRight non-ctx-valid` could have a coverage very close to the `SQLRight` config, but in general, `SQLRight non-ctx-valid` is slightly worse in coverage compared to `SQLRight`. 
- For MySQL query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For MySQL valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

--------------------------------------------------------------------------
### 5.7 False Positives from Non-Deter

Make sure you have finished *Section 5.1 - 5.6* first.

The following scripts will generate *Table 4* in the paper. 

```bash
cd <sqlright_root>/Plot_Scripts/
python3 count_false_positives.py
```

**Expectations**:

- The script will return the reported bug numbers for the configs in *Table 4*. 
- We have introduced some extra filters that can filter out obvious False Positives. We includes these filters in the Artifact implementation, in order to reduce the manual efforts for excluding FPs, and to produce a more accurate bug numbers. Therefore, the bug number reported by the current Artifact script could be slightly less than the ones we reported in the paper (*Table 3*). 
- For all configurations, the `WITHOUT non-deter` settings should always have less bugs reported compared to the `WITH non-deter` settings, due to the extra False Positives produced by the non-deterministic queries. 


<br/><br/>
<br/><br/>
# End of the Artifact Evaluation Instructions

We hereby thank all the reviewers for putting in the hard work to reproduce the results we presented in the paper. 

Have a great Summer. And have a great USENIX Security 2022 conference! 
