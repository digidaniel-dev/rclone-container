IMAGE_NAME=digidanieldev/rclone-minimal
TAG=1.70.3
PLATFORMS=linux/amd64

build:
	docker buildx build --platform $(PLATFORMS) \
		-t $(IMAGE_NAME):$(TAG) \
		--push .

local:
	docker build -t $(IMAGE_NAME):local .

test:
	docker run --rm $(IMAGE_NAME):local
