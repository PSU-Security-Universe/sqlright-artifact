# sqlright-artifact: The code, analysis scripts and results for USENIX 2022 Artifact Evaluation

<a href="Paper/paper_no_names.pdf"><img src="Paper/paper_no_names.png" align="right" width="250"></a>

Version: 1.0\
Update: May 24, 2022
Paper: Detecting Logical Bugs of DBMS with Coverage-based Guidance

This document is to help users reproduce the results we reported in our submission. 

Currently supported DBMS:
1. SQLite3
2. PostgreSQL
3. MySQL

<br/><br/>
## Getting Started

### Operating System configuration and Source Code setup

All of the experiments are evaluated on a `X86-64` CPU with `Ubuntu 20.04 LTS` operating system. We recommand more than `500GB` of memory for the evaluation and `1.5TB` hard drive storage (preferably SSDs). All the experiments are evaluated in a Docker env, we recommend to use Docker version >= `20.10.16` to reproduce the results. Before the start of the experiment, we need to configure a few system settings to be applied to the host operating system. 

```sh
# Open a terminal from the Ubuntu system if you are using a Desktop distribution. 
sudo apt-get install build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc
sudo apt-get install -y libpq-dev

# Disable On-demand CPU scaling
cd /sys/devices/system/cpu
echo performance | sudo tee cpu*/cpufreq/scaling_governor

# Avoid having crashes being misinterpreted as hangs
sudo sh -c " echo core >/proc/sys/kernel/core_pattern "
```

Since the operating system will automatically reset some settings, we need to reset the system settgings using the above script every time the computer is being restarted. If the system settings are not setup correctly, the fuzzing process inside Docker will be failed to run. 

We will use some python3 script to generate the plots. Therefore, we should install some python3 dependencies in the host operating system. 
```sh
sudo apt-get install python3
sudo apt-get install python3-pip

# Use root to run pip3 if necessary. 
pip3 install matplotlib
pip3 install numpy
pip3 install pandas
pip3 install paramiko
```

And then, go to the path where you want to dump the sqlright source code:

```sh
cd ~ # Assuming the home directory
git clone git@github.com:PSU-Security-Universe/sqlright-artifact.git  # TODO: May refer to other link if we are using Zenodo. 
```

<br/><br/>
## 0. Artifact Expectation

The total Artifact Evaluation is expected to consume a total of `8834` CPU hours. We recommend using a machine with >= `20` cores of CPU, `500GB` of memory and `1.5TB` of storage space(preferably SSDs) to reproduce the results. The code and the scripts of our built tool `SQLRight` are being released in this repository. Using the instructions below, one should be able to reproduce all the evaluations (Figures, Tables) shown in our Final Paper. 


<br/><br/>
## 1. Artifact Overview

Our paper presents `SQLRight`, a tool that combines coverage-based guidance, validity-oriented mutations and oracles to detect logical bugs in Database Management Systems. For Artifact Evaluation, we release:

- (1) The `SQLRight` source code. 
- (2) The paper's final version. [Paper Link in Repo](Paper/paper_no_names.pdf)
- (3) Information and the script to reproduce the evaluated benchmarks. 

**Session 2** contains the instructions to build all the Docker images required for our evaluation. These are the prerequisite steps before we run any fuzzing evaluations. 

**Session 3** contains the instructions to evaluate `Comparison with Existing Tools` (**Section 5.2** in the paper). It includes the steps to generate the figures from *Figure 5* and *Figure 8* in the paper. It consumes about `6152` CPU hours.

**Session 4** contains the instructions to evaluate `Contribution of Coverage Feedback` (**Section 5.3** in the paper). It includes the steps to generate *Figure 6* and *Table 3* in the paper. It consumes about `726` CPU hours.

**Session 5** contains the instructions to evalute `Contribution of Validity` (**Section 5.4** in the paper). It includes the steps to generate *Figure 7*, *Figure 9* and *Table 4* in the paper. It consumes about `1956` CPU hours.


