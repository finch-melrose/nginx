#!/bin/bash
set -e

echo ${HOSTING_PASSWORD} > /etc/nginx/pass

consul-template -once -consul ${NGINX_CONSUL_1_PORT_8500_TCP_ADDR}:${NGINX_CONSUL_1_PORT_8500_TCP_PORT} -config /app/consul-template/consul.hcl


l=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$l: $line"
    l=$((l+1))
done < "/etc/nginx/conf.d/default.conf"


exec "$@"
