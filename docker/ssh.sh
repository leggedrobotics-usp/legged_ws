#!/bin/bash
if [ -z $1 ]; then
    echo "Please, give me a CONTAINER name."
else
    if [ -z $2 ]; then
        USER_NAME=catkin
        CONTAINER_LABEL=ros_$1
        CONTAINER_ALIAS=$1
    else
        USER_NAME=$2
        CONTAINER_LABEL="ros_$1-$2"
        CONTAINER_ALIAS="$1-$2"
    fi
    
    CONTAINER_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $CONTAINER_LABEL)
    echo "The container IP is $CONTAINER_IP"
    ssh -YAX legro@$CONTAINER_IP
fi