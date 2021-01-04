#!/bin/bash

host_volume_dir=~/external.vol
host_volume="-v $host_volume_dir:/go/shared"
file=created-externally

action_to_take=$1
no_of_lines_to_create=$2

# Actions
prune () {
    echo "> container prune"
    echo 'y' | docker container prune
    echo "> volume prune"
    echo 'y' | docker volume prune
    echo "> image prune"
    echo 'y' | docker image prune
    echo "> Delete dangling images - alternative"
    docker rmi -f `docker images -q -f dangling=true`
    echo "> Delete external host volume"
    rm -fR $host_volume_dir
}
build () {
    echo "> build container"
    mkdir $host_volume_dir 2>/dev/null
    docker build . -t "docker-volume-image"
    ls -dl $host_volume_dir
    ls -lt $host_volume_dir
}
run () {
    docker run \
        $host_volume \
        docker-volume-image $no_of_lines_to_create
}
view () {
    ls -dl $host_volume_dir
    ls -lt $host_volume_dir
    cat $host_volume_dir/$file
}
build_on_keir () { // build on keir intranet
    echo "> compile on another server"
    export DOCKER_HOST=ssh://keir@192.168.188.222
    echo "> DOCKER_HOST=$DOCKER_HOST"
}
raw_run() {
    echo "> raw run"
    rm $file 2>/dev/null
    ./main.go $no_of_lines_to_create
    ls -lt $file
    cat $file
}
dvmc () { # enter macOS docker VM console
    docker run -it --rm --privileged --pid=host alpine:edge nsenter -t 1 -m -u -n -i sh
}

:<<'COMMENT'
Linux docker managed volume

$ sudo cat  /var/lib/docker/volumes/external.vol/_data/$file

macOS docker managed volume
 
alias dvmc='docker run -it --rm --privileged --pid=host alpine:edge nsenter -t 1 -m -u -n -i sh'
$ dvmc
/ # cat /var/lib/docker/volumes/external.vol/_data/$file 
COMMENT

case "$action_to_take" in
"prune")
    prune
    ;;
"build")
    build
    ;;
"run")
    run
    ;;
"view")
    view
    ;;
"keir")
    build_on_keir
    ;;
"rawrun")
    raw_run
    ;;
"dvmc")
    dvmc
    ;;
*)
    echo -e "\n> Usage: $0 prune | build | run | view | test | rawrun | dvmc\n"
    ;;
esac
