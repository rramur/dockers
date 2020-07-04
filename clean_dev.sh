# Check for the containers, if it exists stop it
if [ $(docker ps -a | grep dev | wc -l) = "1" ]; then
    docker rm -f dev
fi

# Check the docker volume if it exists delete it
if [ $(docker volume ls | grep Dev-Src | wc -l) = "1" ]; then
    docker volume rm Dev-Src
fi

# Check the docker image, if it exists delete it
if [ $(docker images ubuntu:dev | grep dev | wc -l) = "1" ]; then
    docker rmi -f ubuntu:dev
fi
