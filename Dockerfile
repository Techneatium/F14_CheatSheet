FROM registry.hub.docker.com/pandoc/latex:2.14.2-ubuntu

RUN mkdir /source
COPY . /source/.

RUN /source/scripts/install_packages.sh

WORKDIR /source

ENTRYPOINT /bin/bash
CMD []
