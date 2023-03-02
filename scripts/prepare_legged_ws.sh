#!/bin/bash

if [ -z $1 ]; then
    echo "Please, give me a ROS name. Check dockerfiles in docker folder."

else
    CONTAINER_HOME=docker/container/$1/home/$USER
    WS_SRC_FOLDER=$CONTAINER_HOME/catkin_ws/src
    SPLITED_ONE=($(echo $1 | tr "-" "\n"))

    echo "source /opt/ros/${SPLITED_ONE[0]}/setup.bash" >> $CONTAINER_HOME/.bashrc

    mkdir -p $WS_SRC_FOLDER

    echo "This may take a while... Downloading needed packages' repositories..."

    # Clone legged_control
    git clone -b master git@github.com:lomcin/legged_control.git $WS_SRC_FOLDER/legged_control
    # Clone OCS2
    git clone https://github.com/leggedrobotics/ocs2.git $WS_SRC_FOLDER/ocs2
    # Clone pinocchio
    git clone --recurse-submodules https://github.com/leggedrobotics/pinocchio.git $WS_SRC_FOLDER/pinocchio
    # Clone hpp-fcl
    git clone --recurse-submodules https://github.com/leggedrobotics/hpp-fcl.git $WS_SRC_FOLDER/hpp-fcl
    # Clone ocs2_robotic_assets
    git clone https://github.com/leggedrobotics/ocs2_robotic_assets.git $WS_SRC_FOLDER/ocs2_robotic_assets
    # Clone pronto
    git clone https://github.com/ori-drs/pronto.git $WS_SRC_FOLDER/pronto

    echo "Building $1 docker image..."

    ./docker_build.sh $1

fi
