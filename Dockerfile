FROM debian:stable-slim

RUN apt-get update
#RUN apt-get install dnf -y
RUN apt-get install python3 pip -y 

#RUN pip install numpy matplotlib

#RUN pip install jupyter notebook



ARG NB_USER = msmirnov
ARG NB_UID = 1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
# Make sure the contents of our repo are in ${HOME}
#COPY . ${HOME}
#USER root
#RUN chown -R ${NB_UID} ${HOME}
#USER ${NB_USER}
#all pip install packages
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab
#RUN pip install markdown-kernel