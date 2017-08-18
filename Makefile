
PROJECT := hc
REPO_HOST := stor.highloadcup.ru
REPO_PATH := travels/steep_catfish
TAG := cache

docker-build:
	docker build --no-cache -t $(PROJECT):$(TAG) .

docker-run:
	docker run \
	-it --rm \
	-p 80:80 \
	-v $(CURDIR)/tmp/data:/tmp/data:ro \
	-v $(CURDIR)/init.sh:/init.sh \
	-v $(CURDIR)/loader.py:/loader.py \
	-v $(CURDIR)/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro \
	$(PROJECT):$(TAG)

docker-tag:
	docker tag $(PROJECT):$(TAG) $(REPO_HOST)/$(REPO_PATH)

docker-push:
	docker push $(REPO_HOST)/$(REPO_PATH)

loader-build:
	make -C loader uberjar

loader-run:
	make -C loader uberjar-run


deploy: docker-build docker-tag docker-push
