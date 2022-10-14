#!/bin/bash

# https://docs.sylabs.io/guides/3.2/user-guide/singularity_and_docker.html#locally-available-images-stored-archives
# docker images
# <copy image id. ex: 74c62525826c>
# sudo docker save 74c62525826c -o go1_rl.tar
# ./build_container_go1_rl.sh
# remove go1_rl.tar
# TODO: add folders bindings (this comes from docker path)

sudo singularity build go1_rl.sif docker-archive://go1_rl.tar