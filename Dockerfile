FROM nginx:1.9.9
MAINTAINER Khayretdinov Dmitriy dh@finch-melrose.com

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget curl \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;error_log stderr;" >> /etc/nginx/nginx.conf \
 && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

# Install confd
RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /app/confd/conf.d
RUN mkdir -p /app/confd-env/conf.d

# Install consul-template
RUN wget -qO- https://releases.hashicorp.com/consul-template/0.12.2/consul-template_0.12.2_linux_amd64.zip | gunzip > /usr/local/bin/consul-template
RUN chmod +x /usr/local/bin/consul-template

COPY Procfile confd.sh init.sh /app/
COPY ./confd/ /app/confd/
COPY ./confd-env/ /app/confd-env/
COPY ./consul-template/ /app/consul-template/
RUN chmod +x /app/*.sh

ENV CONFIG_PREFIX=/app

WORKDIR /app/
ENTRYPOINT ["/app/init.sh"]
CMD ["forego", "start"]
#consul-template \
    #  -consul ${NGINX_CONSUL_1_PORT_8500_TCP_ADDR}:${NGINX_CONSUL_1_PORT_8500_TCP_PORT} \
    #  -template "/app/consul-template/nginx.ctmpl:/etc/nginx/conf.d/default.conf:service nginx restart || true"
#["forego", "start", "-r"]