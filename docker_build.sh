#!/bin/bash

DOCKER_FOLDER=docker/dockerfiles

docker build -f $DOCKER_FOLDER/ros-$1.dockerfile -t ros-$1 .
