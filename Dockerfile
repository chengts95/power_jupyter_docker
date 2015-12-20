

FROM ubuntu:16.04

MAINTAINER cts <chengts95@163.com>
# Upgrade package index
# install a few other useful packages plus Open Jdk 7
# Remove unneeded /var/lib/apt/lists/* after install to reduce the
# docker image size (by ~30MB)

RUN sudo add-apt-repository ppa:webupd8team/java &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu/ precise main" > /etc/apt/sources.list.d/java.list && \
    echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y less net-tools vim-tiny sudo openssh-server oracle-java8-installer&& \
    rm -rf /var/lib/apt/lists/*

