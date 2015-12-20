
<<<<<<< HEAD

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

=======
FROM jupyter/jupyterhub:latest
MAINTAINER cts <chengts95@163.com>
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install python3-matplotlib -y
RUN apt-get build-dep python3-scipy -y
RUN useradd -m "cts" -p "123456" 

RUN pip3 install -U numpy
RUN pip3 install scipy
RUN pip3 install nbgrader
RUN pip3 install ipyparallel

RUN chmod 777 /etc/sudoers
RUN echo "cts ALL=(ALL) ALL">/etc/sudoers
RUN chmod 440 /etc/sudoers
RUN echo "cts:123456" | chpasswd
USER cts
RUN nbgrader extension install --user
USER root
ADD jupyterhub_config.py /srv/jupyterhub/
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
>>>>>>> e48abe4aeaca1423b45e4349a7be002dee51d921
