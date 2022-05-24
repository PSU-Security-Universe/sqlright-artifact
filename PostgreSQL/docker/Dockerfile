FROM ubuntu:16.04
MAINTAINER "dobigthing"

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install bison 
RUN apt-get -y install flex 
RUN apt-get -y install git 
RUN apt-get -y install make 
RUN apt-get -y install cmake 
RUN apt-get -y install build-essential 
RUN apt-get -y install gcc-multilib 
RUN apt-get -y install g++-multilib 
RUN apt-get -y install clang
RUN apt-get -y install xinetd 
RUN apt-get -y install libreadline-dev 
RUN apt-get -y install zlib1g-dev 
RUN apt-get -y install gdb 
RUN apt-get -y install vim 
RUN apt-get -y install tmux 
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get -y install libxml2-dev 
RUN apt-get -y install libxslt-dev 
RUN apt-get -y install libssl-dev 
RUN apt-get -y install libxml2-utils 
RUN apt-get -y install xsltproc
RUN apt-get install -y libpq-dev

RUN useradd -ms /bin/bash postgres
USER postgres
RUN pip install libtmux

WORKDIR /home/postgres

# Build AFL. 
RUN git clone https://github.com/google/AFL.git

WORKDIR /home/postgres/AFL
RUN sed -i  's/#define MAP_SIZE_POW2       16/#define MAP_SIZE_POW2       18/' config.h
RUN make
WORKDIR /home/postgres/AFL/llvm_mode
ENV LLVM_CONFIG=llvm-config-6.0
RUN make

# Build Postgres REL_14_0

WORKDIR /home/postgres
RUN git clone https://github.com/postgres/postgres.git

WORKDIR /home/postgres/postgres/ 
RUN git checkout REL_14_0
RUN mkdir /home/postgres/postgres/bld

USER postgres
WORKDIR /home/postgres/postgres/bld
ENV CXX=/home/postgres/AFL/afl-clang-fast++
ENV CC=/home/postgres/AFL/afl-clang-fast
RUN ../configure --prefix=$(pwd) && make -j$(nproc) && make install

# Setup Postgres. 
RUN ./bin/initdb -D ./data
RUN ./bin/pg_ctl -D ./data start 
RUN ./bin/createdb x
RUN ./bin/pg_ctl -D ./data stop
RUN mkdir -p data_all
RUN mv data data_all/ori_data 

RUN mkdir /home/postgres/fuzzing/
RUN mkdir /home/postgres/fuzzing/fuzz_root
COPY afl-fuzz /home/postgres/fuzzing/afl-fuzz
COPY postgres_initlib /home/postgres/fuzzing/fuzz_root/postgres_initlib/
COPY safe_generate_type /home/postgres/fuzzing/fuzz_root/
COPY global_data_lib /home/postgres/fuzzing/fuzz_root/
COPY input /home/postgres/fuzzing/fuzz_root/crashes
COPY run_parallel.py /home/postgres/fuzzing/fuzz_root/

USER root
RUN chown -R postgres:postgres /home/postgres/fuzzing/

ENTRYPOINT bash
#ENTRYPOINT ../afl-fuzz -t 2000 -m 2000 -i ./crashes -o ../output /usr/local/pgsql/bin/postgres --single -D /usr/local/pgsql/data main 

