#!/bin/bash

USER_NAME=catkin
CONTAINER_LABEL="ros_noetic-am"
CONTAINER_ALIAS="noetic-am"

# Container paths
CONTAINER_USER_HOME=/home/$USER
CONTAINER_WORKDIR=$CONTAINER_USER_HOME/catkin_ws
CONTAINER_SCRIPTS=$CONTAINER_WORKDIR/scripts

# Host paths
HOST_USER_HOME=$(pwd)/docker/container/$CONTAINER_ALIAS/home/$USER
HOST_WORKDIR=$HOST_USER_HOME/catkin_ws
HOST_SCRIPTS=$(pwd)/scripts

# Creating useful folders in host
mkdir -p $HOST_USER_HOME
mkdir -p $HOST_WORKDIR

# Automatically detect NVIDIA's GPU and try to use it
if [ -z "$(lspci | grep NVIDIA)" ]; then
    USE_GPUS=""
    echo "NVIDIA's GPU WAS NOT detected."
else
    USE_GPUS="--gpus all"
    echo "NVIDIA's GPU WAS detected. Activating '--gpus all' flag."
fi

KERNEL_VERSION=$(uname -r | cut -d '-' -f1)
if [[ "$(printf '%s\n' "4.6" "$KERNEL_VERSION" | sort -V | head -n1)" == "4.6" ]]; then
    OOM_FLAG="--oom-kill-disable"
else
    echo "Warning: Kernel < 4.6, skipping --oom-kill-disable"
    OOM_FLAG=""
fi


docker run -it --rm \
    $USE_GPUS \
    --user $(id -u):$(id -g) \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --network="host" \
    --ipc="host" \
    --privileged \
    $OOM_FLAG \
    --volume="$HOST_USER_HOME:$CONTAINER_USER_HOME:rw" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOST_WORKDIR:$CONTAINER_WORKDIR:rw" \
    --volume="$HOST_SCRIPTS:$CONTAINER_SCRIPTS:rw" \
    --name="$CONTAINER_LABEL" \
    --volume="/dev:/dev:rw" \
    --workdir="$CONTAINER_WORKDIR" \
    leggedroboticsusp/legged-ws:ros-$CONTAINER_ALIAS
