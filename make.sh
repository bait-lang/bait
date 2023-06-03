#!/usr/bin/env bash

BAITJS_DIR="$HOME/.bait/baitjs"
IS_LOCAL=0; [ "$1" == "--local" ] && IS_LOCAL=1

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

rm -f bait.js

# Compile new bait.js and ensure self compilation is working
node $BAITJS_DIR/bait.js cli/bait.bt -o bait1.js
node bait1.js cli/bait.bt -o bait2.js
node bait2.js self --no-backup

if [ ! -f bait.js ]; then
    echo "make: compilation failed"
    exit 1
fi

# Sanity check the file size
if [ $(wc -l bait.js | awk '{print $1}') -le 1000 ]; then
    echo "bait.js is too small. Something went wrong."
    exit 1
fi

rm bait1.js bait2.js

echo "Run it with './bait'"
