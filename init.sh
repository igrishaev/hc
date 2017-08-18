#!/bin/sh

echo "Starting Nginx"
/usr/local/openresty/bin/openresty

echo "Sleep a bit"
sleep 5

echo "Done"
sleep infinity
