FROM osrf/ros:melodic-desktop-full-bionic

# Avoiding interactive problems when updating
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Recife

RUN apt update && apt upgrade -y

RUN apt install wget git build-essential -y

RUN apt-get update
RUN apt-get install python3-catkin-tools -y

# INSTALLING EIGEN 3 FROM SOURCE
WORKDIR /opt
RUN git clone -b 3.4 https://gitlab.com/libeigen/eigen.git
RUN cd eigen && mkdir build && cd build && cmake .. 
WORKDIR /opt/eigen/build
RUN make install

# INSTALLING SpaceVecAlg FROM SOURCE
WORKDIR /opt
RUN git clone --recursive https://github.com/jrl-umi3218/SpaceVecAlg
RUN cd SpaceVecAlg && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_BINDING=OFF ..
WORKDIR /opt/SpaceVecAlg/build
RUN make -j
RUN make install

# INSTALLING RBDyn FROM SOURCE 
WORKDIR /opt
RUN git clone --recursive https://github.com/jrl-umi3218/RBDyn
RUN cd RBDyn && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_BINDING=OFF ..
WORKDIR /opt/RBDyn/build
RUN make -j
RUN make install

# INSTALLING mc_rbdyn_urdf FROM SOURCE
WORKDIR /opt
RUN git clone --recursive https://github.com/jrl-umi3218/mc_rbdyn_urdf
RUN cd mc_rbdyn_urdf && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_BINDING=OFF ..
WORKDIR /opt/mc_rbdyn_urdf/build
RUN make -j
RUN make install

RUN apt-get update
RUN apt-get install -y ros-melodic-joint-state-publisher-gui
RUN apt-get install -y ros-melodic-rqt-multiplot
RUN apt-get install -y ros-melodic-controller-interface
RUN apt-get install -y ros-melodic-gazebo-ros-pkgs
RUN apt-get install -y ros-melodic-gazebo-ros-control
RUN apt-get install -y ros-melodic-joint-state-controller
RUN apt-get install -y ros-melodic-effort-controllers
RUN apt-get install -y ros-melodic-joint-trajectory-controller
RUN apt-get install -y mesa-utils libgl1-mesa-glx

# Installing nano here to take advantage of cached commands:
RUN apt update && apt install nano
# IF YOU NEED TO DEBUG CODE
# RUN apt install gdb -y