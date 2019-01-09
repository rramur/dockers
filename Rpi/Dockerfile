#
# To build run `docker build --rm -t rpi:pi3 .`
# To run docker run -it --rm --name pi rpi:pi3
#

FROM resin/rpi-raspbian

# Update and Upgrade

RUN apt-get update
RUN apt-get -y upgrade

# BUILD DEPENDENCIES:
RUN apt -y install wget
RUN apt -y install make
RUN apt -y install g++
RUN apt -y install vim
RUN apt -y install python
RUN apt -y install iputils-ping

#
# apt install libav-tools
# avconv -i rtsp://admin:admin@192.168.99.2:37777/live/ch00_1 -c copy -map 0 -f segment -segment_time 300 -segment_format mp4 "capture-%03d.mp4"
#

