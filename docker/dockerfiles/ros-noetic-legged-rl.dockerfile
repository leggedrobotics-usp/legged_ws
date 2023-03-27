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

# Install RL specific dependencies
RUN apt install python3 python3-dev python3-pip
RUN pip3 install pyyaml
RUN pip3 install rospkg
RUN pip3 install scipy
RUN pip3 install torch
RUN pip3 install pandas 
RUN pip3 install gym
RUN pip3 install stable-baselines3
