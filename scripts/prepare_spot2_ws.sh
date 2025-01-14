#!/bin/bash

if [ -z $1 ]; then
    echo "Please, give me a ROS name. Check dockerfiles in docker folder."

else
    if [ -z $2 ]; then
        USER_NAME=catkin
        CONTAINER_ALIAS=$1
    else
        USER_NAME=$2
        CONTAINER_ALIAS=$1-$2
    fi

    CUR_DIR=$(pwd)
    CONTAINER_HOME=docker/container/$CONTAINER_ALIAS/home/$USER
    WS_SRC_FOLDER=$CONTAINER_HOME/scripts/scripts
    SPLITED_ONE=($(echo $1 | tr "-" "\n"))

    echo "CONTAINER_HOME: $CONTAINER_HOME"
    echo "WS_SRC_FOLDER: $WS_SRC_FOLDER"
    echo "CUR_DIR: $CUR_DIR"

    mkdir -p $WS_SRC_FOLDER

    echo "source /opt/ros/${SPLITED_ONE[0]}/setup.bash" >> $CONTAINER_HOME/.bashrc

    echo "This may take a while... Downloading needed packages' repositories..."

    # git clone
    # cd $WS_SRC_FOLDER

    # # Main spot repository
    # git clone https://github.com/bdaiinstitute/spot_ros2.git 
    # git submodule update --init --recursive

    # cd $CUR_DIR

    echo "Building $1 docker image..."

    ./docker/build.sh $1

fi