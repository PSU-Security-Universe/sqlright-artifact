FROM ubuntu:20.04 AS fundamental
MAINTAINER "PSU-Security-Universe"

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN chmod 777 /tmp

RUN apt -y update
RUN apt -y upgrade
RUN apt -y install bison 
RUN apt -y install flex 
RUN apt -y install git 
RUN apt -y install make 
RUN apt -y install cmake 
RUN apt -y install build-essential 
RUN apt -y install gcc-multilib 
RUN apt -y install g++-multilib 
RUN apt -y install clang
RUN apt -y install xinetd 
RUN apt -y install libreadline-dev 
RUN apt -y install zlib1g-dev 
RUN apt -y install gdb 
RUN apt -y install vim 
RUN apt -y install tmux 
RUN apt -y install python3
RUN apt -y install python3-pip
RUN apt -y install libxml2-dev 
RUN apt -y install libxslt-dev 
RUN apt -y install libssl-dev 
RUN apt -y install libxml2-utils 
RUN apt -y install xsltproc
RUN apt install -y libpq-dev
RUN apt -y install screen
RUN apt -y install watch
RUN apt -y install unzip
RUN apt -y install wget
RUN apt -y install tcl

RUN apt -y install llvm
RUN apt -y install clang

RUN apt install -y g++-9
RUN apt install -y gcc-9

RUN useradd -ms /bin/bash sqlite
USER sqlite

RUN pip3 install libtmux

WORKDIR /home/sqlite

# Build AFL. 
RUN git clone https://github.com/google/AFL.git

WORKDIR /home/sqlite/AFL
RUN sed -i  's/#define MAP_SIZE_POW2       16/#define MAP_SIZE_POW2       18/' config.h
RUN make
WORKDIR /home/sqlite/AFL/llvm_mode
# ENV LLVM_CONFIG=llvm-config-6.0
RUN make

FROM fundamental AS sqlite3_build

# Build SQLite3
WORKDIR /home/sqlite
RUN git clone https://github.com/sqlite/sqlite.git
RUN cp -r sqlite sqlite_ori

## Build instrumented SQLite3
WORKDIR /home/sqlite/sqlite
RUN git checkout version-3.34.0
ENV CXX=/home/sqlite/AFL/afl-clang-fast++
ENV CC=/home/sqlite/AFL/afl-clang-fast
RUN ./configure --enable-debug --enable-fts5
RUN make -j$(nproc)

## Build uninstrumented SQLite3
WORKDIR /home/sqlite/sqlite_ori
RUN git checkout version-3.34.0
ENV CXX=g++-9
ENV CC=gcc-9
RUN ./configure --enable-debug --enable-fts5
RUN make -j$(nproc)

# Setup the SQLRight source code.
FROM sqlite3_build AS SQLRight_build

USER root
WORKDIR /home/sqlite/src
COPY src /home/sqlite/src
RUN chown -R sqlite:sqlite /home/sqlite/src

USER sqlite
WORKDIR /home/sqlite/src
RUN make -j$(nproc)

# Setup the no_ctx_valid configuration
FROM SQLRight_build AS no_ctx_valid_sqlite

USER sqlite
WORKDIR /home/sqlite
RUN mkdir -p Validaty_Components_Config

USER root
WORKDIR /home/sqlite/Validaty_Components_Config
COPY Validaty_Components_Config/No_Ctx_Valid /home/sqlite/Validaty_Components_Config/No_Ctx_Valid
RUN chown -R sqlite:sqlite /home/sqlite/Validaty_Components_Config

USER sqlite
WORKDIR /home/sqlite/Validaty_Components_Config/No_Ctx_Valid/src/parser/
RUN make
WORKDIR /home/sqlite/Validaty_Components_Config/No_Ctx_Valid/src/AFL/
RUN make

# Setup the no_db_par_ctx_valid configuration
FROM no_ctx_valid_sqlite AS no_db_par_ctx_valid_sqlite

USER root
WORKDIR /home/sqlite/Validaty_Components_Config
COPY Validaty_Components_Config/No_DB_Par_Ctx_Valid  /home/sqlite/Validaty_Components_Config/No_DB_Par_Ctx_Valid
RUN chown -R sqlite:sqlite /home/sqlite/Validaty_Components_Config/No_DB_Par_Ctx_Valid

USER sqlite
WORKDIR /home/sqlite/Validaty_Components_Config/No_DB_Par_Ctx_Valid/src/parser/
RUN make
WORKDIR /home/sqlite/Validaty_Components_Config/No_DB_Par_Ctx_Valid/src/AFL/
RUN make

# Setup the Squirrel_Oracle configuration
FROM no_db_par_ctx_valid_sqlite AS squirrel_oracle

USER root
WORKDIR /home/sqlite/Validaty_Components_Config
COPY Validaty_Components_Config/Squirrel_Oracle  /home/sqlite/Validaty_Components_Config/Squirrel_Oracle
RUN chown -R sqlite:sqlite /home/sqlite/Validaty_Components_Config/Squirrel_Oracle

USER sqlite
WORKDIR /home/sqlite/Validaty_Components_Config/Squirrel_Oracle/src/parser
RUN make
WORKDIR /home/sqlite/Validaty_Components_Config/Squirrel_Oracle/src/AFL/
RUN make

# Setup sqlancer for testing

FROM squirrel_oracle AS sqlancer_sqlite

USER root
RUN apt update
RUN apt -y install openjdk-11-jdk
RUN apt -y install maven

WORKDIR /home/sqlite
COPY sqlancer /home/sqlite/sqlancer
RUN chown -R sqlite:sqlite /home/sqlite/sqlancer

USER sqlite
WORKDIR /home/sqlite/sqlancer/sqlancer_cov_src/
RUN make
RUN cp ./afl-fuzz ../sqlancer_cov/afl-fuzz

WORKDIR /home/sqlite/sqlancer/sqlancer
RUN mvn package -DskipTests
WORKDIR /home/sqlite/sqlancer/sqlancer/target
RUN mkdir -p logs


# Setup the fuzzing context
FROM sqlancer_sqlite AS SQLite3_fuzzing
USER sqlite
WORKDIR /home/sqlite
RUN mkdir -p fuzzing

USER root
WORKDIR /home/sqlite/fuzzing
COPY fuzz_root /home/sqlite/fuzzing/fuzz_root
RUN chown -R sqlite:sqlite /home/sqlite/fuzzing/

USER sqlite
WORKDIR /home/sqlite/fuzzing
RUN mkdir -p Bug_Analysis

# Setup the SQLite bisecting environment
USER root
COPY bisecting /home/sqlite/bisecting
RUN chown -R sqlite:sqlite /home/sqlite/bisecting

# At last, setup the Docker helper scripts
USER root
WORKDIR /home/sqlite
COPY scripts /home/sqlite/scripts
RUN chown -R sqlite:sqlite /home/sqlite/scripts

# Entry workdir.
WORKDIR /home/sqlite/fuzzing/fuzz_root


