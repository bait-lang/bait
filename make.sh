#!/usr/bin/env bash

BAITJS_DIR="$HOME/.bait/baitjs"
IS_LOCAL=0; [ "$1" == "--local" ] && IS_LOCAL=1

download_baitjs() {
  # Pull or clone baitjs
  if [ -f $BAITJS_DIR/bait.js ]; then
    if [ $IS_LOCAL == 0 ]; then
      git -C $BAITJS_DIR pull --quiet
    fi
  elif [ $IS_LOCAL == 0 ]; then
    git clone --depth 1 https://github.com/tiabeast/baitjs $BAITJS_DIR
  else
    echo "baitjs not found locally. Run without \"--local\""
    exit 1
  fi
}

bootstrap() {
  # Backup bait.js
  [ -f bait.js ] && mv -f bait.js old_bait.js

  # Compile new bait.js and ensure self compilation is working
  node $BAITJS_DIR/bait.js cli/bait.bt -o bait1.js
  node bait1.js cli/bait.bt -o bait2.js
  node bait2.js self -o bait.js
}

check_success() {
  allow_retry=$1

  if [ -f bait.js ]; then
    return
  fi

  if [ "$allow_retry" = true ]; then
    # Pull latest version of Bait
    echo "make: compilation failed. Retrying..."
    git pull --quiet

    # Retry bootstrapping
    bootstrap
    check_success false
    return
  fi

  echo "make: compilation failed"
  exit 1
}

cleanup() {
  # Sanity check the file size
  if [ $(wc -l bait.js | awk '{print $1}') -le 5000 ]; then
    echo "bait.js is too small. Something went wrong."
    exit 1
  fi

  rm bait1.js bait2.js
}

download_baitjs
bootstrap
check_success true
cleanup
echo "Run it with './bait'"
