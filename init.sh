#!/bin/sh

echo "Starting Nginx"
nginx -c /nginx.conf

echo "Sleep a bit"
sleep 5

echo "Load data"
python /loader.py

echo "Done"
sleep infinity
