# ▶️ ArcelorMittal Legged Workspace 💻

[![Docker](https://img.shields.io/badge/docker-ready-blue?logo=docker)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/ubuntu-20.04-orange?logo=ubuntu)](https://releases.ubuntu.com/20.04/)
[![ROS Noetic](https://img.shields.io/badge/ROS-Noetic-blueviolet?logo=ros)](http://wiki.ros.org/noetic)

> A streamlined repository designed for deployment at **ArcelorMittal**, based on the **Legged Robotics Workspace**. 😎

---

## 🚀 Quickstart

### 0️⃣ Install GIT, Docker, and Clone this Repository

To deploy the ArcelorMittal workspace, you will need **GIT** and **Docker**.

#### 📦 Install GIT (Locally)
```bash
sudo apt install -y git
```

#### 🐋 Install Docker (Locally)
If Docker is not yet installed, we **strongly recommend** using the installation scripts available in the following repository:  
👉 [Linux Stuffs](https://github.com/lomcin/linux-stuffs)

> **Important for NVIDIA GPU Users:**  
> The **Linux Stuffs** repository also provides a script to install the **NVIDIA Container Toolkit**, which is required for GPU-enabled Docker containers.

#### 🐱 Clone our Repo (Locally)
Finally, clone this repository using:
```bash
git clone https://github.com/leggedrobotics-usp/legged_ws.git
```

---

### 1️⃣ Prepare the ArcelorMittal Workspace (Locally)

This project uses an **Ubuntu 20.04 (ROS Noetic)** Docker image to build the workspace.  
The first step is to prepare the environment by downloading all necessary dependencies and packages.

Run the following script:
```bash
./scripts/prepare_am_ws.sh

> **Note:** The script will attempt to build the Docker image automatically at the end of its execution.  
> If any errors occur, try rebuilding manually using:  
> ```bash
> ./docker/build.sh noetic-am
> ```
```

---

### 2️⃣ Launch the Docker Container (Locally)

Once the workspace has been prepared, start the Docker container with:
```bash
./docker/run_am.sh
```

---

### 3️⃣ Build  (Inside the Docker)

Inside the docker, you will need to compile the packages inside the docker for usage, through:
```bash
./scripts/build_am_ws.sh
```

Note that this action may take a while.

---

### 4️⃣ Source Packages and Run the Simulation (Inside the Docker)

After entering the container, source the necessary ROS environments and launch the simulation example:

```bash
source /opt/ros/noetic/setup.bash
source devel/setup.bash
export GAZEBO_MODEL_PATH=~/catkin_ws/src/am_maps/worlds/models:$GAZEBO_MODEL_PATH
export GAZEBO_RESOURCE_PATH=~/catkin_ws/src/am_maps:$GAZEBO_RESOURCE_PATH
roslaunch am_navigation legged_sim_navigation.launch enable_elevation:=true enable_map:=true 
```

---

### 5️⃣ Source Packages and Send Commands (Inside a New Docker)

Open a **second terminal** using:
```bash
./docker/attach_am.sh
```

Then, source the same environments and start the navigation example:
```bash
source /opt/ros/noetic/setup.bash
source devel/setup.bash
export GAZEBO_MODEL_PATH=~/catkin_ws/src/am_maps/worlds/models:$GAZEBO_MODEL_PATH
export GAZEBO_RESOURCE_PATH=~/catkin_ws/src/am_maps:$GAZEBO_RESOURCE_PATH
rosservice call /startPath "{}"
```

---

## 🧩 Troubleshooting

> **Note 1:**  
> If the example does not initialize correctly, it might be due to an incomplete build.  
> Try rebuilding the Docker image manually:  
> ```bash
> ./docker/build.sh noetic-am
> ```

> **Note 2:**  
> If the Gazebo world fails to load properly, wait a few moments or relaunch Gazebo.  
> The autonomous navigation module requires the world to be fully initialized before operation.
> I.e., the AM map and the robot trotting in place.

---

✅ **That’s all, folks!**  
Your environment should now be ready for testing and development within the ArcelorMittal legged robotics workspace.