template: consul-template -consul ${NGINX_CONSUL_1_PORT_8500_TCP_ADDR}:${NGINX_CONSUL_1_PORT_8500_TCP_PORT}  -template "/app/consul-template/nginx.ctmpl:/etc/nginx/conf.d/default.conf:/app/nginx-reload.sh || true"
nginx: nginx
