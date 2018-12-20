#!/bin/bash
# Program:
# Caffe environment starting script.
#

# ------------------------ Variables. ----------------------------------
REPO_NAME=niuchenxiao
CONTAINER_NAME=dl-dev
VERSION=latest
HOSTNAME=deep-learning-docker

echo "Repo name is: ${REPO_NAME}."
echo "Container name is: ${CONTAINER_NAME}"


# ---------------------- Starting into image ---------------------------
# Check wether container exists, then clean
echo "Start into docker image: ${REPO_NAME}/${CONTAINER_NAME}:${VERSION}"

if ! docker container list | grep ${CONTAINER_NAME};then
    echo "No such container named ${CONTAINER_NAME}, starting."
else
    # docker container stop ${CONTAINER_NAME}
    docker rm -fv ${CONTAINER_NAME}
fi
echo "Pulling image from docker hub, please check your internet connection."
docker pull ${REPO_NAME}/${CONTAINER_NAME}:${VERSION}

# Run docker as detached
nvidia-docker run --rm \
    -itd \
    -h ${HOSTNAME} \
    --name=${CONTAINER_NAME} \
    -e DISPLAY=${DISPLAY} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/Downloads:/home/dl/Downloads \
    -v Configs:/home/dl \
    -v Codes:/home/dl/Codes \
    -p 6006:6006 \
    ${REPO_NAME}/${CONTAINER_NAME}:${VERSION} \
    "/bin/zsh"
