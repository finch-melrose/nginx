#!/bin/bash
set -e

./build.sh
cd dev/finchcloud-nginx-dev-service && ./build.sh && cd -
