FROM ubuntu:bionic

MAINTAINER "Brad Ito" brad@retina.ai

RUN apt-get update \
  && apt-get install -y apt-utils \
  && apt-get upgrade -y

# avoid interactive stops to installers
ENV DEBIAN_FRONTEND=noninteractive

# system package installation for use with databricks
# https://docs.databricks.com/user-guide/clusters/custom-containers.html
# fuse - for dbfs support
# openssh-server - for ssh support into cluster
RUN apt-get update \
  && apt-get install --yes \
    openjdk-8-jdk \
    bash \
    iproute2 \
    coreutils \
    procps \
    sudo \
    fuse \
    openssh-server

# cleanup
RUN apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*