<br/><br/>
## 2.  Build the Docker Images

### 2.1  Build the Docker Image for SQLite3 evaluations

Execute the following command before running any SQLite3 related evaluations. 

The Docker build process can last for about `1` hour. Expect long runtime when executing the commands. 
```sh
cd <sqlright_root>/SQLite/scripts/
bash setup_sqlite.sh
```

After the command finihsed, a Docker Image named `sqlright_sqlite` is created. 

--------------------------------------------------------------------------
### 2.2  Build the Docker Image for PostgreSQL evaluations

Execute the following command before running any PostgreSQL related evaluations. 

The Docker build process can last for about `1` hour. Expect long runtime when executing the commands. 
```sh
cd <sqlright_root>/PostgreSQL/scripts/
bash setup_postgres.sh
```

After the command finihsed, a Docker Image named `sqlright_postgres` is created. 

--------------------------------------------------------------------------
### 2.3  Build the Docker Image for MySQL evaluations

Execute the following command before running any PostgreSQL related evaluations. 

The Docker build process can last for about `3` hour. Expect long runtime when executing the commands. The created Docker Image will have around `70GB` of storage space. 
```sh
cd <sqlright_root>/MySQL/scripts/
bash setup_mysql.sh
bash setup_mysql_bisecting.sh
```

After the command finihsed, two Docker Images named `sqlright_mysql` and `sqlright_mysql_bisecting` are created. 



<br/><br/>
## 3. Comparison Between Different Tools

### 3.1 SQLite, NoREC oracle

#### 3.1.1 SQLRight   

<sub>`361` CPU hours</sub>

Run the following command. 

The bash command will invoke the fuzzing script inside Docker. Let the fuzzing processes run for `72` hours. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based)
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

Explanation of the command:

- The `start-core` flag binds the fuzzing process to the specific CPU core. 

- The `num-concurrent` flag determines the number of concurrent fuzzing processes. 

- The `oracle` flag determines the oracle used for the fuzzing. Currently support: `NOREC` and `TLP`. 

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.1.2 Squirrel-Oracle 

<sub>`361` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**WARNING**: The `Squirrel-Oracle` process consumes a large amount of memory. In our evaluation, we observed a maximum of `190GB` of memory usage PER `Squirrel-Oracle` process after running for 72 hours. With 5 concurrent processes, the evalution could use in total of `600GB` of memory within 72 hours. If not enough memory is available, consider using a smaller number of `--num-concurrent`.  

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
bash run_sqlite_bisecting.sh squirrel-oracle --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.1.3 SQLancer 

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `80GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `400GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/SQLite/scripts
# Call 5 instances of SQLancer. 
bash run_sqlite_fuzzing.sh sqlancer --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. 

#### 3.1.4 Figures. 

The following scripts will generate *Figure 5a, c, f, i* in the paper. 

```sh
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
### 3.2 PostgreSQL, NoREC

#### 3.2.1 SQLRight

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `72` hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. 

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 3.2.2 Squirrel-Oracle.

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. 

#### 3.2.3 SQLancer

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `50GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `250GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh sqlancer --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. 

#### 3.2.4 Figures 

The following scripts will generate *Figure 5e, h, k* in the paper. 

```sh
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
### 3.3 MySQL, NoREC

#### 3.3.1 SQLRight

<sub>`367` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance. And then run the following bug bisecting command. 

