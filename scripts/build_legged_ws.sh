#!/bin/bash

# If you want to build all the packages in debug [NOT RECOMMENDED]
# catkin config -DCMAKE_BUILD_TYPE=Debug

# If you want to build all the packages in release
# catkin config -DCMAKE_BUILD_TYPE=Release

# If you want to build all the packages in release with debug info [RECOMMENDED]
catkin config -DCMAKE_BUILD_TYPE=RelWithDebInfo

# Build all the workspace
catkin build ocs2_legged_robot_ros legged_controllers legged_unitree_description legged_gazebo legged_navigation legged_elevation_mapping b2_description b2_interface_mgs legged_b2_hw b2_highlevel_controller b2_state_estimation inekf_msgs inekf_ros

# Build all the workspace for CAMERA NAVIGATION AND MAPPING
# catkin build ocs2_legged_robot_ros legged_controllers legged_unitree_description legged_gazebo legged_navigation legged_elevation_mapping realsense_gazebo_plugin grid_map_demos
