# Check for the containers, if it exists stop it
if [ $(docker ps -a | grep pi | wc -l) = "1" ]; then
    docker rm -f pi
fi

# Check the docker volume if it exists delete it
if [ $(docker volume ls | grep Src | wc -l) = "1" ]; then
    docker volume rm Src
fi
if [ $(docker volume ls | grep Run | wc -l) = "1" ]; then
    docker volume rm Run
fi

# Check the docker image, if it exists delete it
if [ $(docker images rpi:pi3 | grep rpi | wc -l) = "1" ]; then
    docker rmi -f rpi:pi3
fi

if [ $(docker images resin/rpi-raspbian | grep rpi-raspbian | wc -l) = "1" ]; then
    docker rmi -f resin/rpi-raspbian
fi

