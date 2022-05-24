FROM ubuntu:20.04
MAINTAINER "dobigthing"

RUN apt -y update
RUN apt -y upgrade
RUN apt -y install bison
RUN apt -y install build-essential
RUN apt -y install clang
RUN apt -y install cmake
RUN apt -y install flex
RUN apt -y install g++-multilib
RUN apt -y install gcc-multilib
RUN apt -y install gdb
RUN apt -y install git
RUN apt -y install libncurses5-dev
RUN apt -y install libreadline-dev
RUN apt -y install libssl-dev
RUN apt -y install make
RUN apt -y install pkg-config
RUN apt -y install python3
RUN apt -y install python3-pip
RUN apt -y install tmux
RUN apt -y install vim
RUN apt -y install xinetd
RUN apt -y install zlib1g-dev 
RUN apt -y install screen
RUN apt -y install watch
RUN pip install libtmux

RUN useradd -ms /bin/bash mysql

# build normal AFL
WORKDIR /home/mysql
RUN git clone git@github.com:SteveLeungYL/AFL.git
WORKDIR /home/mysql/AFL 
RUN git checkout block_cov
RUN make
WORKDIR /home/mysql/AFL/llvm_mode
ENV LLVM_CONFIG=llvm-config-6.0
RUN make 

# build MySQL instrumented by afl-clang-fast
USER mysql
WORKDIR /home/mysql/
RUN git clone https://github.com/mysql/mysql-server.git
WORKDIR /home/mysql/mysql-server
# MySQL version 8.0.27
RUN git checkout 3290a66c89eb1625a7058e0ef732432b6952b435 
RUN mkdir bld
WORKDIR /home/mysql/mysql-server/bld
ENV CC=/home/mysql/AFL/afl-clang-fast
ENV CXX=/home/mysql/AFL/afl-clang-fast++
RUN cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost -DWITH_DEBUG=1
RUN make -j15

# set up MySQL
USER root
RUN mkdir data
RUN bin/mysqld --initialize-insecure --user=mysql --datadir=data
RUN bin/mysql_ssl_rsa_setup --datadir=data
RUN mkdir data_all
RUN mv data data_all/ori_data

# set up fuzzing
USER root
RUN mkdir -p /home/mysql/fuzzing/fuzz_root
RUN chown -R mysql:mysql /home/mysql/fuzzing/
USER mysql
COPY afl-fuzz /home/mysql/fuzzing/afl-fuzz
COPY init_lib/ /home/mysql/fuzzing/fuzz_root/init_lib/
COPY input/ /home/mysql/fuzzing/fuzz_root/crashes/
COPY init_lib/ /home/mysql/fuzzing/fuzz_root/mysql_initlib/
COPY global_data_lib_mysql /home/mysql/fuzzing/fuzz_root/
COPY safe_generate_type_mysql /home/mysql/fuzzing/fuzz_root/
COPY run_parallel.py /home/mysql/fuzzing/fuzz_root/run_parallel.py
COPY afl_config.py /home/mysql/fuzzing/fuzz_root/afl_config.py 
COPY mysql_rebooter.py /home/mysql/fuzzing/fuzz_root/mysql_rebooter.py

USER mysql
ENV LC_ALL="en_US.UTF-8"
WORKDIR /home/mysql/fuzzing/fuzz_root

USER root
ENTRYPOINT bash

#ENTRYPOINT python run.py
#ENTRYPOINT ../afl-fuzz -t 2000 -m 2000 -i ./crashes -o ../output /usr/local/pgsql/bin/postgres --single -D /usr/local/pgsql/data main 
