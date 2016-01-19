FROM debian:jessie
MAINTAINER Khayretdinov Dmitriy dh@finch-melrose.com

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

RUN mkdir -p /app

# Install etcd
RUN wget -qO- https://github.com/coreos/etcd/releases/download/v2.2.4/etcd-v2.2.4-linux-amd64.tar.gz \
 | tar xz -C /app \
 && mv /app/etcd-*/ /app/etcd

WORKDIR /app/
ENTRYPOINT /app/etcd/etcd \
 --listen-client-urls 'http://0.0.0.0:2379,http://0.0.0.0:4001' \
 --advertise-client-urls "http://$(awk 'NR==1 {print $1}' /etc/hosts):2379,http://$(awk 'NR==1 {print $1}' /etc/hosts):4001"