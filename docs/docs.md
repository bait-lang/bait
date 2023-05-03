# Bait Documentation
## Comments
```bait
// Line comment
```
> Multiline comments are not yet implemented.

## Functions
```bait
fun main() {
    println(add(30, 12))
}

fun add(a i32, b i32) i32 {
    return a + b
}
```

## Variables
```bait
greeting := 'hello'
num := 17

mut count := 2
count = 3
```

## Constants
```bait
const PI := 3.14
```

## Primitive Types
```
bool

string

i8 i16 i32 i64
u8 u16 u32 u64

f32 f64
```

## Arrays
```bait
names := ['John', 'Max']

mut arr := []i32
arr = [1, 2, 3]

arr.push(0)
arr[3] = 4
```

## Maps
```bait
mut airports := map[string]string
airports['lax'] = 'Los Angeles'

mut arr := []i32
arr = [1, 2, 3]

arr.push(0)
arr[3] = 4
```

<!-- TODO
imports
package decl
control flow
  if
  match
  loops
structs
  methods
type decls
  enums
  alias type (normal, fun)
  sum type
advanced
  JS interop
  compile time vars @BAITEXE, ...
  global vars
 -->
