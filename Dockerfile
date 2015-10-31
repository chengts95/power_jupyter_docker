# A base docker image that includes juptyerhub and IPython master
#
# Build your own derivative images starting with
#
# FROM jupyter/jupyterhub:latest
#

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
