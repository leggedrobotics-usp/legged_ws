#!/bin/bash

# If you want to build all the packages in debug [NOT RECOMMENDED]
# catkin config -DCMAKE_BUILD_TYPE=Debug

# If you want to build all the packages in release
# catkin config -DCMAKE_BUILD_TYPE=Release

# If you want to build all the packages in release with debug info [RECOMMENDED]
catkin config -DCMAKE_BUILD_TYPE=RelWithDebInfo

# Build all the workspace
catkin build ocs2_legged_robot_ros legged_controllers legged_unitree_description legged_gazebo legged_navigation legged_elevation_mapping mujoco_ros

# Build all the workspace for CAMERA NAVIGATION AND MAPPING
# catkin build ocs2_legged_robot_ros legged_controllers legged_unitree_description legged_gazebo legged_navigation legged_elevation_mapping mujoco_ros realsense_gazebo_plugin grid_map_demos