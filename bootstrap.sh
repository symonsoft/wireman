#!/bin/bash

set -e

cp /bootstrap/nginx.conf /etc/nginx/nginx.conf

for arg in "$@"
    do
        array=(${arg//:/ })
        host_addr="${array[0]}"
        host_port="${array[1]}"
        port="${array[2]}"

        stream=${arg//[:.]/_}
        config_line="stream {upstream $stream {server $host_addr:$host_port;} server {listen $port; proxy_pass $stream;}}"
        echo "$config_line" > /config_line
        sed -i '/mappings/r '/config_line /etc/nginx/nginx.conf
    done

nginx -g "daemon off;"
