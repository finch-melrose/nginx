#!/bin/bash
set -e

./build.sh
cd dev/service && ./build.sh && cd -
