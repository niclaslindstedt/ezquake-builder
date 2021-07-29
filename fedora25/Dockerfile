FROM fedora:25

RUN dnf update -y \
  && dnf install -y \
    pcre-devel \
    mesa-libGL-devel \
    SDL2-devel \
    make \
    gcc \
    jansson-devel \
    expat-devel \
    libcurl-devel \
    libpng-devel \
    libjpeg-turbo-devel \
    speex-devel \
    speexdsp-devel \
    freetype-devel \
    libXxf86vm-devel
ENV OLD_WAV_LOADING=1
WORKDIR /ezquake-source
