#!/bin/bash

killall ssdb-server

# variables
ssdb_server_bin="./build/ssdb-stable-1.9.5/ssdb-server"
ssdb_conf="./build/ssdb-stable-1.9.5/ssdb.conf"
ssdb_bench="./build/ssdb-stable-1.9.5/tools/ssdb-bench"

# start servere

#FIXME: check bin path

taskset -c 0-$1 $ssdb_server_bin -d $ssdb_conf
sleep 1

# benchmark
taskset -c 0-$1 $ssdb_bench 127.0.0.1 8888 100000 $1

sleep 10

#clean logs
rm -rf ./build/ssdb-stable-1.9.5/log.txt*

# stop server
killall ssdb-server
sleep 3

#clean ssdb old pid
rm -rf ./build/ssdb-stable-1.9.5/var/ssdb.pid
