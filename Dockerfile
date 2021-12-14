FROM fedora:33

RUN dnf install python -y 

#RUN pip install numpy matplotlib

#RUN pip install jupyter notebook

#RUN pip install markdown-kernel
RUN pip install --no-cache-dir notebook

RUN pip install --no-cache-dir jupyterhub

ARG NB_USER=msmirnov
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}