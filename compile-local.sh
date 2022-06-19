#!/bin/sh

main() {
  echo "Compiling $DISTROTAG binary to $TARGET"

  (clean_sources \
  && compile_source \
  && move_binary) || echo "Compilation of ezQuake failed."
}

clean_sources() {
  echo "* Cleaning sources"
  find $SRCDIR -iname "*.sh" -exec dos2unix {} \;
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


THISDIR="$(dirname "$(readlink -f "$0")")"
TARGET="${3:-$THISDIR}"
SRCDIR="$(readlink -f "${1:-$THISDIR}")"
TMPDIR="$THISDIR/.tmp"
ZIPPATH="$THISDIR/src.zip"
DISTROTAG="${2:-ubuntu20.04}"

echo $SRCDIR

main
