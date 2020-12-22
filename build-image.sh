#!/usr/bin/bash

export DOCKER_HOST=ssh://keir@192.168.188.222
echo "→ DOCKER_HOST=$DOCKER_HOST"

echo "→ Delete dangling images"
docker image prune

echo "→ Delete dangling images - alternative"
docker rmi -f `docker images -q -f dangling=true`

echo "→ Build an image from a Dockerfile"
echo "→ Usage:  docker build [OPTIONS] PATH | URL | -"
docker build . -t "hello-uncle"

echo "→ Run"
echo "→ Raw-Run"
NAME=Andreas ./main.go

echo "→ Container-Run"
docker run hello-uncle
docker run -e NAME=Andreas hello-uncle
