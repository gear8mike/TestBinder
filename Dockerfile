FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#SHELL [ "/bin/bash","-c" ]
#set bash as a default shell
ENV SHELL /bin/bash
RUN apt-get update -y && \
    apt-get install wget python3-pip git -y 

#settings for Mybinder
ARG NB_USER=your_user
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

#maybe copy is not necessary
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
ENV PATH=$PATH:${HOME}/.local/bin

#RUN pip3 install --no-cache --upgrade pip && \
#    pip install --no-cache notebook jupyterlab

#ROOT required packages
RUN apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev \ 
    libxpm-dev libxft-dev libxext-dev python libssl-dev -y
#ROOT other packages
RUN apt-get install gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev -y

USER ${NB_USER}

#ROOT installation
ARG ROOT_VERSION="6.24.02"
RUN cd ${HOME} && \
    wget https://root.cern/download/root_v${ROOT_VERSION}.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzvf root_v${ROOT_VERSION}.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -rf root_v${ROOT_VERSION}.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    echo "source ${HOME}/root/bin/thisroot.sh" >> ~/.bashrc
#all pip install packages

RUN pip3 install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab && \
    pip install numpy matplotlib && \
    pip install --no-cache-dir jupyterhub

WORKDIR ${HOME}
#RUN bash
#ENTRYPOINT ["bash","-l"]
