FROM rramur/ubuntu-dev:bionic 

# Volumes
# Src Code volume
# VOLUME [ "/src" ]

RUN wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
RUN tar -xvf go1.13.3.linux-amd64.tar.gz
RUN mv go /usr/local
RUN export GOROOT=/usr/local/go

