#!/bin/bash
set -e

./build.sh
docker build -t finch-melrose/nginx-dev-etcd ./dev/etcd
cd dev/service && ./build.sh && cd -
