#!/bin/bash
set -e


consul-template -once -consul ${NGINX_CONSUL_1_PORT_8500_TCP_ADDR}:${NGINX_CONSUL_1_PORT_8500_TCP_PORT}  -template "/app/consul-template/nginx.ctmpl:/etc/nginx/conf.d/default.conf"


l=0
for j in `cat /etc/nginx/conf.d/default.conf`
do
    echo "$l: $j"
    l=$((l+1))
done

exec "$@"