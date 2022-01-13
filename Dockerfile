#beginig of base image ------------------------------------------------
FROM centos:7.4.1708

RUN yum install -y ant bison flex-devel gcc gcc-c++ gcc-gfortran gdb make cmake glibc-static strace && yum clean -y all
RUN yum install -y autoconf perl-CPAN gettext-devel perl-devel openssl-devel libuuid-devel libcurl-devel expat-devel wget lftp && yum clean -y all

RUN export VER="2.25.1" && \
     wget https://github.com/git/git/archive/v${VER}.tar.gz && \
     tar -xvf v${VER}.tar.gz && \
     rm -f v${VER}.tar.gz && \
     cd git-* && \
     make configure && \
     ./configure --prefix=/usr/local && \
     make -j install && \
     cd .. && \
     rm -rf git-*

RUN yum install -y subversion && yum clean -y all
RUN yum install -y doxygen && yum clean -y all
RUN yum install -y ca-certificates && yum clean -y all

#end of base image ------------------------------------------------------

RUN yum install -y python3-pip.noarch

RUN pip3 install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab
#RUN pip install numpy matplotlib

#RUN pip install jupyter notebook



ARG NB_USER='msmirnov'
ARG NB_UID=90
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --password "" \
    --comment "Default  User" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
#all pip install packages


RUN pip install numpy matplotlib