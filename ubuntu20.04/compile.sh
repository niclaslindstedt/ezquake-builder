#!/bin/sh

# This script will compile an ezquake executable for Ubuntu 20.04

main() {
  (download_source \
  && extract_source \
  && fix_permissions \
  && compile_source \
  && move_binary) || echo "Compilation of ezQuake failed."
  remove_source
}

download_source() {
  echo "* Downloading source"
  curl -fsSL -o "$ZIPPATH" https://github.com/ezQuake/ezquake-source/archive/refs/heads/master.zip >/dev/null
}

extract_source() {
  echo "* Extracting source"
  unzip -qq -o "$ZIPPATH" -d "$TMPDIR" \
  && mv "$TMPDIR/ezquake-source-master" "$SRCDIR"
}

fix_permissions() {
  echo "* Preparing source for compilation"
  (cd "$SRCDIR" && find . -iname "*.sh" -exec chmod +x {} \;) \
    || { echo "Cannot prepare source repository"; exit 1; }
}

compile_source() {
  echo "* Compiling source"
  docker run --rm -u "$(id -u):$(id -g)" -v "$SRCDIR:/ezquake-source" "ezquake-builder:$DISTROTAG" make -s -j"$(nproc)" all
}

move_binary() {
  echo "* Moving ezQuake binary to $SCRIPTDIR"
  mv "$SRCDIR/ezquake-linux-"* "$SCRIPTDIR"
}

remove_source() {
  echo "* Removing source"
  rm -rf "$SRCDIR" "$ZIPPATH" "$TMPDIR"
}

SCRIPTDIR="$(dirname "$(readlink -f "$0")")"
SRCDIR="$SCRIPTDIR/.src"
TMPDIR="$SCRIPTDIR/.tmp"
ZIPPATH="$SCRIPTDIR/src.zip"
DISTROTAG="${1:-ubuntu20.04}"
main