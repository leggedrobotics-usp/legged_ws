# Legged Robotics Workspace 💻

A simplified repository for Legged Robotics Workspace using ROS + Docker. 😎

What is *contained* in this repository?
* Dockerfiles for some of ROS distros with the needed build instructions.
* Scripts that makes docker a little bit easier.


# Quickstart 🚀

## Recursively cloning this repository
To recursively download this repository with the dependencies repositories use the following command:
```bash
git clone --recurse-submodules --remote-submodules https://github.com/lomcin/legged_ws.git
```

**NOTE: If you just have cloned this repository you will need the following steps:**
Recursively download the dependencies repositories in this repository using the following command:

```bash
git submodule update --init
```

## ROS Melodic (Ubuntu 18.04) [recommended] 👈
To easily build this ROS image:
```bash
./build_ros melodic
```

To easily start a ROS container:
```bash
./run_ros melodic
```

## ROS Noetic (Ubuntu 20.04) *[not tested at all]* ☢
To easily build this ROS image:
```bash
./build_ros melodic
```

To easily start a ROS container:
```bash
./run_ros noetic
```