```sh
bash run_mysql_bisecting.sh SQLRight --oracle NOREC
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.3.2 Run the Squirrel with oracle MySQL fuzzing for 72 hours.

<sub>`367` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
bash run_mysql_bisecting.sh squirrel-oracle --oracle NOREC
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.3.3 Plot the figures. 

The following scripts will generate *Figure 5b, d, g, j* in the paper. 

```sh
cd <sqlright_root>/Plot_Scripts/MySQL/NoREC/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/MySQL/NoREC/Comp_diff_tools/plots`. 

**Expectation**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. But in general, `SQLRight` should detect the most bugs (`>= 2` bugs in 72 hours).  
- For MySQL code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For MySQL query validity: `SQLRight` has higher validity than `Squirrel-oracle`. 
- For MySQL valid stmts / hr: `SQLRight` has more valid_stmts / hr than `Squirrel-oracle`.

---------------------------------------
### 3.4 SQLite, TLP oracle

#### 3.4.1 SQLRight   

<sub>`361` CPU hours</sub>

Run the following command. 

The bash command will invoke the fuzzing script inside Docker. Let the fuzzing processes run for `72` hours. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations.

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
bash run_sqlite_bisecting.sh SQLRight --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.4.2 Squirrel-Oracle 

<sub>`361` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**WARNING**: The `Squirrel-Oracle` process consumes a large amount of memory. In our evaluation, we observed a maximum of `100GB` of memory usage PER `Squirrel-Oracle` process after running for 72 hours. With 5 concurrent processes, the evalution could use in total of `500GB` of memory within 72 hours. If not enough memory is available, consider using a smaller number of `--num-concurrent`.  

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
bash run_sqlite_bisecting.sh squirrel-oracle --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour. 

#### 3.4.3 SQLancer 

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `50GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `250GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/SQLite/scripts
# Call 5 instances of SQLancer. 
bash run_sqlite_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

#### 3.4.4 Figures. 

The following scripts will generate *Figure 8a, c, f, i* in the paper. 

```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Comp_diff_tool
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/SQLite3/TLP/Comp_diff_tool/plots`.

**Expectations**:

- For SQLite logical bugs figure: `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 1` bugs being detected by `SQLRight` in `72` hours. 
- For SQLite code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For SQLite query validity: `SQLancer` have the highest query validity, while `SQLRight` performs better than `Squirrel-oracle`. 
- For SQLite valid stmts / hr: `SQLancer` have the highest valid stmts / hr, while `SQLRight` performs better than `Squirrel-oracle`.


--------------------------------------------------------------------------
### 3.5 PostgreSQL, TLP

#### 3.5.1 SQLRight

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `72` hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 3.5.2 Squirrel-Oracle.

<sub>`360` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

#### 3.5.3 SQLancer

<sub>`360` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

**WARNING**: The SQLancer process will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `50GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `250GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
bash run_postgres_fuzzing.sh sqlancer --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

#### 3.5.4 Figures 

The following scripts will generate *Figure 8e, h, k* in the paper. 

```sh
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
### 3.6 MySQL, TLP

#### 3.6.1 SQLRight

<sub>`367` CPU hours</sub>

Run the following command. Let the `SQLancer` processes run for 72 hours. 

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. And then run the following bug bisecting command. 

```sh
bash run_mysql_bisecting.sh SQLRight --oracle TLP
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.6.2 Squirrel-Oracle.

<sub>`367` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 72 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh squirrel-oracle --start-core 0 --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
bash run_mysql_bisecting.sh squirrel-oracle --oracle TLP
```

The bug bisecting process is expected to finish in `7` hours. 

#### 3.6.3 SQLancer.

<sub>`360` CPU hours</sub>

Run the following command. Let the SQLancer processes run for 72 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

