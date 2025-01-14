#!/bin/bash

# If you want to build all the packages in debug [NOT RECOMMENDED]
# colcon build --cmake-args -DCMAKE_BUILD_TYPE=Debug

# If you want to build all the packages in release [RECOMMENDED]
# colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

# Build all the workspace
# bash /catkin_ws/src/install_spot_ros2.sh
bash /opt/ros/humble/setup.sh
colcon build --symlink-install --packages-ignore proto2ros proto2ros_tests
