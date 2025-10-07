#!/bin/bash
# Copyright (C) 2023 Alexander Wolz <mail@alexanderwolz.de>

if [ "$#" -eq 0 ]; then
    echo "missing parameters"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PARENT_DIR="$(dirname $SCRIPT_DIR)"
IMAGE_NAME="angular_builder"

docker ps -q >/dev/null 2>&1 # check if docker is running
if [ "$?" -ne 0 ]; then
    echo "Docker engine is not running!"
    exit 1
fi

docker image ls | grep $IMAGE_NAME > /dev/null
if [ "$?" -ne 0 ]; then
    docker build $SCRIPT_DIR -t $IMAGE_NAME
fi

CMD=$@

if [ $1 = "bash" ]; then
    echo "executing bash into container"
    CMD="bash"
elif [ $1 = "npm" ]; then
    echo "using npm"
    CMD="$@"
else
    echo "just executing angular cli"
    CMD="ng $@"
fi

docker ps | grep $IMAGE_NAME > /dev/null
if [ "$?" -eq 0 ]; then
    docker exec -it $IMAGE_NAME $CMD 
else
    docker run --rm --name $IMAGE_NAME -it -p 4200:4200 -v $PWD:/app:rw -v ~/.gitconfig:/home/angular/.gitconfig:ro -h $IMAGE_NAME $IMAGE_NAME $CMD
fi