**WARNING**: The SQLancer process will generate a large amount of cache data, and it will save the cache to the file system. We expected around `20GB` of cache being generated from EACH SQLancer instances. Following the command below, we will call 5 instances of SQLancer, which will dump `100GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`.

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh sqlancer  --num-concurrent 5 --oracle TLP
```

After `72` hours, stop the Docker container instance. 

#### 3.6.4 Figures. 

The following scripts will generate *Figure 8b, d, g, j* in the paper. 

```sh
cd <sqlright_root>/Plot_Scripts/MySQL/TLP/Comp_diff_tools
python3 copy_results.py
python3 run_plots.py
```

The figures will be generated in folder `<sqlright_root>/Plot_Scripts/MySQL/TLP/Comp_diff_tools/plots`. 

**Expectation**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. But in general, `SQLRight` should detect the most bugs (`>= 1` bugs in 72 hours).  
- For MySQL code coverage figure: `SQLRight` should have the highest code coverage among the other baselines. 
- For MySQL query validity: `SQLRight` has a higher validity than `Squirrel-oracle`. 
- For MySQL valid stmts / hr: `SQLRight` has more valid_stmts / hr than `Squirrel-oracle`.

<br/><br/>
## 4. Contribution of Code-Coverage Feedback

### 4.1 NoREC oracle

#### 4.1.1 SQLRight

Make sure you have finished *Session 3.1.1* in this Artifact Evaluation. 

#### 4.1.2 SQLRight Drop All

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback drop_all 
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --feedback drop_all 
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.1.3 SQLRight Random Save

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategies, the SQLright Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `15GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `75GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback random_save
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --feedback random_save
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.1.4 Run the SQLRight SQLite3 Save All configiguration, for 24 hours:

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategies, the SQLright Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `20GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `100GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --feedback save_all
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --feedback save_all
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.1.5 Figures:

Make sure you have finished the steps in `Session 4.1.1 - 4.1.4`. 

The following scripts will generate *Figure 6a, c* in the paper. 

```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/NoREC/Feedback_Test
python3 copy_results.py
python3 run_plots.py
```

**Expectations**:

- For bugs of SQLite (NoREC): `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 2` bugs being detected by `SQLRight` in `24` hours. 
- For coverage of SQLite (NoREC): `SQLRight` should have the highest code coverage among the other baselines. 

### 4.2 TLP oracle:

#### 4.2.1 SQLRight

Make sure you have finished `Session 3.4.1` in this Artifact Evaluation. 

#### 4.2.2 SQLRight Drop All

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback drop_all 
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --feedback drop_all 
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.2.3 SQLRight Random Save

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategies, the SQLright Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `15GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `75GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback random_save
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --feedback random_save
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.2.4 Run the SQLRight SQLite3 Save All configiguration, for 24 hours:

<sub>`121` CPU hours</sub>

**WARNING**: Due to the aggresive query seed handling strategies, the SQLright Random Save config will generate a large amount of `cache` data, and it will save the cache to the file system. We expected around `20GB` of cache being generated from EACH SQLRight instance. Following the command below, we will call 5 instances of SQLancer, which will dump `100GB` of cache data. If not enough storage space is available, consider using a smaller number of `--num-concurrent`. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --feedback save_all
```

After `24` hours, stop the Docker container instance, and then run the following bug bisecting command. 

```sh
cd <sqlright_root>/SQLite/scripts
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --feedback save_all
```

The bug bisecting process is expected to finish in `1` hours. 

#### 4.2.5 Figures:

Make sure you have finished the steps in `Session 4.2.1 - 4.2.4`. 

The following scripts will generate *Figure 6b, d* in the paper. 

```sh
cd <sqlright_root>/Plot_Scripts/SQLite3/TLP/Feedback_Test
python3 copy_results.py
python3 run_plots.py
```

**Expectations**:

- For bugs of SQLite (TLP): `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 2` bugs being detected by `SQLRight` in `24` hours. 
- For coverage of SQLite (TLP): `SQLRight` should have the highest code coverage among the other baselines. 

## 4.3. Mutation Depth

Get the mutation depth information shown in the *Table 3* in the paper. 

Make sure you have finished *Session 4.1 and 4.2*.  

```sh
cd <sqlright_root>/Plot_scripts
python3 count_queue_depth.py
```

**Expectations**:

- The Queue Depth information would be returned. 
- The mutation depth number returned could be slightly different between each run. 
- The `Max Depth` from SQLRight NoREC and TLP should be larger than other baselines
- SQLRight NoREC and TLP should have more queue seeds located in a deeper depth, compared to other baselines. 


