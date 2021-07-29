FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV EZ_CONFIG_FILE=.config_windows
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libspeexdsp-dev \
    mingw-w64 \
    pkg-config \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /ezquake-source
