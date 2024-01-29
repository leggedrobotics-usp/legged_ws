FROM osrf/ros:noetic-desktop-full-focal

# Avoiding interactive problems when updating
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Recife

RUN apt update && apt upgrade -y

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

# Intel RealSense SDK Installation
RUN apt install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev -y
WORKDIR /opt
RUN git clone https://github.com/IntelRealSense/librealsense.git
WORKDIR /opt/librealsense

RUN mkdir -p build && cd build
RUN cmake . -DBUILD_EXAMPLES=true
RUN make uninstall && make clean && make && make install -j$(nproc --all)
RUN apt install bash -y
RUN /bin/bash scripts/setup_udev_rules.sh
# RUN /bin/bash scripts/patch-realsense-ubuntu-lts.sh