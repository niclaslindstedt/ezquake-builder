#!/bin/sh

# This script will compile an ezquake executable for Ubuntu 20.04

if [ -d "$1" ]; then
  echo "* Pulling latest ezquake source"
  (cd "$1" && git pull) || { echo "Cannot pull latest ezquake source"; exit 1; }
else
  echo "* Cloning ezquake source repository"
  (mkdir -p "$1" && cd "$1" && git clone git@github.com:ezQuake/ezquake-source.git) \
    || { echo "Cannot clone ezquake source repository"; exit 1; }
fi

echo "* Preparing source for compilation"
(cd "$1" && find . -iname "*.sh" -exec chmod +x {} \;) \
  || { echo "Cannot prepare source repository"; exit 1; }

docker run --rm -v "$1:/ezquake-source" "ezquake-builder:ubuntu20.04" make -j"$(nproc)" clean
docker run --rm -v "$1:/ezquake-source" "ezquake-builder:ubuntu20.04" make -j"$(nproc)" all ezquake-builder:ubuntu20.04

# -u "$(id -u):$(id -g)"
