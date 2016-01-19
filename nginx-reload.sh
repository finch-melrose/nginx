#!/bin/bash
set -e

l=0
for j in `cat /etc/nginx/conf.d/default.conf`
do
    echo "$l: $j"
    l=$((l+1))
done

nginx -t -c /etc/nginx/nginx.conf
nginx -s reload