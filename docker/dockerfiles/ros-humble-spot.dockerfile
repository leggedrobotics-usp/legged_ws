FROM osrf/ros:humble-desktop-full

# Install dependencies (taken from devcontainer dockerfile)
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && \
    apt-get update -q && \
    apt-get install -yq --no-install-recommends \
    tmux \
    # just to validate new packages faster
    git \ 
    curl \
    wget \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control \
    ros-humble-robot-localization \
    python3-pip \
    python-is-python3 \
    python3-argcomplete \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    libgazebo-dev \
    libpython3-dev && \
    rm -rf /var/lib/apt/lists/*

# Create ROS workspace
WORKDIR /catkin_ws/src

# Clone driver code
RUN git clone https://github.com/bdaiinstitute/spot_ros2.git .
RUN git submodule update --init --recursive

# Run install script
RUN /catkin_ws/src/install_spot_ros2.sh

# Build packages with Colcon
WORKDIR /catkin_ws/
RUN . /opt/ros/humble/setup.sh && \
    colcon build --symlink-install --packages-ignore proto2ros proto2ros_tests

RUN echo "source /catkin_ws/install/setup.bash" >> ~/.bashrc
RUN echo "export BOSDYN_CLIENT_USERNAME=username" >> ~/.bashrc
RUN echo "export BOSDYN_CLIENT_PASSWORD=password" >> ~/.bashrc
RUN echo "export SPOT_IP=00.00.00.00" >> ~/.bashrc
