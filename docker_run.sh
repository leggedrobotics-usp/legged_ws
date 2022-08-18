#!/bin/bash
CONTAINER_LABEL=ros_$1

HOST_WORKDIR=$(pwd)/catkin_ws
CONTAINER_WORKDIR=/home/$USER/catkin_ws
echo $WORKDIR
USER_HOME_PATH=$(pwd)/container/$1/home/$USER
mkdir -p $USER_HOME_PATH

docker run -it --rm \
    --user $(id -u):$(id -g) \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --network="host" \
    --ipc="host" \
    --privileged \
    --oom-kill-disable \
    --volume="/etc/group:/etc/group:ro" \
    --volume="$USER_HOME_PATH:/home/$USER:rw" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$HOST_WORKDIR:$CONTAINER_WORKDIR:rw" \
    --name="$CONTAINER_LABEL" \
    --volume="/dev:/dev:rw" \
    --workdir="$CONTAINER_WORKDIR" \
    ros-$1
    # --volume="/dev/shm:/dev/shm:rw" \