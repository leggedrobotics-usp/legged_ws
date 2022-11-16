#!/bin/bash

if [ -z "${WORKDIR}" ]; then
  WORKDIR="/home/${USER}"
fi

# cd $WORKDIR/ros/legged_ws/docker/container/melodic-legged/home/glahr/catkin_ws/
# source devel/setup.bash

roslaunch go1_gazebo go1_wbc.launch
