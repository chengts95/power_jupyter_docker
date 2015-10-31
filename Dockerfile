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
RUN apt-get install libatlas-sse2-dev -y
RUN apt-get install gfortran -y
RUN useradd -m "cts" -p "123456" 
RUN chmod 777 /etc/sudoers
RUN echo "cts ALL=(ALL) ALL">/etc/sudoers
RUN chmod 440 /etc/sudoers
RUN pip3 install -U numpy
RUN pip3 install scipy
RUN pip3 install nbgrader
RUN nbgrader extension install --cts
RUN nbgrader extension activate
RUN pip3 install ipyparallel
RUN echo "cts:123456" | chpasswd
ADD jupyterhub_config.py /srv/jupyterhub/
CMD ["jupyterhub", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
