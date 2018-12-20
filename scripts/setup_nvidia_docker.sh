#!/bin/bash
# Program:
# Caffe environment starting script.
#


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