#!/bin/bash
set -e

echo  -backend etcd -node ${NGINX_ETCD_1_PORT_4001_TCP_ADDR}:${NGINX_ETCD_1_PORT_4001_TCP_PORT}