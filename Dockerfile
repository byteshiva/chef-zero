FROM ubuntu:latest
MAINTAINER byteshiva <byteshiva@gmail.com>

# Set locale to avoid apt-get warnings in OSX
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LC_ALL C
ENV LC_ALL en_US.UTF-8

# Install chef and its prerequisites
# NOTE: libgecode-dev required by dep-selector-libgecode in berfshelf
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      curl \
      git \
      wget \
      build-essential \
      libxml2-dev \
      libxslt-dev && \
    apt-get install -y --no-install-recommends libgecode-dev && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
RUN apt-get install ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
