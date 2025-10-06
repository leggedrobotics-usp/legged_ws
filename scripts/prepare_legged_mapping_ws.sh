#!/bin/bash

if [ -z $1 ]; then
    echo "Please, give me a ROS name. Check dockerfiles in docker folder."

else
    if [ -z $2 ]; then
        USER_NAME=catkin
        CONTAINER_ALIAS=$1
    else
        USER_NAME=$2
        CONTAINER_ALIAS=$1-$2
    fi

    ORIG_PWD=$(pwd)
    CONTAINER_HOME=$(pwd)/docker/container/$CONTAINER_ALIAS/home/$USER
    WS_SRC_FOLDER=$CONTAINER_HOME/catkin_ws/src
    SPLITED_ONE=($(echo $1 | tr "-" "\n"))

    mkdir -p $WS_SRC_FOLDER
    mkdir -p $

    echo "source /opt/ros/${SPLITED_ONE[0]}/setup.bash" >> $CONTAINER_HOME/.bashrc

    echo "This may take a while... Downloading needed packages' repositories..."

    # Clone legged_control
    git clone -b navigation_test_am git@github.com:leggedrobotics-usp/legged_control.git $WS_SRC_FOLDER/legged_control
    # Clone OCS2
    git clone https://github.com/leggedrobotics/ocs2.git $WS_SRC_FOLDER/ocs2
    # Clone pinocchio
    git clone --recurse-submodules https://github.com/leggedrobotics/pinocchio.git $WS_SRC_FOLDER/pinocchio
    # Clone hpp-fcl
    git clone --recurse-submodules https://github.com/leggedrobotics/hpp-fcl.git $WS_SRC_FOLDER/hpp-fcl
    # Clone ocs2_robotic_assets
    git clone https://github.com/leggedrobotics/ocs2_robotic_assets.git $WS_SRC_FOLDER/ocs2_robotic_assets
    # Clone pronto
    git clone https://github.com/ori-drs/pronto.git $WS_SRC_FOLDER/pronto
    # Clone kindr
    git clone -b master https://github.com/ANYbotics/kindr.git $WS_SRC_FOLDER/kindr
    # Clone kindr ros
    git clone -b master https://github.com/ANYbotics/kindr_ros.git $WS_SRC_FOLDER/kindr_ros
    # Clone grid map
    git clone -b master https://github.com/ANYbotics/grid_map.git $WS_SRC_FOLDER/grid_map
    # Clone octomap_msgs
    git clone -b melodic-devel https://github.com/OctoMap/octomap_msgs.git $WS_SRC_FOLDER/octomap_msgs
    # Clone elevation mapping
    git clone -b master https://github.com/ANYbotics/elevation_mapping.git $WS_SRC_FOLDER/elevation_mapping
    # Clone message_logger dependency of elevation_mapping
    git clone -b master https://github.com/ANYbotics/message_logger.git $WS_SRC_FOLDER/message_logger
    # Clone realsense gazebo plugin
    git clone -b melodic-devel https://github.com/pal-robotics/realsense_gazebo_plugin.git $WS_SRC_FOLDER/realsense_gazebo_plugin
    # Clone Navigation
    git clone -b noetic-devel https://github.com/ros-planning/navigation.git $WS_SRC_FOLDER/navigation
    # Clone Navigation Local planner -  teb_local_planner
    git clone -b noetic-devel https://github.com/rst-tu-dortmund/teb_local_planner.git $WS_SRC_FOLDER/navigation/teb_local_planner
    # Clone move_base_sequence
    git clone -b main https://github.com/MarkNaeem/move_base_sequence.git $WS_SRC_FOLDER/move_base_sequence

    # Clone Yujin Lidar    
    git clone -b master https://github.com/leggedrobotics-usp/yujin_lidar.git $WS_SRC_FOLDER/yujin_lidar

    # Clone rtabmap_ros
    git clone -b noetic-devel https://github.com/introlab/rtabmap_ros.git $WS_SRC_FOLDER/rtabmap_ros



    # Clone mapping legro    
    git clone -b am2/dev git@github.com:leggedrobotics-usp/mapping_legro.git $WS_SRC_FOLDER/mapping_legro

    # Clone am navigation   
    #git clone -b am/dev git@github.com:leggedrobotics-usp/am_navigation.git $WS_SRC_FOLDER/am_navigation
    git clone -b am2/dev git@github.com:leggedrobotics-usp/am_navigation.git $WS_SRC_FOLDER/am_navigation

    # Colocando o am_maps
    git clone -b am/dev git@github.com:leggedrobotics-usp/am_maps.git $WS_SRC_FOLDER/am_maps


    git clone https://github.com/Livox-SDK/livox_ros_driver2.git $WS_SRC_FOLDER/livox_ros_driver2

    git clone https://github.com/Livox-SDK/livox_ros_driver.git $WS_SRC_FOLDER/livox_ros_driver

    git clone https://github.com/koide3/livox_to_pointcloud2.git $WS_SRC_FOLDER/livox_to_pointcloud2

    git clone https://github.com/leggedrobotics-usp/fiducial_detect_ros $WS_SRC_FOLDER/fiducial_detect_ros

    git clone https://github.com/hku-mars/FAST_LIO $WS_SRC_FOLDER/FAST_LIO
    cd $WS_SRC_FOLDER/FAST_LIO
    git submodule update --init

    cd $WS_SRC_FOLDER
    git clone https://github.com/unitreerobotics/unilidar_sdk.git
    rm -rf unilidar_sdk/unitree_lidar_ros2

    #Folow waypointS
    #git clone -b master https://github.com/danielsnider/follow_waypoints.git $WS_SRC_FOLDER/follow_waypoints
    
    echo "Building $1 docker image..."

    cd "$ORIG_PWD"
    ./docker/build.sh $1

fi

