# Builds a Docker image with Ubuntu 16.04 and PDF Studio Viewer 12
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

ARG PDFSTUDIO_VER=12.0.0
ADD image/ /usr/share/applications/

RUN /bin/bash -c 'curl -O https://download.qoppa.com/pdfstudioviewer/v12/PDFStudioViewer_v${PDFSTUDIO_VER//\./_}_linux64.deb && \
    dpkg -i PDFStudioViewer_v${PDFSTUDIO_VER//\./_}_linux64.deb' && \
    \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $DOCKER_USER
RUN echo '@/opt/pdfstudioviewer12/pdfstudioviewer12' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart

USER root
WORKDIR $DOCKER_HOME
