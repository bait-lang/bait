# Maintenance Guide
This document outlines some maintenance processes and tasks.

## Fix broken bootstrapping
The CI contains jobs to ensure bootstrapping works.
In case it was broken anyways, e.g. due to a prematurely merged PR, follow these steps:

1. `baitjs`: Revert the bad commit
   ```sh
   cd ~/.bait/baitjs
   git revert HEAD --no-edit
   git push
   ```
2. `bait`: Fix the bad commit _OR_ revert it
3. `bait`: Get a working compiler
   ```sh
   ./make.sh --local
   ```
4. Test the bootstrapping with an extra pass
   ```sh
   bait self -o b.js
   node b.js self -o b2.js
   node b2.js self -o bait.js
   ```
