#!/bin/sh

echo "Starting Nginx"
/usr/local/openresty/bin/openresty

echo "Sleep a bit"
sleep 5

echo "Loading data"
java -jar /loader.jar

echo "Done"
sleep infinity
