FROM nvidia/cudagl:11.3.0-devel-ubuntu20.04 AS nvidia

# Avoiding interactive problems when updating
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

# Install Configure and ROS Noetic
RUN apt update && apt upgrade -y
RUN apt install -y wget git build-essential lsb-release curl
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update && apt-get upgrade -y && apt-get install -y ros-noetic-desktop-full

# Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget git build-essential \
    python3-catkin-tools \
    python3-rosdep \
    liburdfdom-dev liboctomap-dev libassimp-dev \
    libsdl-image1.2-dev \
    libsdl-dev

# Install dependencies
RUN apt install -y ros-noetic-rviz
RUN apt install wget git build-essential -y
RUN apt-get install python3-catkin-tools -y
RUN apt install liburdfdom-dev liboctomap-dev libassimp-dev
RUN apt update && apt upgrade -y
RUN apt install ros-noetic-tf2-tools -y
RUN apt install ros-noetic-move-base -y
RUN apt install ros-noetic-robot-localization -y
RUN apt install -y ros-noetic-joint-state-publisher-gui
RUN apt install -y ros-noetic-rqt-multiplot
RUN apt install -y ros-noetic-rosbridge-server
RUN apt install -y ros-noetic-tf2-web-republisher

# dependencies generated with rosdep check --from-paths src --rosdistro noetic
RUN apt-get update && apt-get install -y \
    ros-noetic-rqt-multiplot \
    ros-noetic-rqt-controller-manager \
    ros-noetic-tf2-tools \
    ros-noetic-grid-map-core \
    ros-noetic-grid-map-ros \
    ros-noetic-grid-map-cv \
    ros-noetic-grid-map-msgs \
    ros-noetic-grid-map-filters \
    ros-noetic-grid-map-visualization \
    ros-noetic-grid-map-rviz-plugin \
    ros-noetic-grid-map-loader \
    ros-noetic-grid-map-demos \
    ros-noetic-move-base \
    ros-noetic-robot-localization \
    ros-noetic-pinocchio \
    ros-noetic-octomap \
    ros-noetic-costmap-2d \
    ros-noetic-nav-core \
    ros-noetic-navfn \
    ros-noetic-map-server \
    ros-noetic-hpp-fcl \
    doxygen \
    ros-noetic-base-local-planner \
    ros-noetic-pybind11-catkin \
    python-numpy \
    python-lxml \
    ros-noetic-grid-map-sdf \
    ros-noetic-rqt-multiplot \
    ros-noetic-move-base-msgs \
    ros-noetic-clear-costmap-recovery \
    ros-noetic-rotate-recovery \
    ros-noetic-voxel-grid \
    ros-noetic-amcl \
    ros-noetic-carrot-planner \
    ros-noetic-dwa-local-planner \
    ros-noetic-fake-localization \
    ros-noetic-global-planner \
    ros-noetic-move-slow-and-clear \
    libnetpbm10-dev \
    ros-noetic-grid-map-octomap \
    ros-noetic-octomap-msgs \
    libsdl1.2-dev \
    libsdl-image1.2-dev \
    libglpk-dev \
    ros-noetic-tf2-sensor-msgs \
    ros-noetic-turtlebot3-gazebo \
    ros-noetic-control-box-rst \
    ros-noetic-libg2o \
    ros-noetic-costmap-converter \
    ros-noetic-mbf-costmap-core \
    ros-noetic-mbf-msgs \
    ros-noetic-move-base-sequence
    RUN apt-get update && apt-get install -y \
    ros-noetic-rtabmap \
    ros-noetic-rtabmap-ros \
    && rm -rf /var/lib/apt/lists/
#RUN apt install -y ros-noetic-mp[lc-local-planner

    #ros-noetic-follow-waypoints 
    


# dependencies for real robot
WORKDIR /tmp
RUN git clone -b v1.4.0 https://github.com/lcm-proj/lcm
RUN mkdir -p /tmp/lcm/build
RUN cd /tmp/lcm/build \
    && cmake .. \
    && make \
    && make install

# Intel RealSense SDK Installation
RUN apt update && apt upgrade -y && apt install -y git libssl-dev libusb-1.0-0-dev pkg-config 
WORKDIR /opt
RUN git clone https://github.com/IntelRealSense/librealsense.git

RUN apt install -y bash v4l-utils libssl-dev libudev1 libudev-dev pkg-config xorg-dev libglu1-mesa-dev libgtk-3-dev libx11-dev

WORKDIR /opt/librealsense
RUN mkdir -p build && cd build
WORKDIR /opt/librealsense/build
RUN cmake .. -DBUILD_EXAMPLES=true
RUN make uninstall && make clean && make && make install -j$(nproc --all)
WORKDIR /opt/librealsense
RUN /bin/bash scripts/setup_udev_rules.sh
RUN apt-get install ros-noetic-realsense2-camera ros-noetic-realsense2-description -y
RUN apt install ros-noetic-rtabmap* -y
RUN apt install ros-noetic-octomap* -y
# The Focal patches are maintained for Ubuntu LTS with kernel 5.4, 5.8, 5.11 only
# RUN /bin/bash scripts/patch-realsense-ubuntu-lts.sh


# # Yujin LIDAR
# WORKDIR /opt
# RUN git clone -b main https://github.com/yujinrobot/yujin_lidar_v2
# WORKDIR /opt/yujin_lidar_v2/driver_general/yujinrobot_yrldriver
# RUN mkdir build && cd build && cmake .. && make install

RUN apt install python3 python3-dev python3-pip
RUN pip3 install kiss-icp