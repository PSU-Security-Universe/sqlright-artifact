# SQLRight - Deploy Postgres

Attention: the latest version of postgre cannot compiled with afl-gcc. A post referring to this error was posted in (https://postgrespro.com/list/thread-id/2557651和https://buildfarm.postgresql.org/cgi-bin/show_log.pl?nm=hoverfly&dt=2021-07-02%2010%3A10%3A29) (Currently unavailable.) (Jul 14, 2021)

``` shell
! nm -A -u libpq.so.5 2>/dev/null | grep -v __cxa_atexit | grep exit
libpq.so.5: atexit               U           -
```

You can choose to compile with the latest released version, such as: `git checkout REL_14_BETA2`. 
  * [ ] 
## Postgre Dependencies

``` shell
# ubuntu
sudo apt-get install build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc
# centos
sudo yum install -y bison-devel readline-devel zlib-devel openssl-devel wget
```

## Compiling Postgre

```shell
git clone https://github.com/postgres/postgres.git
cd postgre 

# Use an old version Postgres for now because of the compile error mentioned above.
git checkout REL_14_BETA2

# Construct the workdir
mkdir -p bld/$(git rev-parse HEAD)
cd bld/$(git rev-parse HEAD)

# Set up the env
export CC=$(PATH-TO-afl-gcc)
export CXX=$(PATH-TO-afl-g++)

# Compile Postgres, and install it in the current workdir. 
../../configure --prefix=$(pwd)
make -j$(nproc)
make install

# Create a new dir for database, and create a new database named x. 
./bin/initdb -D ./data
./bin/pg_ctl -D ./data start 
./bin/createdb x
./bin/pg_ctl -D ./data stop 

```

## Install libpq

libpq is the C application programmer's interface to PostgreSQL. We use it to connect to Postgres backend. 

``` shell
# ubuntu
sudo apt-get install -y libpq-dev
# centos
sudo yum install postgresql-devel
```

## Run the Fuzzer!!!

!!Create folder `bug_sample` under `Bug_Analysis`. This is required by the fuzzer to dump bug reports. 

Open two terminals, run SqlRight and Postgres respectively.

In the **first** terminal, run the following command to invoke the SqlRight fuzzer. 

``` shell
./afl-fuzz -t 2000 -m 2000 -i ./inputs  -o ./outputs aaa
```

SqlRight would output the shared_memory_id. Mark it. In this stage, SqlRight would be suspended. 

In the **second** terminal. Run the Postgres backend. 

``` shell
__AFL_SHM_ID=xxxxx ./bin/postgres -D ./data
```

Set the __AL_SHM_ID as the shared_memory_id provided from SQLRight. 

Back to the **first** terminal, SQLRight are still being suspended. Hit `Enter` key to evoke SQLRight and start fuzzing. 

> Postgres back-end use 5432 as the default port for communicating with the front-end. We set port=5432 as default port for SQLRight too. If you want to run multiple instances of fuzzing, you need to specified different ports to suit your needs. 
