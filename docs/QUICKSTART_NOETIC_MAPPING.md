# Quickstart for Mapping in Noetic
[ [Back to README.md](../README.md) ]

## Previous steps
Previous steps are available on the [README.md](../README.md) file.

## Step 1 - Build Noetic Mapping Docker image
The following command will prepare all the needed repositories and build the needed docker image with noetic-legged image.
``If you already have done it, please go to Step 2.``
```bash
./docker/build.sh noetic-legged-mapping
```

## Step 2 - ROS Noetic Mapping version (Ubuntu 20.04)
**NOTE: Already built if you followed step 1 **

To easily start a ROS container:
```bash
./docker/run.sh noetic-legged-mapping
```

## Step 3 [OPTIONAL] - Second, third, n-th terminal
**NOTE: You should run Step 2 before running Step 3 **

To easily attach to a running ROS container:
```bash
./docker/attach.sh noetic-legged-mapping
```

## Step 4 - Noetic Mapping with Intel RealSense D455 and T265
**NOTE: This should be run inside the container!!! **

To easily start to SLAM mapping, use:
```bash
roslaunch mapping_legro mapping.launch
```

## Step 5 [OPTIONAL] - ``RECORD`` Noetic Mapping with Intel RealSense D455 and T265
**NOTE: BE PREPARED TO CONSUME YOUR FREE DISC/SSD SPACE!!! **

To easily start to Record and SLAM mapping, use:
```bash
roslaunch mapping_legro mapping_record.launch
```