# Build the Docker if it doesnt exist
if [ $(docker images ubuntu:click | grep click | wc -l) = "1" ]; then
    echo "Docker image click exist"
else
    docker build --rm -t ubuntu:click .
fi

# Check for the containers, if it exists launch shell 
if [ $(docker ps -a | grep click | wc -l) = "1" ]; then
    docker exec -it click bash
else
    docker run -it --rm -v $PWD/Click-Src:/mysrc --name click ubuntu:click bash
fi
