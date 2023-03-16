#!/bin/bash
# Script to easily clear the ~/.ros/log folder
./docker_exec.sh "$1" "$2" rm -rf ~/.ros/log