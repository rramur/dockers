FROM rramur/ubuntu-dev:bionic 

# Volumes
# Src Code volume
VOLUME [ "/src" ]

RUN mkdir /src
WORKDIR /src
RUN git clone https://github.com/kohler/click.git
WORKDIR /src/click
RUN ./configure
RUN make install
RUN ./userlevel/click ./conf/test.click

