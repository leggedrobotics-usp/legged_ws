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

RUN apt install -y ros-noetic-joy ros-noetic-teleop-tools
RUN apt install -y usbutils
RUN apt install -y ros-noetic-teleop-twist-joy