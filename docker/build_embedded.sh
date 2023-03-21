#!/bin/bash

if [ -z $1 ]; then
    echo "Please, give me a board image name."
else
    DOCKER_FOLDER=docker/dockerfiles

    if [ -e $DOCKER_FOLDER/emb-$1.dockerfile ]; then
        docker build --build-arg USER=$USER -f $DOCKER_FOLDER/emb-$1.dockerfile -t leggedroboticsusp/legged-ws:emb-$1 .
    else
        echo "Please, give me a VALID board image name."
        echo "The available images are: "
        ls $DOCKER_FOLDER -w 1 | sed 's/\(^emb\)\-\([a-z A-Z 0-9\-]*\)\.\([a-z]*\)/\ \ \2/'
    fi
fi