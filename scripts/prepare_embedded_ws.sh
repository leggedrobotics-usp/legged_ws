#!/bin/bash

if [ -z $1 ]; then
    echo "Please, give me a valid board name. Check dockerfiles in docker folder."

else
    if [ -z $2 ]; then
        USER_NAME=embedded
        CONTAINER_ALIAS=$1
    else
        USER_NAME=$2
        CONTAINER_ALIAS=$1-$2
    fi

    CONTAINER_HOME=docker/container/$CONTAINER_ALIAS/home/$USER
    WS_SRC_FOLDER=$CONTAINER_HOME

    mkdir -p $WS_SRC_FOLDER

    echo "This may take a while... Downloading needed packages' repositories..."

    # Clone Forecast Nucleo Framework
    git clone --recurse-submodules git@github.com:qleonardolp/forecast-nucleo.git $WS_SRC_FOLDER/forecast-nucleo

    echo "Building $1 docker image..."

    ./docker/build_embedded.sh $1

fi
