# Dockerfile

It will setup the environment for the raspberry pi docker
 - Src directory will contain the socource code to be compiled and it will be accessible to the rpi docker at the directory /src
 - Run directory will cottain the run time data and it will be avialble to the rpi docker at the directory /run

# rpi

This shell script will build and run the rpi container at the first time
At next time the script will launch the shell at next run

# clean_rpi

It will kill the rpi container and remove the rpi image

