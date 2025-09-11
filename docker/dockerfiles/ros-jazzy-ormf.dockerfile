# Uncomment the following 'FROM' line for Nvidia drivers version, and comment the 'FROM ubuntu:24.04'.
# NOTE: Your system must have the 12.8 CUDA version in it's drivers too!

# FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04
FROM ubuntu:24.04

# Avoiding interactive problems when updating
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Recife

# Avoiding problems with chown
ARG USER_ID
ARG GROUP_ID
ARG USER
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}

# Creating user and group
RUN groupadd --force -g ${GROUP_ID} ${USER}

# Check if user already exists
# RUN if id -u ${USER} >/dev/null 2>&1; then echo "User ${USER} already exists"; else echo "User don't exists, creating it"; fi
# RUN if id -u ${USER} >/dev/null 2>&1; then echo "User ${USER} already exists"; else useradd -m -u ${USER_ID} -g ${GROUP_ID} ${USER}; fi
# useradd -m -u ${USER_ID} -g ${GROUP_ID} ${USER}; fi

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

# --- 2. Install system build tools, rosdep, Python & pip modules (incl. pipenv)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      curl \
      wget \
      ca-certificates \
      build-essential \
      python3-pip \
      python3-venv \
      python3-colcon-common-extensions \
      python3-vcstool \
      ros-dev-tools
    # && rm -rf /var/lib/apt/lists/* && \
RUN echo "source /opt/ros/jazzy/setup.bash" >> /etc/bash.bashrc

# Configure python global virtual environment
RUN apt-get update && apt-get install -y \
      python3-fastapi \
      python3-uvicorn \
      python3-flask-socketio

# --- 4. Install Node.js 20.x and pnpm for rmf-web
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g pnpm && \
    rm -rf /var/lib/apt/lists/*

# Installl ROS 2 (Jazzy): ROS, RViz, demos, tutorials.
RUN apt update && apt install ros-jazzy-desktop-full -y
RUN apt-get install ros-jazzy-ros-gz -y


# --- 5. Clone & build rmf-web (as root)
RUN git clone --depth 1 https://github.com/open-rmf/rmf-web.git /opt/rmf-web
WORKDIR /opt/rmf-web
RUN pnpm install --frozen-lockfile
# Pin Pydantic to >=2.1 so extras_keys_schema arg exists
# RUN pipenv run pip install "pydantic>=2.1.0"
RUN apt install -y python3-pydantic
# # Build only the subpackages that have build scripts
RUN pnpm --filter "packages/api-server" run build
RUN pnpm --filter "packages/rmf-dashboard-framework" run build
# # Fix ownership so non-root user can write under /opt/rmf-web
# RUN chown -R 1000:1000 /opt/rmf-web



RUN rosdep init || true && \
    rosdep update || true && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      ros-jazzy-rmf-dev \
      ros-jazzy-rviz2 \
      ros-jazzy-ros-gz-bridge \
      ros-jazzy-ament-cmake \
      ros-jazzy-rmf-fleet-msgs \
    && rm -rf /var/lib/apt/lists/*


# --- 8. Create RMF workspace, clone & build demos (allow model downloads)
# RUN mkdir -p ~/rmf_ws/src && \
#     cd ~/rmf_ws/src && \
#     git clone --depth 1 -b 2.0.3 https://github.com/open-rmf/rmf_demos.git && \
#     cd ~/rmf_ws && \
#     source /opt/ros/jazzy/setup.bash && \
#     colcon build

# Maybe we should use the jazzy branch
# git clone --depth 1 -b jazzy https://github.com/open-rmf/rmf_demos.git
