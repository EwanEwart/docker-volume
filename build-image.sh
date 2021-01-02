#!/bin/bash

if (( $# == 0 )); then
    # Run script with no arguments: build container
    # and run with default argument
    # 
    # export DOCKER_HOST=ssh://keir@192.168.188.222
    # echo "→ DOCKER_HOST=$DOCKER_HOST"

    echo "→ Delete dangling images"
    docker image prune

    echo "→ Delete dangling images - alternative"
    docker rmi -f `docker images -q -f dangling=true`

    echo "Delete non-active containers"
    docker container prune

    echo "→ Build an image from a Dockerfile"
    echo "→ Usage:  docker build [OPTIONS] PATH | URL | -"
    docker build . -t "docker-volume-image"

    # echo "→ Run"
    # echo "→ → Raw-Run"
    # ./main.go

    echo "→ Container-Run"
    docker run \
        -v external.vol:/go/bin \
        docker-volume-image 
        # --name docker-volume-container \
        # docker-volume-image 7
        # --rm \
else
    # Run script with numeric argument
    # specifying the number of lines 
    # written to the volume
    # 
    docker run \
        -v external.vol:/go/bin \
        docker-volume-image $1
fi
sudo cat  /var/lib/docker/volumes/external.vol/_data/created-externally