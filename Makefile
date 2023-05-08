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

all: setup install lint test
