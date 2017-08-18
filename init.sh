#!/bin/sh

echo "Starting Nginx"
/usr/local/openresty/bin/openresty

echo "Sleep a bit"
sleep 5

echo "Loading data"
timeout 300s java -jar /loader.jar

echo "Done"
sleep infinity
