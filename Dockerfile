FROM registry.hub.docker.com/pandoc/latex:2.14.2-ubuntu

RUN mkdir /source
COPY . /source/.

RUN apt-get update &&\
    apt-get install -y \
        curl \
        git \
        unzip

RUN /source/scripts/install_fonts.sh
RUN /source/scripts/install_packages.sh

WORKDIR /source

ENTRYPOINT /bin/bash
CMD []
