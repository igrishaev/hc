
PROJECT := hc
REPO_HOST := stor.highloadcup.ru
REPO_PATH := travels/steep_catfish
TAG := 0.1

docker-build:
	docker build --no-cache -t $(PROJECT):$(TAG) .

docker-run:
	docker run \
	-it --rm \
	-p 8080:80 \
	-v $(CURDIR)/tmp/data:/tmp/data:ro \
	-v $(CURDIR)/init.sh:/init.sh \
	-v $(CURDIR)/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro \
	$(PROJECT):$(TAG)

docker-tag:
	docker tag $(PROJECT):$(TAG) $(REPO_HOST)/$(REPO_PATH)

docker-push:
	docker push $(REPO_HOST)/$(REPO_PATH)

deploy: docker-build docker-tag docker-push
