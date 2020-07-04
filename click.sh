# Build the Docker if it doesnt exist
if [ $(docker images ubuntu:click | grep click | wc -l) = "1" ]; then
    echo "Docker image click exist"
else
    docker build --rm -t ubuntu:click .
fi

#Check for the container networks

if [ $(docker network ls | grep "net-in" | wc -l) = "1" ]; then
   echo "Network: Net-in"
else
   docker network create net-in
fi

docker network inspect net-in | grep "\"Subnet\":"

if [ $(docker network ls | grep "net-out" | wc -l) = "1" ]; then
   echo "Network: Net-out"
else
   docker network create net-out
fi

docker network inspect met-out | grep "\"Subnet\":"


# Check for the containers, if it exists launch shell 
if [ $(docker ps -a | grep click | wc -l) = "1" ]; then
    docker exec -it click bash
else
    # Create the click container
    docker create --name click -v $PWD/Click-Src:/mysrc --cap-add=ALL --privileged -it --rm ubuntu:click bash
    docker network connect net-in click
    docker network connect net-out click
    docker start click 

    # Create the Client
    docker create --name client --cap-add=ALL --privileged -it --rm rramur/ubuntu-dev:bionic bash
    docker network connect net-in client
    docker start client

    # Create the Server
    docker create --name server --cap-add=ALL --privileged -it --rm rramur/ubuntu-dev:bionic bash
    docker network connect net-out server
    docker start server

    echo "To get client docker exec -it client bash"
    echo "To get server docker exec -it server bash"
    echo "To Run http server python -m SimpleHTTPServer 80"

    # Start Click
    docker exec -it click bash
    
fi
