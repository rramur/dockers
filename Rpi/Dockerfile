#
# To build run `docker build --rm -t rpi:pi3 .`
# To run docker run -it --rm --name pi rpi:pi3
#

FROM resin/rpi-raspbian as rpi

# Volumes
# Src Code volume
VOLUME [ "/src" ]
# Run time data vloume
VOLUME [ "/run" ]


# Update and Upgrade

RUN apt-get update
RUN apt-get -y upgrade

# BUILD DEPENDENCIES:
RUN apt -y install iputils-ping
RUN apt -y install net-tools
RUN apt -y install wget
RUN apt -y install make
RUN apt -y install g++
RUN apt -y install vim
RUN apt -y install python3
RUN apt -y install lighthttpd

