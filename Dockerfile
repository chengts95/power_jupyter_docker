# A base docker image that includes juptyerhub and IPython master
#
# Build your own derivative images starting with
#
# FROM jupyter/jupyterhub:latest
#

FROM jupyter/jupyterhub:latest

MAINTAINER cts <chengts95@163.com>
RUN echo "root:123456" | chpasswd 
ADD jupyterhub_config.py /srv/jupyterhub/
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
