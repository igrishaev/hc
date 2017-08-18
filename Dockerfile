FROM openresty/openresty:trusty

ENV ZIP_PATH "/tmp/data/data.zip"
ENV BASE_URL "http://127.0.0.1"

EXPOSE 80

RUN apt-get install software-properties-common python-software-properties -y
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install openjdk-8-jre -y

RUN /usr/local/openresty/luajit/bin/luarocks install lsqlite3complete

WORKDIR /

COPY init.sh .
COPY loader/target/uberjar/loader.jar .
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

RUN ulimit -n 16000

ENTRYPOINT /init.sh
