FROM openresty/openresty:trusty

ENV ZIP_PATH "/tmp/data/data.zip"
ENV BASE_URL "http://127.0.0.1"

EXPOSE 80

WORKDIR /

RUN sudo apt-get install python -y

RUN ulimit -n 200000

COPY init.sh .
COPY loader.py .
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

ENTRYPOINT /init.sh
