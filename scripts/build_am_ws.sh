#!/bin/bash

WS_FOLDER=$(pwd)

# If you want to build all the packages in release with debug info [RECOMMENDED]
catkin config -DCMAKE_BUILD_TYPE=RelWithDebInfo

# Build the AM workspace
# 1. Control packages (the order matters)
catkin build legged_controllers legged_unitree_description
catkin build legged_gazebo
catkin build legged_unitree_hw
# 2. Compile OCS2 linked to legged control
catkin build ocs2_legged_robot_ros 
# 3. Mapping, simulation and planning
catkin build -j4 legged_ros rtabmap_ros legged_navigation legged_elevation_mapping teb_local_planner
catkin build legged_high_level_controller 
# 4. AM Packages
catkin build am_navigation
# 5. Lidar packages
catkin build yujin_yrl_package
# Unitree 4D
cd $WS_FOLDER/src/unitree_lidar_sdk
mkdir build
cd build
cmake ..
make -j2
cd $WS_FOLDER
catkin build unitree_lidar_ros
catkin build point_lio_unilidar
# Robosense
catkin build rslidar_sdk
# 6. Fiducial detect ROS
catkin build fiducial_detect_ros

# ========= LIVOX PACKAGES
# catkin build livox_ros_driver fast_lio livox_to_pointcloud2