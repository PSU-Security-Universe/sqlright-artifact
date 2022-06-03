#!/bin/bash -e
cd "$(dirname "$0")"/../bisecting

## For debug purpose, keep all intermediate steps to fast reproduce the run results.
sudo docker build --rm=false -f ./Dockerfile -t sqlright_mysql_bisecting .  

## Release code. Remove all intermediate steps to save hard drive space.
#sudo docker build --rm=true -f ./Dockerfile -t sqlright_mysql .