<br/><br/>
## 5. Contribution of Validity Components

### 5.1 SQLite, NoREC Oracle

#### 5.1.1 SQLRight 

Make sure you have finished *Session 3.1.1* in this Artifact Evaluation. 

#### 5.1.2 SQLRight No-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_sqlite_bisecting.sh no-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.1.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_sqlite_bisecting.sh no-db-par-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.1.4 Squirrel-Oracle

Make sure you have finished *Session 3.1.2* in this Artifact Evaluation. 

#### 5.1.5 SQLRight Non-Deter

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_sqlite_bisecting.sh SQLRight --oracle NOREC --non-deter
```

The bug bisecting process is expected to finish in `1` hour. 

#### 5.1.6 Figures:

The following scripts will generate *Figure 7a, c, f, i* in the paper.

```sh
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
### 5.2 PostgreSQL, NoREC oracle

#### 5.2.1 SQLRight

Make sure you have finished *Session 3.2.1* in this Artifact Evaluation. 

#### 5.2.2 SQLRight No-Ctx-Valid

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. 

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 5.2.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `24` hours.

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After `24` hours, stop the Docker container instance. 

#### 5.2.4 Run the Squirrel-oracle fuzzing for 24 hours. 

Make sure you have finished *Session 3.2.2* in this Artifact Evaluation. 

#### 5.2.5 Plot the figures:

Because we did not detect False Positives when using `SQLRight non-deter` in our PostgreSQL evaluations, the current `SQLRight non-deter` implementation is basically identical to `SQLRight`. We therefore skip `SQLRight non-deter` in this Artifact Evaluation. 

The following scripts will generate *Figure 7e, h, k* in the paper.

```sh
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
### 5.3 MySQL, NoREC oracle

#### 5.3.1 SQLRight

Make sure you have finished *Session 3.3.1* in this Artifact Evaluation. 

#### 5.3.2 SQLRight No-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_mysql_bisecting.sh no-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `5` hours.

#### 5.3.3 SQLRight No-DB-Par-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process.
bash run_mysql_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle NOREC
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_mysql_bisecting.sh no-db-par-ctx-valid --oracle NOREC
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.3.4 Squirrel-Oracle 

Make sure you have finished *Session 3.3.2* in this Artifact Evaluation. 

#### 5.3.5 SQLRight Non-Deter

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle NOREC --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_mysql_bisecting.sh SQLRight --oracle NOREC --non-deter
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.3.6 Figures:

The following scripts will generate *Figure 7b, d, g, j* in the paper.

```sh
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
### 5.4 SQLite, TLP Oracle

#### 5.4.1 SQLRight 

Make sure you have finished *Session 3.4.1* in this Artifact Evaluation. 

#### 5.4.2 SQLRight No-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_sqlite_bisecting.sh no-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.4.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_sqlite_bisecting.sh no-db-par-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `1` hour.

#### 5.4.4 Squirrel-Oracle

Make sure you have finished *Session 3.4.2* in this Artifact Evaluation. 

#### 5.4.5 SQLRight Non-Deter

<sub>`121` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/SQLite/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_sqlite_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_sqlite_bisecting.sh SQLRight --oracle TLP --non-deter
```

The bug bisecting process is expected to finish in `1` hour. 

#### 5.4.6 Figures:

The following scripts will generate *Figure 9a, c, f, i* in the paper.

```sh
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
### 5.5 PostgreSQL, TLP oracle

#### 5.5.1 SQLRight

Make sure you have finished *Session 3.5.1* in this Artifact Evaluation. 

#### 5.5.2 SQLRight No-Ctx-Valid

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. 

Since we did not find any bugs for PostgreSQL, we skip the bug bisecting process for PostgreSQL fuzzings. 

#### 5.5.3 SQLRight No-DB-Par-Ctx-Valid 

<sub>`120` CPU hours</sub>

