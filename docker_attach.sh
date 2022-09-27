#!/bin/bash
CONTAINER_LABEL=ros_$1

CONTAINER_EXIST=0

if [ -z $(docker container ls --format="{{.Names}}" | grep $CONTAINER_LABEL) ]; then
    ./docker_run_detached.sh $1
fi

docker start $CONTAINER_LABEL
docker exec -it $CONTAINER_LABEL "/bin/bash"