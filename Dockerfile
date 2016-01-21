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

# Install consul-template
RUN wget -qO- https://releases.hashicorp.com/consul-template/0.12.2/consul-template_0.12.2_linux_amd64.zip | gunzip > /usr/local/bin/consul-template
RUN chmod +x /usr/local/bin/consul-template

COPY ./letsencrypt/install_simp_le.sh /app/letsencrypt/
RUN chmod +rx /app/letsencrypt/install_simp_le.sh && sync && /app/letsencrypt/install_simp_le.sh && rm -f /app/letsencrypt/install_simp_le.sh

COPY Procfile init.sh nginx-reload.sh /app/
COPY ./consul-template/ /app/consul-template/
COPY ./letsencrypt/ /app/letsencrypt/
RUN chmod +x /app/*.sh
RUN chmod +x /app/letsencrypt/letsencrypt.sh

ENV CONFIG_PREFIX=/app
ENV HOSTING_DOMAIN cloud
ENV HOSTING_PASSWORD 'finch:$apr1$iahxouEq$iXcpso4HhXGzuE9lusgKH/'

WORKDIR /app/
ENTRYPOINT ["/app/init.sh"]
CMD ["forego", "start", "-r"]
