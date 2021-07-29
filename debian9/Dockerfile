FROM debian:stretch

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev \
    libexpat1-dev \
    libfreetype6-dev \
    libjansson-dev \
    libjpeg-dev \
    libpng-dev \
    libsdl2-2.0-0 \
    libsdl2-dev \
    libsndfile-dev \
    libspeex-dev \
    libspeexdsp-dev \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /ezquake-source
