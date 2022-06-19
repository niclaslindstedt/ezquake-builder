#!/bin/sh

main() {
  echo "Compiling $DISTROTAG binary to $TARGET"

  {
    download_source \
    && extract_source \
    && clean_sources \
    && compile_source \
    && move_binary \
    && remove_source
  } || {
    echo "Compilation of ezQuake failed."
    remove_source
    exit 1
  }
}

download_source() {
  url="https://github.com/ezQuake/ezquake-source/archive/refs/heads/${BRANCH}.zip"
  echo "* Downloading source from $url"
  curl -fsSL -o "$ZIPPATH" "$url" >/dev/null
}

extract_source() {
  echo "* Extracting source"
  unzip -qq -o "$ZIPPATH" -d "$TMPDIR" \
  && mv "$TMPDIR/ezquake-source-master" "$SRCDIR"
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

remove_source() {
  echo "* Removing source"
  rm -rf "$SRCDIR" "$ZIPPATH" "$TMPDIR"
}

THISDIR="$(dirname "$(readlink -f "$0")")"
TARGET="${2:-$THISDIR}"
SRCDIR="$THISDIR/.src"
TMPDIR="$THISDIR/.tmp"
BRANCH="${3:-master}"
ZIPPATH="$THISDIR/src.zip"
DISTROTAG="${1:-ubuntu20.04}"
main
