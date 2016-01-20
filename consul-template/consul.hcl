log_level = "debug"
pid_file = "/app/consul-template/pid"

template {
  source = "/app/consul-template/nginx.ctmpl"
  destination = "/etc/nginx/conf.d/default.conf"
  command = "/app/nginx-reload.sh || true"
}
