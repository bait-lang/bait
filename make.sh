if [ -f baitjs/bait.js ]; then
    git -C baitjs pull
else
   git clone --depth 1 https://github.com/tiabeast/baitjs baitjs
fi

node baitjs/bait.js cli/bait.bt -o bait1.js
node bait1.js cli/bait.bt -o bait2.js
node bait2.js self

if [ $(wc -l bait.js | awk '{print $1}') -le 1000 ]; then
    echo "bait.js is too small. Something went wrong."
    exit 1
fi

rm bait1.js bait2.js

echo "bait.js has been successfully built. Run it with 'node bait.js'"
