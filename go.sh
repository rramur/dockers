# Build the Docker if it doesnt exist
if [ $(docker images ubuntu:go | grep go | wc -l) = "1" ]; then
    echo "Docker image go exist"
else
    docker build --rm -t ubuntu:go .
fi

# Check for the containers, if it exists launch shell 
if [ $(docker ps -a | grep go | wc -l) = "1" ]; then
    docker exec -it go bash
else
    docker run -it --rm -v $PWD/Go-Src:/src --name go ubuntu:go bash
fi

