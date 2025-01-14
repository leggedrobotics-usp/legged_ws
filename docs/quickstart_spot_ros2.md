** THIS CODE IS NOT PHYSICALLY REALISTIC YET **

## Create and run the docker

At /directory/to/repo/legged_ws, run this command to create the image:

```
./scripts/prepare_spot2_ws.sh humble-spot
```

This one to run:
```
./docker/run_no_workdir.sh humble-spot
```

Inside the container, run this command to compile:
```
./scripts/build_spot_ros2.sh
```

## Real Robot
You can set the credentials using the following environment variables: `BOSDYN_CLIENT_USERNAME`, `BOSDYN_CLIENT_PASSWORD`, and `SPOT_IP`.

And, run:
```
ros2 launch spot_ros2_control spot_ros2_control.launch.py hardware_interface:=robot
```

You also can set the credentials in an `YAML` file, like:

```
ros__parameters:
    username: "username"
    password: "password"
    hostname: "00.00.00.00"
```

And, run:
```
ros2 launch spot_ros2_control spot_ros2_control.launch.py hardware_interface:=robot config_file:=path/to/spot_ros.yaml
```

Commands can be sent on the `topic /<Robot Name>/forward_position_controller/commands`. This will forward position commands directly to the joint control API through the hardware interface. The controller expects the command array to contain the list of positions to forward for each joint on the robot.

An alternative feed-forward controller provided by the spot_controllers package can be used to specify the position, velocity, and effort of all joints at the same time. To bring up this controller, add the launch argument robot_controller:=forward_state_controller. Commands can then be sent on the topic `/<Robot Name>/forward_state_controller/commands`. This controller expects the ordering of the command array to be `[<positions for each joint>, <velocities for each joint>, <efforts for each joint>]`.

## Simulation

Run spot without arm in RVIZ:

```
ros2 launch spot_ros2_control spot_ros2_control.launch.py hardware_interface:=mock
```

Run spot with arm in RVIZ:

```
ros2 launch spot_ros2_control spot_ros2_control.launch.py hardware_interface:=mock mock_arm:=True
```

Run the following commands to test these examples after launching spot_ros2_control.launch.py. If your robot does not have an arm:

```
ros2 launch spot_ros2_control noarm_squat.launch.py
```

Or, if your robot does have an arm:

```
ros2 launch spot_ros2_control wiggle_arm.launch.py
```

Add the launch argument `spot_name:=<namespace>` if the ros2 control stack was launched in a namespace.

Example of command to move the joints:

```
ros2 topic pub /forward_state_controller/commands std_msgs/msg/Float64MultiArray "data:
# Positions (12 joints: front_left, front_right, rear_left, rear_right)
- 0.5  # Front left hip
- 0.3  # Front left thigh
- -0.2 # Front left knee
- 0.5  # Front right hip
- 0.3  # Front right thigh
- -0.2 # Front right knee
- 0.5  # Rear left hip
- 0.3  # Rear left thigh
- -0.2 # Rear left knee
- 0.5  # Rear right hip
- 0.3  # Rear right thigh
- -0.2 # Rear right knee
# Velocities (12 joints)
- 0.0  # Front left hip
- 0.0  # Front left thigh
- 0.0  # Front left knee
- 0.0  # Front right hip
- 0.0  # Front right thigh
- 0.0  # Front right knee
- 0.0  # Rear left hip
- 0.0  # Rear left thigh
- 0.0  # Rear left knee
- 0.0  # Rear right hip
- 0.0  # Rear right thigh
- 0.0  # Rear right knee
# Efforts (12 joints)
- 0.0  # Front left hip
- 0.0  # Front left thigh
- 0.0  # Front left knee
- 0.0  # Front right hip
- 0.0  # Front right thigh
- 0.0  # Front right knee
- 0.0  # Rear left hip
- 0.0  # Rear left thigh
- 0.0  # Rear left knee
- 0.0  # Rear right hip
- 0.0  # Rear right thigh
- 0.0  # Rear right knee"
```

## Additional Arguments

* `controllers_config`: If this argument is unset, a general purpose controller configuration will be loaded containing a forward position controller and a joint state publisher, that is filled appropriately based on whether or not the robot used (mock or real) has an arm. The forward state controller is also specified here. If you wish to load different controllers, this can be set here.
* `robot_controller`: This is the name of the robot controller that will be started when the launchfile is called. The default is the simple forward position controller. The name must match a controller in the `controllers_config` file.
* `launch_rviz`: If you do not want rviz to be launched, add the argument `launch_rviz:=False`.

## Missing features

* Python scripts to control spot robot(s).
* Graphical interface, suuch as: Gazebo, WeBots, IsaacSim, Unity, or Unreal. [This repository](https://github.com/MASKOR/webots_ros2_spot/tree/main) is an option, but it needs the SDK.
