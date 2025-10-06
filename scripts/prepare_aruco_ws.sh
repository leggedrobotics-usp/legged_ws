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

    CONTAINER_HOME=$(pwd)/docker/container/$CONTAINER_ALIAS/home/$USER
    WS_SRC_FOLDER=$CONTAINER_HOME/catkin_ws/src
    SPLITED_ONE=($(echo $1 | tr "-" "\n"))

    mkdir -p $WS_SRC_FOLDER

    echo "source /opt/ros/${SPLITED_ONE[0]}/setup.bash" >> $CONTAINER_HOME/.bashrc

    echo "This may take a while... Downloading needed packages' repositories..."

    git clone -b main https://github.com/leggedrobotics-usp/aruco_ros_noetic $WS_SRC_FOLDER/aruco_ros_noetic

    echo "Building $1 docker image..."

    ./docker/build.sh $1

fi