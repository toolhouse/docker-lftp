
DOCKER_IMAGE := "toolhouse/lftp"
COMMIT := $(strip $(shell git rev-parse --short HEAD))
VERSION := $(strip $(shell git describe --always --dirty))

.PHONY: docker-image docker-push
.DEFAULT_GOAL := help	

docker-image: ## Build a docker image
	docker build \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VERSION=$(VERSION) \
		--build-arg VCS_REF=$(COMMIT) \
		-t $(DOCKER_IMAGE):$(VERSION) .

docker-push: ## Push the docker image to DockerHub
	docker push $(DOCKER_IMAGE):$(VERSION)
