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
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# Download the installer
RUN \curl -O -k https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
RUN \curl -O -k https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc

# Verify the installer signature (might need `gpg2`), and if it validates...
RUN gpg --verify rvm-installer.asc

# Run the installer
RUN bash rvm-installer stable
RUN rvm install 2.3.0
RUN \rvm use 2.3.0 --default
RUN \gem install chef-zero
RUN wget --no-check-certificate https://packages.chef.io/stable/ubuntu/12.04/chefdk_0.11.2-1_amd64.deb
RUN dpkg -i chefdk_0.11.2-1_amd64.deb
