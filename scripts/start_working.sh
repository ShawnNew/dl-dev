#!/bin/bash
# Program:
# Caffe environment starting script.
#

# ------------------------ Variables. ----------------------------
REPO_NAME=niuchenxiao
CONTAINER_NAME=dl-dev
VERSION=test

echo "Repo name is: ${REPO_NAME}."
echo "Container name is: ${CONTAINER_NAME}"


# ---------------------- Starting into image -----------------------
echo "Start into docker image: ${REPO_NAME}/${CONTAINER_NAME}:${VERSION}"

if ! docker ps -a | grep ${CONTAINER_NAME};then
    echo "No such container named ${CONTAINER_NAME}", starting."
else
    docker rm ${CONTAINER_NAME}
fi

docker run -it \
    --net="host" \
    --name=${CONTAINER_NAME} \
    -e DISPLAY=${DISPLAY} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    ${REPO_NAME}/${CONTAINER_NAME}:${VERSION}