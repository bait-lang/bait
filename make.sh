#!/usr/bin/env bash

BAITJS_DIR="$HOME/.bait/baitjs"

# Parse arguments
IS_LOCAL=0
NO_SELF=0

for i in "$@"; do
  case $i in
    --local)
      IS_LOCAL=1
    ;;

    --no-self)
      NO_SELF=1
    ;;
  esac
done

download_baitjs() {
  # Pull or clone baitjs
  if [ -f $BAITJS_DIR/bait.js ]; then
    if [ $IS_LOCAL == 0 ]; then
      git -C $BAITJS_DIR pull --quiet
    fi
  elif [ $IS_LOCAL == 0 ]; then
    git clone --depth 1 https://github.com/bait-lang/baitjs $BAITJS_DIR
  else
    echo "baitjs not found locally. Run without \"--local\""
    exit 1
  fi
}

bootstrap() {
  # Backup bait.js
  [ -f bait.js ] && mv -f bait.js old_bait.js


  # Just compile once (required for implementing breaking changes)
  if [ $NO_SELF == 1 ]; then
    cp $BAITJS_DIR/bait.js . # Required to set correct value for $BAITDIR, etc.
    node bait.js cli/bait.bt -o bait.js
    return
  fi

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

  if [ "$allow_retry" = true ] && [ $IS_LOCAL == 0 ]; then
    # Pull latest version of Bait
    echo "make: compilation failed. Retrying..."
    git pull https://github.com/bait-lang/bait main --quiet

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

  rm -f bait1.js bait2.js
}

download_baitjs
bootstrap
check_success true
cleanup
echo "Run 'sudo ./bait symlink' to add Bait to your path."
