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

    CONTAINER_HOME=docker/container/$CONTAINER_ALIAS/home/$USER
    WS_SRC_FOLDER=$CONTAINER_HOME/catkin_ws/src
    SPLITED_ONE=($(echo $1 | tr "-" "\n"))

    echo "source /opt/ros/${SPLITED_ONE[0]}/setup.bash" >> $CONTAINER_HOME/.bashrc

    mkdir -p $WS_SRC_FOLDER

    echo "This may take a while... Downloading needed packages' repositories..."

    # Clone RealSense ROS
    git clone -b ros1-legacy https://github.com/IntelRealSense/realsense-ros.git $WS_SRC_FOLDER/realsense-ros

    echo "Setting up dialout permissions for this USER:$USER..."
    sudo usermod -a -G dialout $USER

    echo "Building $1 docker image..."

    # ./docker/build.sh $1

fi
