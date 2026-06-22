# fnv1a
FNV-1a (Fowler-Noll-Vo) non-cryptographic hash function.
Fast algorithm for use in hashtables and checksums.


## Usage
```bait
import hash.fnv1a

// Hash byte arrays
a := fnv1a.sum32([1, 2, 3, 4])
b := fnv1a.sum64([1, 2, 3, 4])

// Hash strings
c := fnv1a.sum32_string("hello world")
d := fnv1a.sum64_string("hello world")
```
