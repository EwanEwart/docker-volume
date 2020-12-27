#!/usr/bin/bash

# export DOCKER_HOST=ssh://keir@192.168.188.222
# echo "→ DOCKER_HOST=$DOCKER_HOST"

echo "→ Delete dangling images"
docker image prune

echo "→ Delete dangling images - alternative"
docker rmi -f `docker images -q -f dangling=true`

echo "→ Build an image from a Dockerfile"
echo "→ Usage:  docker build [OPTIONS] PATH | URL | -"
docker build . -t "docker-volume"

# echo "→ Run"
# echo "→ → Raw-Run"
# ./main.go

echo "→ Container-Run"
docker run \
    --rm \
    --name docker-volume-container \
    -v external.vol:/go/bin \
    docker-volume
    # docker-volume 7
