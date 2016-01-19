FROM nginx:1.9.9
MAINTAINER Khayretdinov Dmitriy dh@finch-melrose.com

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

# Install confd
RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /app/confd/conf.d
RUN mkdir -p /app/confd-env/conf.d

COPY Procfile confd.sh init.sh /app/
COPY ./confd-env/ /app/confd-env/
RUN chmod +x /app/*.sh

ENV CONFIG_PREFIX=/app

WORKDIR /app/
ENTRYPOINT ["/app/init.sh"]
CMD ["forego", "start", "-r"]