Run the following command. Let the fuzzing processes run for `24` hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/PostgreSQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_postgres_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After `24` hours, stop the Docker container instance. 

#### 5.5.4 Run the Squirrel-oracle fuzzing for 24 hours. 

Make sure you have finished *Session 3.5.2* in this Artifact Evaluation. 

#### 5.5.5 Plot the figures:

Because we did not detect False Positives when using `SQLRight non-deter` in our PostgreSQL evaluations, the current `SQLRight non-deter` implementation is basically identical to `SQLRight`. We therefore skip `SQLRight non-deter` in this Artifact Evaluation. 

The following scripts will generate *Figure 9e, h, k* in the paper.

```sh
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
### 5.6 MySQL, TLP oracle

#### 5.6.1 SQLRight

Make sure you have finished *Session 3.6.1* in this Artifact Evaluation. 

#### 5.6.2 SQLRight No-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh no-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_mysql_bisecting.sh no-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `5` hours.

#### 5.6.3 SQLRight No-DB-Par-Ctx-Valid

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process.
bash run_mysql_fuzzing.sh no-db-par-ctx-valid --start-core 0 --num-concurrent 5 --oracle TLP
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_mysql_bisecting.sh no-db-par-ctx-valid --oracle TLP
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.6.4 Squirrel-Oracle 

Make sure you have finished *Session 3.6.2* in this Artifact Evaluation. 

#### 5.6.5 SQLRight Non-Deter

<sub>`125` CPU hours</sub>

Run the following command. Let the fuzzing processes run for 24 hours.

**Attention**: Be careful with the `--oracle` flag. Here we are using `TLP` instead of `NOREC` in the previous evaluations. 

```sh
cd <sqlright_root>/MySQL/scripts
# Run the fuzzing with CPU core 1~5 (core id is 0-based). 
# Please adjust the CORE ID based on your machine, 
# and do not use conflict core id with other running evaluation process. 
bash run_mysql_fuzzing.sh SQLRight --start-core 0 --num-concurrent 5 --oracle TLP --non-deter
```

After 24 hours, stop the Docker container instance. And then run the following bug bisecting command:

```sh
bash run_mysql_bisecting.sh SQLRight --oracle TLP --non-deter
```

The bug bisecting process is expected to finish in `5` hour.

#### 5.6.6 Figures:

The following scripts will generate *Figure 9b, d, g, j* in the paper.

```sh
cd <sqlright_root>/Plot_Scripts/MySQL/TLP/Validate_Parts
python3 copy_results.py
python3 run_plots.py
```

**Expectations**:

- For MySQL logical bugs figure: The current bisecting and bug filtering scipts could slightly over-estimate the number of unique bugs for MySQL. Some manual efforts might be needed to scan through the bug reports and deduplicate the bugs. In general, `SQLRight` should detect the most bugs. On different evaluation arounds, we expect `>= 1` bugs being detected by `SQLRight` in `24` hours. Additionally, we have muted the `SQLRight non-deter` config in the Artifact logical bugs figure. Because sometimes `non-deter` could produce tens of False Positives, which would destory the plot region and render the script outputs an unreadable plots. 
- For MySQL code coverage figure: `SQLRight` and `SQLRight non-deter` should have the highest code coverage among the other baselines. `SQLRight non-ctx-valid` could have a coverage very close to the `SQLRight` config, but in general, `SQLRight non-ctx-valid` is slightly worse in coverage compared to `SQLRight`. 
- For MySQL query validity: `SQLRight` and `SQLRight non-deter` should have the highest query validity. 
- For MySQL valid stmts / hr: `SQLRight` and `SQLRight non-deter` should have the highest number of valid stmts / hr. 

<br/><br/>
<br/><br/>
# End of the Artifact Evaluation Instructions

We hereby thank all the reviewers for putting in the hard work to reproduce the results we presented in the paper. 

Have a great Summer and have a great USENIX Security 2022 conferece! 
