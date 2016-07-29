FROM ubuntu:16.04

MAINTAINER cts <chengts95@163.com>
# Upgrade package index
# install a few other useful packages plus Oracle Jdk 8
# Remove unneeded /var/lib/apt/lists/* after install to reduce the
# docker image size (by ~30MB)
USER root
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu/ xenial main" > /etc/apt/sources.list.d/java.list && \
    echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y build-essential less net-tools vim-tiny sudo openssh-server oracle-java8-installer pkg-config libfreetype6-dev libpng-dev && \
    apt-get install -y python3-pip && \
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    apt-get install -y nodejs-legacy npm && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*
    
RUN pip3 install tornado jupyter jupyterhub && \
    npm install -g configurable-http-proxy && \
    pip3 install numpy scipy ipyparallel matplotlib
RUN useradd -m "cts" -p "123456" && \
    chmod 777 /etc/sudoers && \
    echo "cts ALL=(ALL) ALL">/etc/sudoers && \
    chmod 440 /etc/sudoers && \
    echo "cts:123456" | chpasswd && \
    mkdir /home/cts/jupyterhub

ADD jupyterhub_config.py /home/cts/jupyterhub/
WORKDIR /home/cts/jupyterhub/
EXPOSE 8000
EXPOSE 8888
CMD ["jupyterhub", "-f", "/home/cts/jupyterhub/jupyterhub_config.py"]
