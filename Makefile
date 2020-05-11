DOCKER_IMAGE := base
BASE_SERVICE := default
JUPYTER_LAB_SERVICE := jupyter-lab
DOCKER_WORKSPACE := /app

.PHONY: help

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v frgrep | sed -e 's/\\$$//' | sed -e 's/##//'

image:		## Build base image
	@docker build -f docker/images/base/Dockerfile -t base .

jupyter-lab:	## Run jupyter lab service
	@docker-compose up --remove-orphans $(JUPYTER_LAB_SERVICE)
