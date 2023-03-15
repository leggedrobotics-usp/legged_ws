#!/bin/bash
if [ -z $2 ]; then
    USER_NAME=catkin
    CONTAINER_LABEL=ros_$1
else
    USER_NAME=$2
    CONTAINER_LABEL="ros_$1-$2"
fi

docker exec -it $CONTAINER_LABEL ${@:2}