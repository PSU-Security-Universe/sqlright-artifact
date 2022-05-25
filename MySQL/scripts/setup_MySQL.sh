#!/bin/bash -e
cd "$(dirname "$0")"/../docker

sudo docker build -f ./Dockerfile -t sqlright_mysql .


