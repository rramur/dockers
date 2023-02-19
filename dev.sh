#!/bin/bash

get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# Set the Enviroment variables 

if [ -z "$1" ]
  then
    WORK_DIR=$PWD/Dev-Src
  else
    WORK_DIR=$(get_abs_filename $1)
fi


# Build the Docker if it doesnt exist
if [ $(docker images ubuntu:dev | grep dev | wc -l) = "1" ]; then
    echo "Docker image dev exist"
else
    docker build --rm -t ubuntu:dev .
fi

# Check for the containers, if it exists launch shell 
if [ $(docker ps -a | grep dev | wc -l) = "1" ]; then
    docker exec -it dev bash
else
    docker run -it --rm -v $WORK_DIR:/src --name dev ubuntu:dev bash
fi
