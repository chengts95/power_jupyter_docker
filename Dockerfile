# A base docker image that includes juptyerhub and IPython master
#
# Build your own derivative images starting with
#
# FROM jupyter/jupyterhub:latest
#

FROM jupyter/jupyterhub:latest

MAINTAINER cts <chengts95@163.com>
RUN useradd -m "cts" -p "123456" 
RUN chmod 777 /etc/sudoers
RUN echo "cts ALL=(ALL) ALL">/etc/sudoers
RUN chmod 440 /etc/sudoers
ADD jupyterhub_config.py /srv/jupyterhub/
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
