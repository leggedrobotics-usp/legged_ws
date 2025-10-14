#!/bin/bash

CONTAINER_LABEL="ros_noetic-am"
CONTAINER_EXIST=0

if [ -z $(docker container ls -a --format="{{.Names}}" --filter name=^$CONTAINER_LABEL$) ]; then
    ./docker/run_detached.sh noetic-am
fi

docker start $CONTAINER_LABEL
docker exec -it $CONTAINER_LABEL "/bin/bash"