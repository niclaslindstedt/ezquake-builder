FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    git \
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
    libspeexdsp-dev

WORKDIR /ezquake-source
