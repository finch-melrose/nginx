#!/bin/bash
set -e


consul-template -once -consul ${NGINX_CONSUL_1_PORT_8500_TCP_ADDR}:${NGINX_CONSUL_1_PORT_8500_TCP_PORT}  -template "/app/consul-template/nginx.ctmpl:/etc/nginx/conf.d/default.conf:nginx restart || true"

exec "$@"