#!/bin/bash

# https://docs.sylabs.io/guides/3.2/user-guide/singularity_and_docker.html#locally-available-images-stored-archives
# docker images
# <copy image id. ex: 74c62525826c>
# sudo docker save 74c62525826c -o go1_rl.tar
# ./build_container_go1_rl.sh
# remove go1_rl.tar
# TODO: add folders bindings (this comes from docker path)

# >>> os.popen("docker images | grep melodic-legged").read().split()[2] this command returns the image id
# o docker image nao tem ros? 

sudo singularity build go1_rl.sif docker-archive://go1_rl.tar