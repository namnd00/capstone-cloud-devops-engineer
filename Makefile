#!/bin/bash

SHELL:=/bin/bash

.PHONY: setup install lint all

setup:
	python3 -m venv venv
	. venv/bin/activate

install:
	pip install --upgrade pip && pip install -r requirements.txt && \
		wget -O ./hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && \
		chmod +x ./hadolint

lint:
	./hadolint Dockerfile
	pylint --disable=R,C,W1203,W1202 app.py

build:
	source ./.env && \
		docker build --tag=$(IMAGE_NAME) .

run: build
	source ./.env && \
		docker run -p 8000:80 $(IMAGE_NAME)

push: build
	source ./.env
	docker login -u="$(DOCKERHUB_USERNAME)" -p="$(DOCKERHUB_PASSWORD)"
	docker tag $(IMAGE_NAME) $(DOCKERHUB_USERNAME)/$(IMAGE_NAME)
	docker push $(DOCKERHUB_USERNAME)/$(IMAGE_NAME)

deploy:
	kubectl apply -f k8s/

all: setup install lint test
