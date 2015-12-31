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
    apt-get install -y less net-tools vim-tiny sudo openssh-server oracle-java8-installer

RUN apt-get install -y python3-pip npm nodejs && \
    rm -rf /var/lib/apt/lists/*
