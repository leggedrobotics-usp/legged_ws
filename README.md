# Legged Robotics Workspace 💻

A simplified repository for Legged Robotics Workspace using ROS + Docker. 😎

What is *contained* in this repository?
* Dockerfiles for some of ROS distros with the needed build instructions.
* Scripts that makes docker a little bit easier.


# Quickstart 🚀 [recommended] 👈

## Step 0 - Install GIT and Docker

### GIT 🌳
```bash
sudo apt install -y git
```

### Docker 🐳
We strongly recommend using the installation of docker from this repository:
[Linux Stuffs](https://github.com/lomcin/linux-stuffs).

***IMPORTANT FOR NVIDIA's GPU's USERS***: There's also a script for installation of NVIDIA CONTAINER TOOLKIT in the [Linux Stuffs](https://github.com/lomcin/linux-stuffs) repository.

## Step 1 - Clone this repository
To download this repository with the dependencies repositories use the following command:
```bash
git clone https://github.com/lomcin/legged_ws.git
```

**NOTE: If you just have cloned this repository you will need the following steps:**

## Step 2 - Go1 robot workspace

The following command will prepare all the needed repositories and build the needed docker image with melodic-legged image. (ros-melodic-legged, see [Step 3]())
```bash
./scripts/prepare_go1_ws.sh melodic-legged
```

## Step 3 - ROS Melodic Full "LEGGED" version (Ubuntu 18.04)
**NOTE: Already built if you followed step 2 **
To easily start a ROS container:
```bash
./docker_run.sh melodic-legged
```

## Step 4 - Build the packages
Now, inside the docker container let's build all the needed packages.

```If you don't know whether you are inside a container, check if yout current folder and user look something like:``` **user@computer:~/catkin_ws$**

```bash
./scripts/build_go1_ws.sh
```

# FAQ - Frequently Asked Questions ❓
[Click here to be redirected to FAQ.md file.](FAQ.md)

# This repository and its users are thankful for
<table style="display:flex; justify-items:center; justify-content:center; align-items:center; align-content:center;">
<tbody>
<tr>
<td>
<img src="https://avatars.githubusercontent.com/u/16033414" alt="Lucas Maggi" width="100px" height="auto" style="border-radius:50%; border: 2px solid white; position: relative; top: 0px; z-index:9999;" class="avatar-user">
<h2>Lucas Maggi</h2> https://github.com/lomcin
</td>
<td>
<img src="https://avatars.githubusercontent.com/u/43577281" alt="Vivian Suzano" width="100px" height="auto" style="border-radius:50%; border: 2px solid white; position: relative; top: 0px; z-index:9999;" class="avatar-user">
<h2>Vivian Suzano</h2> https://github.com/viviansuzano
</td>
<td>
<img src="https://avatars.githubusercontent.com/u/780327" alt="Gustavo Lahr" width="100px" height="auto" style="border-radius:50%; border: 2px solid white; position: relative; top: 0px; z-index:9999;" class="avatar-user">
<h2>Gustavo Lahr</h2> https://github.com/glahr
</td>
</tr>
</tbody>
</table>




