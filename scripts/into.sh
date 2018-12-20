#!/bin/bash
# Program:
# Caffe environment starting script.
#

REPO_NAME=niuchenxiao
CONTAINER_NAME=dl-dev
VERSION=latest
echo "Diving into docker container: ${CONTAINER_NAME}."
docker exec -it \
    dl-dev \
    zsh