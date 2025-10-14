#!/bin/bash

# If you want to build all the packages in debug [NOT RECOMMENDED]
# catkin config -DCMAKE_BUILD_TYPE=Debug

# If you want to build all the packages in release
#catkin config -DCMAKE_BUILD_TYPE=Release

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
catkin build legged_ros rtabmap_ros legged_navigation legged_elevation_mapping teb_local_planner
catkin build legged_high_level_controller 
# 4. AM Packages
catkin build am_navigation
# 5. Lidar packages
catkin build livox_ros_driver fast_lio livox_to_pointcloud2 yujin_yrl_package

# Build all the workspace for CAMERA NAVIGATION AND MAPPING
# catkin build ocs2_legged_robot_ros legged_controllers legged_unitree_description \
#  legged_gazebo legged_navigation legged_elevation_mapping realsense_gazebo_plugin grid_map_demos yujin_yrl_package