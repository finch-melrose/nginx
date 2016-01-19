#!/bin/bash
set -e


confd -onetime -backend env -confdir /app/confd-env

exec "$@"