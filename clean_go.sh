# Check for the containers, if it exists stop it
if [ $(docker ps -a | grep go | wc -l) = "1" ]; then
    docker rm -f go
fi

# Check the docker volume if it exists delete it
if [ $(docker volume ls | grep Go-Src | wc -l) = "1" ]; then
    docker volume rm Go-Src
fi

# Check the docker image, if it exists delete it
if [ $(docker images ubuntu:go | grep go | wc -l) = "1" ]; then
    docker rmi -f ubuntu:go
fi
