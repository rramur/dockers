# Build the Docker if it doesnt exist
if [ $(docker images rpi:pi3 | grep pi3 | wc -l) = "1" ]; then
    echo "Docker image rpi:pi3 exist"
else
    docker build --rm -t rpi:pi3 .
fi

# Check for the containers, if it exists launch shell 
if [ $(docker ps -a | grep pi | wc -l) = "1" ]; then
    docker exec -it pi bash
else
    docker run -it --rm -v $PWD/Src:/src -v $PWD/Run:/run --name pi rpi:pi3 bash
fi
