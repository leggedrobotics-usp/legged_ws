# Quickstart for Melodic
[ [Back to README.md](../README.md) ]

## Previous steps
Previous steps are available on the [README.md](../README.md) file.
NOTE: We have only the Go1 and Z1 workspaces that are fully compatible with ROS Melodic.

## Step 2 - Go1 robot workspace in Melodic
### Option: Go1

The following command will prepare all the needed repositories and build the needed docker image with melodic-legged image.
```bash
./scripts/prepare_go1_ws.sh melodic-legged
```

### Option: Z1

The following command will prepare all the needed repositories and build the needed docker image with melodic-z1arm image.
```bash
./scripts/prepare_z1_ws.sh melodic-z1arm
```

## Step 3 - ROS Melodic Full "LEGGED" version (Ubuntu 18.04)
**NOTE: Already built if you followed step 2 **

### Option: Go1
To easily start a ROS container:
```bash
./docker/run.sh melodic-legged
```
### Option: Z1
```bash
./docker/run.sh melodic-z1arm
```

## Step 4 - Build the packages
Now, inside the docker container let's build all the needed packages.

```If you don't know whether you are inside a container, check if yout current folder and user look something like:``` **user@computer:~/catkin_ws$**

### Option: Go1
```bash
./scripts/build_go1_ws.sh
```

### Option: Z1
```bash
./scripts/build_z1_ws.sh
```