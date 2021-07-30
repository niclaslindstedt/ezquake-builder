#!/bin/sh

main() {
  echo "Compiling $DISTROTAG binary to $THISDIR"

  (download_source \
  && extract_source \
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

compile_source() {
  echo "* Compiling source"
  docker run --rm -u "$(id -u):$(id -g)" -v "$SRCDIR:/ezquake-source" "niclaslindstedt/ezquake-builder:$DISTROTAG" make -s -j"$(nproc)" all
}

move_binary() {
  echo "* Moving ezQuake binary to $THISDIR"
  if [ "$DISTROTAG" = "windows" ]; then
    mv "$SRCDIR/ezquake.exe" "$TARGET"
  else
    mv "$SRCDIR/ezquake-linux-"* "$TARGET"
  fi
}

remove_source() {
  echo "* Removing source"
  rm -rf "$SRCDIR" "$ZIPPATH" "$TMPDIR"
}

THISDIR="$(dirname "$(readlink -f "$0")")"
TARGET="${2:-$THISDIR}"
SRCDIR="$THISDIR/.src"
TMPDIR="$THISDIR/.tmp"
ZIPPATH="$THISDIR/src.zip"
DISTROTAG="${1:-ubuntu20.04}"
main
