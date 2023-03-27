# FAQ - Frequently Asked Questions ❓
[ [Back to README.md](../README.md) ]

## Problems with Nvidia (container/image/OpenGL/CUDA)?
First things first: **Are you using Docker Desktop?**
### If **Yes**: ***Then, remove it***.
1. Remove [Docker Desktop](https://www.docker.com/products/docker-desktop/):
```bash
sudo apt remove docker-desktop
```

2. Let's begin with a fresh start.

    [Remove all of your containers](https://docs.docker.com/engine/reference/commandline/container_rm/).

3. Then, remove all of your local images.
```bash
docker image prune -af
```

4. Remove docker configuration from the user home folder.
```bash
rm -rf ~/.docker
```

5. Install Docker from this script:
```
wget -O - https://github.com/lomcin/linux-stuffs/install/docker | bash
```

6. Install Nvidia Container Toolkit
```
wget -O - https://github.com/lomcin/linux-stuffs/install/nvidia/container_toolkit | bash
```

7. Install Nvidia docker 2
```bash
sudo apt install nvidia-docker2
```

8. Restart your computer.

### If **No**: Check-out the [nvidia-docker wiki](https://github.com/NVIDIA/nvidia-docker/wiki).

## How to build a docker image
If you already know which image you want to use, then:
```bash
./docker/build.sh ROS_IMAGE_VERSION_NAME_HERE
```
Where `ROS_IMAGE_VERSION_NAME_HERE` is the image name you want to use.
**But I don't know which image I want to use.** Then, choose wisely from the [IMAGES.md](IMAGES.md) file, or create your own using the same pattern from the available images in `docker/dockerfiles` files.

## How do I use a different ROS distribution?
To see the full list of docker images go to [IMAGES.md](IMAGES.md).

## How do I get out of the container?
If it is your last terminal, then just put `exit` or use the `Ctrl+D` shortcut.

## How do I open another terminal inside a running container?
Let's say you already have opened a container with `melodic-legged` argument. It will use the `ros-melodic-legged` image, and it will create the `ros_melodic-legged` container.
Once you know where do you want to attach your terminal, lets use the following command on your brand new terminal window (or tab):

```bash
./docker/attach.sh melodic-legged
```

## How do I run a command directly to a running container?
Let's say you already have opened a container with `melodic-legged` argument. It will use the `ros-melodic-legged` image, and it will create the `ros_melodic-legged` container.
Once you know where do you want to run a command on your terminal, let's use the following command on your brand new terminal window (or tab) to just start a new bash instance:

```bash
./docker/exec.sh melodic-legged "/bin/bash"
```

**NOTE: "/bin/bash" could be changed (in theory) for another command, a ROS command could also be applied here. EXPERIMENTAL OPTION.**
