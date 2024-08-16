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

# Install all dependencies
# Some of them were generated with rosdep check --from-paths src --rosdistro noetic
RUN apt-get update && apt-get install -y \
    doxygen \
    gdb \
    gnome-terminal \
    libassimp-dev \
    libglpk-dev \
    libnetpbm10-dev \
    liboctomap-dev \
    libsdl-dev \
    libsdl-image1.2-dev \
    libsdl-image1.2-dev \
    libsdl1.2-dev \
    liburdfdom-dev \
    mesa-utils \
    python-lxml \
    python-numpy \
    python3-catkin-tools \
    python3-rosdep \
    ros-noetic-amcl \
    ros-noetic-base-local-planner \
    ros-noetic-carrot-planner \
    ros-noetic-clear-costmap-recovery \
    ros-noetic-control-box-rst \
    ros-noetic-costmap-2d \
    ros-noetic-costmap-converter \
    ros-noetic-dwa-local-planner \
    ros-noetic-fake-localization \
    ros-noetic-global-planner \
    ros-noetic-grid-map-core \
    ros-noetic-grid-map-cv \
    ros-noetic-grid-map-demos \
    ros-noetic-grid-map-filters \
    ros-noetic-grid-map-loader \
    ros-noetic-grid-map-msgs \
    ros-noetic-grid-map-octomap \
    ros-noetic-grid-map-ros \
    ros-noetic-grid-map-rviz-plugin \
    ros-noetic-grid-map-sdf \
    ros-noetic-grid-map-visualization \
    ros-noetic-hpp-fcl \
    ros-noetic-joint-state-publisher-gui \
    ros-noetic-joint-state-publisher-gui \
    ros-noetic-libg2o \
    ros-noetic-map-server \
    ros-noetic-mbf-costmap-core \
    ros-noetic-mbf-msgs \
    ros-noetic-move-base \
    ros-noetic-move-base \
    ros-noetic-move-base-msgs \
    ros-noetic-move-base-sequence \
    ros-noetic-move-slow-and-clear \
    ros-noetic-nav-core \
    ros-noetic-navfn \
    ros-noetic-octomap \
    ros-noetic-octomap-msgs \
    ros-noetic-pinocchio \
    ros-noetic-pybind11-catkin \
    ros-noetic-robot-localization \
    ros-noetic-robot-localization \
    ros-noetic-rotate-recovery \
    ros-noetic-rqt-controller-manager \
    ros-noetic-rqt-multiplot \
    ros-noetic-rtabmap \
    ros-noetic-rtabmap-ros \
    ros-noetic-rviz \
    ros-noetic-tf2-sensor-msgs \
    ros-noetic-tf2-tools \
    ros-noetic-tf2-tools \
    ros-noetic-turtlebot3-gazebo \
    ros-noetic-voxel-grid

# dependencies for real robot
WORKDIR /tmp
RUN git clone -b v1.4.0 https://github.com/lcm-proj/lcm
RUN mkdir -p /tmp/lcm/build
RUN cd /tmp/lcm/build \
    && cmake .. \
    && make \
    && make install
