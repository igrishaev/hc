
PROJECT := hc
TAG := latest

docker-build:
	docker build --no-cache -t $(PROJECT):$(TAG) .

docker-run:
	docker run -it --rm -p 8080:80 -v $(CURDIR):/hc --entrypoint /hc/start.sh $(PROJECT):$(TAG)
