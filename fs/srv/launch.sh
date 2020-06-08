#!/bin/bash

# Start docker-gen
/usr/local/bin/docker-gen -watch -only-exposed -notify "nginx -s reload" /etc/nginx/nginx.tmpl /etc/nginx/conf.d/dynamic.conf &

# Start nginx
exec /usr/sbin/nginx -g "daemon off;"
