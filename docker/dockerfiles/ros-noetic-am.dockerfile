FROM nvidia/cudagl:11.3.0-devel-ubuntu20.04 AS nvidia

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

# Atualiza pacotes e instala ferramentas básicas
RUN apt update && apt upgrade -y && apt install -y \
    wget git build-essential curl lsb-release

# Instala ROS Noetic
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt update && apt install -y ros-noetic-desktop-full

# Inicializa rosdep
RUN apt install -y python3-rosdep && rosdep init && rosdep update

# Instala dependências ROS e bibliotecas úteis
RUN apt update && apt install -y \
    python3-catkin-tools \
    ros-noetic-rviz \
    ros-noetic-tf2-tools \
    ros-noetic-move-base \
    ros-noetic-robot-localization \
    ros-noetic-joint-state-publisher-gui \
    ros-noetic-rqt-multiplot \
    ros-noetic-rosbridge-server \
    ros-noetic-tf2-web-republisher \
    ros-noetic-rqt-controller-manager \
    ros-noetic-grid-map-core \
    ros-noetic-grid-map-ros \
    ros-noetic-grid-map-cv \
    ros-noetic-grid-map-msgs \
    ros-noetic-grid-map-filters \
    ros-noetic-grid-map-visualization \
    ros-noetic-grid-map-rviz-plugin \
    ros-noetic-grid-map-loader \
    ros-noetic-grid-map-demos \
    ros-noetic-pinocchio \
    ros-noetic-octomap \
    ros-noetic-costmap-2d \
    ros-noetic-nav-core \
    ros-noetic-navfn \
    ros-noetic-map-server \
    ros-noetic-hpp-fcl \
    ros-noetic-libg2o \
    ros-noetic-base-local-planner \
    ros-noetic-pybind11-catkin \
    python3-numpy \
    python3-lxml \
    ros-noetic-grid-map-sdf \
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
    ros-noetic-grid-map-octomap \
    ros-noetic-octomap-msgs \
    ros-noetic-tf2-sensor-msgs \
    ros-noetic-turtlebot3-gazebo \
    ros-noetic-control-box-rst \
    ros-noetic-costmap-converter \
    ros-noetic-mbf-costmap-core \
    ros-noetic-mbf-msgs \
    ros-noetic-fiducial-msgs \
    ros-noetic-vision-msgs \
    ros-noetic-move-base-sequence \
    libsdl1.2-dev \
    libsdl-image1.2-dev \
    libnetpbm10-dev \
    libglpk-dev \
    liburdfdom-dev \
    liboctomap-dev \
    libassimp-dev \
    libsdl-dev \
    doxygen \
    libsqlite3-dev \
    libpcl-dev \
    libopencv-dev \
    libproj-dev \
    libqt5svg5-dev

# Instala OpenCV 4.2.0 com módulos extras (aruco, xfeatures2d)
WORKDIR /opt
RUN git clone -b 4.2.0 https://github.com/opencv/opencv.git && \
    git clone -b 4.2.0 https://github.com/opencv/opencv_contrib.git && \
    cd opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules \
          -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_DOCS=OFF \
          -D BUILD_opencv_python2=OFF -D BUILD_opencv_python3=ON .. && \
    make -j$(nproc) && make install && ldconfig

# Instala g2o
RUN apt install -y libeigen3-dev libsuitesparse-dev qtdeclarative5-dev && \
    git clone https://github.com/RainerKuemmerle/g2o.git && \
    cd g2o && mkdir build && cd build && \
    cmake -DBUILD_WITH_MARCH_NATIVE=OFF -DG2O_BUILD_APPS=OFF -DG2O_BUILD_EXAMPLES=OFF -DG2O_USE_OPENGL=OFF .. &&\
    make -j$(nproc) && make install

    # Instala GTSAM
RUN apt install -y libboost-all-dev libtbb-dev && \
    git clone https://github.com/borglab/gtsam.git && \
    cd gtsam && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON && \
    make -j$(nproc) && make install

