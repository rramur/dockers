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
    docker run -it --rm -v $PWD/Dev-Src:/src --name click ubuntu:dev bash
fi
