# Builds a Docker image with Ubuntu 16.04 and PDF Studio 12
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

ARG PDFSTUDIO_VER=12.0.0
ADD image/ /usr/share/applications/

RUN /bin/bash -c 'curl -O https://download.qoppa.com/pdfstudio/v12/PDFStudio_v${PDFSTUDIO_VER//\./_}_linux64.deb && \
    dpkg -i PDFStudio_v${PDFSTUDIO_VER//\./_}_linux64.deb' && \
    \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $DOCKER_USER
RUN echo '@/opt/pdfstudio12/pdfstudio12' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart

USER root
WORKDIR $DOCKER_HOME
