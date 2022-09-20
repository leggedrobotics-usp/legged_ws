# Legged Robotics Workspace 💻

A simplified repository for Legged Robotics Workspace using ROS + Docker. 😎

What is *contained* in this repository?
* Dockerfiles for some of ROS distros with the needed build instructions.
* Scripts that makes docker a little bit easier.


# Quickstart 🚀

## Clone this repository
To download this repository with the dependencies repositories use the following command:
```bash
git clone https://github.com/lomcin/legged_ws.git
```

**NOTE: If you just have cloned this repository you will need the following steps:**

## ROS Melodic Full "LEGGED" version (Ubuntu 18.04) [recommended] 👈
To easily build this ROS image:
```bash
./build_ros melodic-legged
```

To easily start a ROS container:
```bash
./run_ros melodic-legged
```

***To see the full list of docker images go to [IMAGES.md](IMAGES.md).***