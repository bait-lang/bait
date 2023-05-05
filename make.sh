BAITJS_DIR="$HOME/.bait/baitjs"

if [ -f $BAITJS_DIR/bait.js ]; then
    git -C $BAITJS_DIR pull
else
   git clone --depth 1 https://github.com/tiabeast/baitjs $BAITJS_DIR
fi

rm -f bait.js

node $BAITJS_DIR/bait.js cli/bait.bt -o bait1.js
node bait1.js cli/bait.bt -o bait2.js
node bait2.js self --no-backup

if [ ! -f bait.js ]; then
    echo "make: compilation failed"
    exit 1
fi

if [ $(wc -l bait.js | awk '{print $1}') -le 1000 ]; then
    echo "bait.js is too small. Something went wrong."
    exit 1
fi

rm bait1.js bait2.js

echo "Run it with 'node bait.js'"
