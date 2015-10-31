# A base docker image that includes juptyerhub and IPython master
#
# Build your own derivative images starting with
#
# FROM daocloud.io/chengts95/jupytertest:latest
#

FROM daocloud.io/chengts95/jupytertest:latest
MAINTAINER cts <chengts95@163.com>
USER cts
RUN nbgrader extension install
WORKDIR /home/cts
RUN mkdir assigns
WORKDIR /home/cts/assigns
RUN mkdir source  release  submitted  autograded  feedback
USER root
RUN mkdir /srv/nbgrader
RUN mkdir /srv/nbgrader/exchange
RUN chmod -R 777 /srv/nbgrader
ADD jupyterhub_config.py /srv/jupyterhub/
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
