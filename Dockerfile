# A base docker image that includes juptyerhub and IPython master
#
# Build your own derivative images starting with
#
# FROM daocloud.io/chengts95/jupytertest:latest
#

FROM daocloud.io/chengts95/jupytertest:master-e48abe4
MAINTAINER cts <chengts95@163.com>
USER cts
WORKDIR /home/cts
RUN mkdir assigns
WORKDIR /home/cts/assigns
RUN mkdir source  release  submitted  autograded  feedback
USER root
RUN apt-get install openssh-server -y
EXPOSE 22
RUN service ssh start
RUN nbgrader extension install
RUN mkdir /srv/nbgrader
RUN mkdir /srv/nbgrader/exchange
RUN chmod -R 777 /srv/nbgrader
WORKDIR /srv/jupyterhub/
ADD jupyterhub_config.py /srv/jupyterhub/
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
