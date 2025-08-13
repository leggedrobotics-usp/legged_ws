# Uncomment the following 'FROM' line for Nvidia drivers version, and comment the 'FROM ubuntu:24.04'.
# NOTE: Your system must have the 12.8 CUDA version in it's drivers too!

# FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04
FROM ubuntu:24.04

# Avoiding interactive problems when updating
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Recife

# Update before installing stuffs
RUN apt update && apt upgrade -y

# Ensure Ubuntu Universe repository is enabled
RUN apt install software-properties-common -y
RUN add-apt-repository universe -y

# Add the ROS 2 apt repository key with apt
RUN apt update && apt install curl -y
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# Add the ROS 2 apt repository to the sources list
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install Development tools
RUN apt update && apt install ros-dev-tools -y

# Update (again) before installing stuffs
RUN apt update && apt upgrade -y

# Installl ROS 2 (Jazzy): ROS, RViz, demos, tutorials.
RUN apt install ros-jazzy-desktop -y
RUN apt-get install ros-jazzy-ros-gz -y
RUN apt-get update \
  && apt-get install -y --no-install-recommends python3 python3-pip ca-certificates