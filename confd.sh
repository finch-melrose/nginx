#!/bin/bash
set -e

ETCD=http://${NGINX_ETCD_1_PORT_4001_TCP_ADDR}:${NGINX_ETCD_1_PORT_4001_TCP_PORT}

etcd() {
    curl -s ${ETCD}/v2/keys/$@
}

etcd subdomain -XPUT -d value="this is awesome" | true

ls /app/confd/conf.d/

confd -confdir /app/confd -backend consul -node ${NGINX_CONSUL_1_PORT_8500_TCP_ADDR}:${NGINX_CONSUL_1_PORT_8500_TCP_PORT}
