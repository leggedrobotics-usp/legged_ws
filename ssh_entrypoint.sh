#!/bin/bash

# systemctl ssh start && systemctl ssh enable
# /usr/sbin/sshd -D
source /opt/ros/noetic/setup.bash
v11vnc -create -forever
service ssh start && while true; do sleep 3000; done