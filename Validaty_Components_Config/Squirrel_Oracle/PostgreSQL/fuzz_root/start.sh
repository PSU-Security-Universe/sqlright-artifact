#!/bin/bash
set -e 

cd /data/liusong/Squirrel_DBMS/PostgreSQL
make -j$(nproc)
cd fuzz_root
./afl-fuzz -t 2000 -m 2000 -i ./inputs  -o ./outputs aaa 
