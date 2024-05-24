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
