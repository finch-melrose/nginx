#!/bin/bash
set -e
mvn install
docker build -t finch-melrose/nginx-dev-service .
