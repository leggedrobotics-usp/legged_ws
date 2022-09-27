# FAQ - Frequent Asked Questions ❓
[ [Back to README.md](README.md) ]

## How to build a docker image
If you already know which image you want to use, then:
```bash
./docker_build.sh ROS_IMAGE_VERSION_NAME_HERE
```
Where `ROS_IMAGE_VERSION_NAME_HERE` is the image name you want to use.
**But I don't know which image I want to use.** Then, choose wisely from the [IMAGED.md](IMAGES.md) file, or create your own using the same pattern from the available images in `docker/dockerfiles` files.

## How do I use a different ROS distribution?
To see the full list of docker images go to [IMAGES.md](IMAGES.md).

## How do I get out of the container?
If it is your last terminal, then just put `exit` or use the `Ctrl+D` shortcut.

## How do I open another terminal inside a running container?
Let's say you already have opened a container with `melodic-legged` argument. It will use the `ros-melodic-legged` image, and it will create the `ros_melodic-legged` container.
Once you know where do you want to attach your terminal, lets use the following command on your brand new terminal window (or tab):

```bash
./docker_attach.sh melodic-legged
```

## How do I run a command directly to a running container?
Let's say you already have opened a container with `melodic-legged` argument. It will use the `ros-melodic-legged` image, and it will create the `ros_melodic-legged` container.
Once you know where do you want to run a command on your terminal, let's use the following command on your brand new terminal window (or tab) to just start a new bash instance:

```bash
./docker_exec.sh melodic-legged "/bin/bash"
```

**NOTE: "/bin/bash" could be changed for another command, a ROS command could also be applied here.**