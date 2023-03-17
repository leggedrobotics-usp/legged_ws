#!/bin/bash

if [ -z $1 ]; then
    echo "Please, give me a ROS image name."
else
    DOCKER_FOLDER=docker/dockerfiles

    docker build -f $DOCKER_FOLDER/ros-$1.dockerfile -t leggedroboticsusp/legged-ws:ros-$1 .
fi