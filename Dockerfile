FROM centos:centos6
MAINTAINER Tru Huynh <tru@pasteur.fr>

# uncomment for local mirror:
#RUN /bin/rm /etc/yum.repos.d/CentOS-*.repo 
#ADD https://gitlab.pasteur.fr/tru/centos-pasteur/raw/master/c6.repo  /etc/yum.repos.d/local.repo

RUN yum -y update
RUN yum -y install wget tar gzip \
                   perl \
                   which findutils zip unzip zlib-devel \
                   java-1.8.0-openjdk-devel \
                   git
RUN yum -y install centos-release-scl-rh

# uncomment for local mirror:
#RUN /bin/rm /etc/yum.repos.d/CentOS-*.repo 
#ADD https://gitlab.pasteur.fr/tru/centos-pasteur/raw/master/c6-scl-rh.repo /etc/yum.repos.d/scl-rh.repo 

RUN yum -y install devtoolset-3-gcc devtoolset-3-gcc-c++ devtoolset-3-binutils \
                   python27-numpy python27-python-devel python27-python-wheel python27-python-pip
RUN yum -y install https://people.centos.org/tru/bazel-centos6/bazel-0.4.5-1.c6.x86_64.rpm

ADD https://github.com/tensorflow/tensorflow/archive/v1.0.1.tar.gz /tmp/tensorflow-1.0.1.tar.gz

RUN mkdir /build && tar -C build -xzf /tmp/tensorflow-1.0.1.tar.gz && /bin/rm /tmp/tensorflow-1.0.1.tar.gz

ADD https://raw.githubusercontent.com/truatpasteurdotfr/docker-centos6-tensorflow/master/tf-c6.ans /tmp/tf-c6.ans
ADD https://raw.githubusercontent.com/truatpasteurdotfr/docker-centos6-tensorflow/master/runme.sh  /tmp/runme.sh
RUN cat /tmp/runme.sh | scl enable devtoolset-3 python27 bash
