#!/bin/bash
# Program:
# Caffe environment starting script.
#

# ------------------------ Variables. ----------------------------
REPO_NAME=niuchenxiao
CONTAINER_NAME=dl-dev
VERSION=latest

echo "Repo name is: ${REPO_NAME}."
echo "Container name is: ${CONTAINER_NAME}"

# ----------------------- Nvidia docker ---------------------------
if ! nvidia-docker --version ; then
    echo "You don't have nvidia-docker running on your system, then install."
    # If you have nvidia-docker 1.0 installed: 
    # we need to remove it and all existing GPU containers
    docker volume ls -q -f driver=nvidia-docker | \
        xargs -r -I{} -n1 docker ps -q -a -f volume={} | \
        xargs -r docker rm -f
    sudo apt-get purge -y nvidia-docker

    # Add the package repositories
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
    sudo apt-key add -
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L \
    https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update

    # Install nvidia-docker2 and reload the Docker daemon configuration
    sudo apt-get install -y nvidia-docker2
    sudo pkill -SIGHUP dockerd
else
    echo "We got nvidia-docker on the system, start."
fi

# ---------------------- Starting into image -----------------------
echo "Start into docker image: ${REPO_NAME}/${CONTAINER_NAME}:${VERSION}"

if ! docker ps -a | grep ${CONTAINER_NAME};then
    echo "No such container named ${CONTAINER_NAME}, starting."
else
    docker rm ${CONTAINER_NAME}
fi

nvidia-docker run -it \
    --net="host" \
    --name=${CONTAINER_NAME} \
    -e DISPLAY=${DISPLAY} \
    -e MYUID=$(id -u) \
    -e MYGID=$(id -g) \
    -e MYUSERNAME=$(id -un) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:$HOME \
    -w $HOME \
    ${REPO_NAME}/${CONTAINER_NAME}:${VERSION}