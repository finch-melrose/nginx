#!/bin/bash
set -e

l=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$l: $line"
    l=$((l+1))
done < "/etc/nginx/conf.d/default.conf"

nginx -t -c /etc/nginx/nginx.conf
nginx -s reload