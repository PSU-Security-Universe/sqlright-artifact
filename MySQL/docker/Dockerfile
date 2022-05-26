FROM ubuntu:20.04
MAINTAINER "PSU-Security-Universe"

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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
RUN apt -y install unzip
RUN pip install libtmux
RUN apt -y install wget

RUN apt -y install llvm
RUN apt -y install clang

USER root
RUN apt -y install g++-9
RUN apt -y install gcc-9

RUN apt -y install libnuma-dev

RUN useradd -ms /bin/bash mysql

ENV CC=clang
ENV CXX=clang++

# build block-coverage AFL
WORKDIR /home/mysql
COPY AFL /home/mysql/AFL
WORKDIR /home/mysql/AFL 
RUN make
WORKDIR /home/mysql/AFL/llvm_mode
# ENV LLVM_CONFIG=llvm-config-6.0
RUN make 

# build MySQL instrumented by afl-clang-fast
USER mysql
WORKDIR /home/mysql/
RUN wget https://github.com/mysql/mysql-server/archive/refs/tags/mysql-8.0.27.zip
RUN unzip mysql-8.0.27.zip
RUN mv mysql-server-mysql-8.0.27 mysql-server
WORKDIR /home/mysql/mysql-server
# MySQL version 8.0.27
# RUN git checkout 3290a66c89eb1625a7058e0ef732432b6952b435 
RUN mkdir bld
WORKDIR /home/mysql/mysql-server/bld
ENV CC=/home/mysql/AFL/afl-clang-fast
ENV CXX=/home/mysql/AFL/afl-clang-fast++
RUN cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost -DWITH_DEBUG=1
RUN make -j$(nproc)

# set up MySQL
USER root
RUN mkdir data
RUN bin/mysqld --initialize-insecure --user=mysql --datadir=data
RUN bin/mysql_ssl_rsa_setup --datadir=data
RUN mkdir data_all
RUN mv data data_all/ori_data


# Install mysql-client related libraries, for the compilation of sqlright.
USER root
ENV CC=gcc-9
ENV CXX=g++-9
RUN pip3 install psutil
RUN pip3 install mysql-connector-python mysql-connector-python
RUN apt -y install libmysqlclient-dev
RUN pip3 install mysqlclient

# Install SQLRight MySQL
COPY src /home/mysql/src
WORKDIR /home/mysql/src/parser
RUN cp /home/mysql/mysql-8.0.27.zip ./ && unzip mysql-8.0.27.zip && mv mysql-server-mysql-8.0.27 mysql-server

# Add SQLRight modification to the MySQL source code.
WORKDIR /home/mysql/src/parser/patches
RUN bash ./replace-changed-code.sh

# Compile the build-in MySQL source code.
WORKDIR /home/mysql/src/parser/mysql-server
RUN mkdir bld
WORKDIR /home/mysql/src/parser/mysql-server/bld
RUN cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost
RUN make -j$(nproc) # The make could only be single threaded. Seems to be some racing condition in the compilation process.

WORKDIR /home/mysql/src
RUN make

USER mysql
ENV LC_ALL="en_US.UTF-8"
WORKDIR /home/mysql/fuzzing/fuzz_root

# set up fuzzing
USER root
RUN mkdir -p /home/mysql/fuzzing/fuzz_root
RUN chown -R mysql:mysql /home/mysql/fuzzing/
USER mysql
#COPY afl-fuzz /home/mysql/fuzzing/afl-fuzz/fuzz_root
COPY init_lib /home/mysql/fuzzing/fuzz_root/init_lib
COPY input /home/mysql/fuzzing/fuzz_root/input
COPY init_lib /home/mysql/fuzzing/fuzz_root/mysql_initlib
COPY global_data_lib_mysql /home/mysql/fuzzing/fuzz_root/
COPY safe_generate_type_mysql /home/mysql/fuzzing/fuzz_root/
COPY run_parallel.py /home/mysql/fuzzing/fuzz_root/run_parallel.py
COPY afl_config.py /home/mysql/fuzzing/fuzz_root/afl_config.py 
COPY mysql_rebooter.py /home/mysql/fuzzing/fuzz_root/mysql_rebooter.py

RUN cp /home/mysql/src/afl-fuzz /home/mysql/fuzzing/fuzz_root/afl-fuzz

USER root
WORKDIR /home/mysql/fuzzing/fuzz_root
ENTRYPOINT bash

#ENTRYPOINT python run.py
#ENTRYPOINT ../afl-fuzz -t 2000 -m 2000 -i ./crashes -o ../output /usr/local/pgsql/bin/postgres --single -D /usr/local/pgsql/data main 
