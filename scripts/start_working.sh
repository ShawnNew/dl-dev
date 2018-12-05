#!/bin/bash
# Program:
# Caffe environment starting script.
#

# TODO: kill container if exists.


# Start a container and run caffe-capable image
docker run --name="caffe-dev" -it niuchenxiao/caffe-dev:gpu "/usr/bin/zsh"
# TODO: Code display for debugging.