#!/bin/bash
CONTAINER_LABEL=ros_$1

docker exec -it $CONTAINER_LABEL "/bin/bash"