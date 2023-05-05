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
const ANSWER := 42
```

## Primitive Types
```
bool

string

i8 i16 i32 i64
u8 u16 u32 u64
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

## Package Imports
```bait
import os

fun main(){
    text := os.read_file('myfile.txt')
}
```

## Package Declaration
```bait
package my_pkg
```

## Statements
### If
```bait
a := 5
b := 10
if a > b {
    println('a is greater than b')
} else if a < b {
    println('a is less than b')
} else {
    println('a equals b')
}
```

### Match
```bait
day := 0
match day {
  5 { println('Saturday') }
  6 { println('Sunday') }
  else { println('Not weekend') }
}
```

### For Loops
#### `for`/`in`
```bait
arr := [1, 2, 3]
for x in arr {
  println(x)
}

mut mymap := map[string]string
mymap['a'] = 'A'
mymap['b'] = 'B'

for key, val in mymap {
}
```

#### Conditional for
```bait
mut i := 100
for i >= 0 {
    if i % 2 == 0 {
        continue
    }
    println(i)
    i -= 1
}

for true {
    break
}
```

#### Classic for
```bait
for i := 0; i < 10; i += 1 {
    println(i)
}
```

## Struct
```bait
struct Rect{
    width i32
    height i32
}

r := Rect{
    width: 5
    height: 10
}
```

### Methods
```bait
struct Rect{
    width i32
    height i32
}

fun (r Rect) area() i32 {
  return r.width * r.height
}
```

## Enums
```bait
enum Language {
  english
  german
  french
}

mut lang := Language.french
lang = Language.english
```

## Type Declarations
### Type Alias
```bait
type NewType := ExistingType
```

### SumType
```bait
struct Triangle{}

struct Rectangle{}

struct Circle{}

type Shape := Triangle | Rectangle | Circle
```

## Conditional Compilation
### Compile Time Pseudo Variables
Bait supports a few pseudo variables of `string` type.
They are replaced with the actual value during compilation.

| Variable     | Description                         | Example                 |
| ------------ | ----------------------------------- | ----------------------- |
| `$PKG`       | Name of the current package.        | `main`                  |
| `$FILE`      | Absolute path of the source file.   | `/path/to/file.bt`      |
| `$LINE`      | Line number of it's appearance.     | `123`                   |
| `$FILE_LINE` | Relative path followed by the line. | `tests/my_test.bt:27`   |
| `$FUN`       | Name of the current function.       | `test_read_line`        |
| `$BAITEXE`   | Absolut path to the Bait compiler.  | `/path/to/bait/bait.js` |
| `$BAITDIR`   | Directory where the compiler is in. | `/path/to/bait`         |
| `$BAIT_HASH` | Short commit hash of the compiler.  | `5e7fd6e`               |

They are useful for running external tools or debugging. For example:
```bait
eprintln('error in file ${$FILE}, line ${$LINE}, function ${$PKG}.${$FUN})
```

<!-- TODO
advanced
  JS interop
  global vars
-->
