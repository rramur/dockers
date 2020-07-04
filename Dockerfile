FROM rramur/go-dev:1.13

# Volumes
# Src Code volume
VOLUME [ "/src" ]

ENV GOROOT=/usr/local/go
ENV GOPATH=/src
ENV PATH=$PATH:$GOROOT/bin:$GOPATH

