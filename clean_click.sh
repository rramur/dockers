# Check for the containers, if it exists stop it
if [ $(docker ps -a | grep click | wc -l) = "1" ]; then
    docker rm -f click
fi

# Check the docker volume if it exists delete it
if [ $(docker volume ls | grep Click-Src | wc -l) = "1" ]; then
    docker volume rm Click-Src
fi

# Check the docker image, if it exists delete it
if [ $(docker images ubuntu:click | grep click | wc -l) = "1" ]; then
    docker rmi -f ubuntu:click
fi

# Check for the containers, if it exists stop it
if [ $(docker ps -a | grep client | wc -l) = "1" ]; then
    docker rm -f client
fi

# Check for the containers, if it exists stop it
if [ $(docker ps -a | grep server | wc -l) = "1" ]; then
    docker rm -f server
fi

# Check for the netwroks
if [ $(docker network ls | grep "net-in" | wc -l) = "1" ]; then
   docker network rm net-in
fi

if [ $(docker network ls | grep "net-out" | wc -l) = "1" ]; then
   docker network rm net-out
fi