# Instala aruco-msgs
RUN apt install -y ros-noetic-aruco-msgs

# Instala RTAB-Map manualmente (versão específica)
WORKDIR /root/rtabmap
ENV CMAKE_INCLUDE_PATH=/opt/ros/noetic/include
ENV CMAKE_LIBRARY_PATH=/opt/ros/noetic/lib
RUN git clone https://github.com/introlab/rtabmap.git . && \
    git checkout 0.21.13-noetic && \
    mkdir -p build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j$(nproc) && make install

# Instala LCM para robô real
WORKDIR /tmp
RUN git clone -b v1.4.0 https://github.com/lcm-proj/lcm && \
    mkdir -p /tmp/lcm/build && cd /tmp/lcm/build && \
    cmake .. && make && make install

# Instala Intel RealSense SDK e dependências
RUN apt install -y git libssl-dev libusb-1.0-0-dev pkg-config \
    bash v4l-utils libudev1 libudev-dev xorg-dev libglu1-mesa-dev libgtk-3-dev libx11-dev
WORKDIR /opt
RUN git clone https://github.com/IntelRealSense/librealsense.git
WORKDIR /opt/librealsense
RUN mkdir -p build && cd build && \
    cmake .. -DBUILD_EXAMPLES=true && \
    make uninstall && make clean && make -j$(nproc) && make install && \
    /bin/bash /opt/librealsense/scripts/setup_udev_rules.sh
RUN apt install -y ros-noetic-realsense2-camera ros-noetic-realsense2-description

# Instala Python e kiss-icp
RUN apt install -y python3 python3-dev python3-pip && pip3 install kiss-icp

WORKDIR /opt/livoxmid360sdk1
RUN git clone https://github.com/Livox-SDK/Livox-SDK.git && \
    cd ./Livox-SDK/ && \
    cd build && \
    cmake .. && make -j && \
    sudo make install

WORKDIR /opt/livoxmid360sdk2
RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git && \
    cd ./Livox-SDK2/ && \
    mkdir build && \
    cd build && \
    cmake .. && make -j && \
    make install

RUN ldconfig

RUN apt install -y net-tools
RUN apt install -y nmap
RUN apt install -y iproute2
RUN apt install -y iputils-ping


RUN apt-get update && apt-get install -y --no-install-recommends \
    # Ferramentas de sistema e build
    usbutils \
    v4l-utils \
    # Dependências para compilar librealsense e outros pacotes
    libglfw3-dev \
    # Dependências Python
    python3-pip \
    python3-opencv \
    python3-yaml \
    # Pacotes ROS essenciais
    ros-noetic-catkin \
    ros-noetic-cv-bridge \
    ros-noetic-ddynamic-reconfigure \
    ros-noetic-image-transport \
    ros-noetic-rqt* \
    ros-noetic-aruco-ros

# RUN apt-get update && apt-get install -y wget gpg
# RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | \
#     gpg --dearmor -o /usr/share/keyrings/kitware-archive-keyring.gpg && \
#     echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' \
#       > /etc/apt/sources.list.d/kitware.list && \
#     apt-get update && apt-get install -y cmake

#WORKDIR /opt/pcl/src
#RUN wget https://github.com/PointCloudLibrary/pcl/releases/download/pcl-1.15.1/source.tar.gz && \
#    tar xvf source.tar.gz && \
#    cd pcl && \
#    mkdir build && \
#    cd build && \
#    cmake .. && \
#    make -j2 && \
#    make -j2 install

# WORKDIR /opt/catkin_point_lio_unilidar/src
# RUN git clone https://github.com/unitreerobotics/unilidar_sdk.git && \
#     cd ./unilidar_sdk/unitree_lidar_sdk && \
#     mkdir build && \
#     cd build && \
#     cmake .. && \
#     make -j2 && \

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-pcl-conversions \
    libeigen3-dev