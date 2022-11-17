#!/bin/bash

if [ -z "${WORKDIR}" ]; then
  WORKDIR="/home/${USER}"
fi

export SINGULARITY_CACHEDIR=$WORKDIR

if [ -z "$1" ]; then
  image_name=melodic-legged
else
  image_name=$1
fi

# Container paths
CONTAINER_USER_HOME=/home/$USER
CONTAINER_WORKDIR=$CONTAINER_USER_HOME/catkin_ws
CONTAINER_SCRIPTS=$CONTAINER_WORKDIR/scripts

# Host paths
HOST_USER_HOME=$(pwd)/docker/container/$image_name/home/$USER
HOST_WORKDIR=$HOST_USER_HOME/catkin_ws
HOST_SCRIPTS=$(pwd)/scripts
HOST_SINGULARITY_SCRIPTS=$(pwd)/singularity/scripts

echo $(pwd)
# sleep 3
singularity instance start --nv --disable-cache -B $HOST_WORKDIR:$CONTAINER_WORKDIR,$HOST_USER_HOME:$CONTAINER_USER_HOME,/run/user/1001/,/var/lib/dbus/machine-id,/etc/machine-id $HOST_USER_HOME/images/melodic-legged.sif go1_wbc roslaunch go1_gazebo go1_wbc.launch enable_rviz:=false
sleep 3
singularity instance start --nv --disable-cache -B $HOST_WORKDIR:$CONTAINER_WORKDIR,$HOST_USER_HOME:$CONTAINER_USER_HOME,/run/user/1001/,/var/lib/dbus/machine-id,/etc/machine-id $HOST_USER_HOME/images/melodic-legged.sif rl roslaunch go1_rl go1_rl.launch
# sleep 1
