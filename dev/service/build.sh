#!/bin/bash
set -e
mvn install
docker build -t finchcloud/nginx-dev-service .
