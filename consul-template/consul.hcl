log_level = "debug"
pid_file = "/app/consul-template/pid"

template {
  source = "/app/consul-template/nginx.ctmpl"
  destination = "/etc/nginx/conf.d/default.conf"
  command = "/app/nginx-reload.sh || true"
}

template {
  source = "/app/consul-template/letsencrypt_data.ctmpl"
  destination = "/app/letsencrypt/letsencrypt_data"
  command = "/app/letsencrypt/letsencrypt.sh || true"
}