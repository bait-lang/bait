<!--
Copyright (c) 2023-present Lukas Neubert and contributors (see AUTHORS.md).
This Documentation is subject to the terms of the Mozilla Public License 2.0.
-->
# Bait Documentation
> Documentation of the standard library is :construction:

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

## Types
### Primitive Types
```
bool

string

i8 i16 i32 i64
u8 u16 u32 u64
```

> Floats are not yet implemented

### Numbers
```bait
num := 123
```

By default all integers are of type `i32`.
To get a different type, you can use casting (see [Casting](#casting))

#### Number Promotion
> Not yet implemented

### Casting
To perform type casting you can use `var as Type`:
```bait
n := 123 as i16
```

### Arrays
```bait
names := ['John', 'Max']

mut arr := []i32
arr = [1, 2, 3]

arr.push(0)
arr[3] = 4
```

### Maps
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
    width = 5
    height = 10
}
```

Struct fields might be assigned default values:
```bait
struct Adult {
    name string
    age i32 := 18
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

## Enum
```bait
enum Language {
  english
  german
  french
}

mut lang := Language.french
lang = Language.english
```

If you want to compare a enum value to an integer, you have to do a explicit cast:
```bait
enum Color {
    red
    green
}

if 1 == Color.green as i32 {
}
```

Enum fields may be declared with a custom integer value:
```bait
enum AnsiColor {
    black = 30
    red // 31
    green // 32
}
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

## Assert and Unit Testing
Unit testing is built right into the Bait Compiler with the `test` command.

Test files are recognized by the `_test.bt` suffix and are ignored for normal compilation.
They may contain at least one test function. These are identified by a `test_` name prefix.

Inside the test functions use `assert some_expr` to check wheter this Expr is true.
Failed asserts will result in an error and test failure.

For example a really simple test:
```bt
// my_test.bt

fun sum(a i32, b i32) i32 {
    return a + b
}

fun test_sum() {
    assert sum(1, 2) == 3
}
```

> Test files can right now not be scoped to the package they are in.
> Everything has to be imported.

## Attributes
Various attributes are supported that change the behaviour of functions.
They are written as `@name: 'value'` before the function declaration.

### Deprecation of Functions
Functions can be marked as deprecated to trigger compiler warnings when they are used.
```bait
@deprecated: 'Use bar() instead.'
@deprecated_after: '2023-06-12'
pub fun foo() {}
```

Calling this function will cause a message like:
```
warning: function "foo" will be deprecated after 2023-06-12; Use bar() instead.
```

### List of Attributes
| Name                | Description                                  | Value                  |
| ------------------- | -------------------------------------------- | ---------------------- |
| `@deprecated`       | Marks a function as deprecated.              | Custom message _(opt)_ |
| `@deprecated_after` | Mark as deprecated after a certain date.     | Date _(req)_           |
| `@export`           | Export a function under a different name.    | Name _(req)_           |
| `@overload`         | Use a method to overload the given operator. | Operator _(req)_       |

## Conditional Compilation
### Compile Time Pseudo Variables
Bait supports a few pseudo variables of `string` type.
They are replaced with the actual value during compilation.

| Variable     | Description                         | Example                 |
| ------------ | ----------------------------------- | ----------------------- |
| `$PKG`       | Name of the current package.        | `main`                  |
| `$FILE`      | Relative path of the source file.   | `lib/builtin/file.bt`   |
| `$ABS_FILE`  | Absolute path of the source file.   | `/path/to/file.bt`      |
| `$LINE`      | Line number of it's appearance.     | `123`                   |
| `$FILE_LINE` | Relative path followed by the line. | `tests/my_test.bt:27`   |
| `$FUN`       | Name of the current function.       | `test_read_line`        |
| `$BAITEXE`   | Absolut path to the Bait compiler.  | `/path/to/bait/bait.js` |
| `$BAITDIR`   | Directory where the compiler is in. | `/path/to/bait`         |
| `$BAITHASH`  | Short commit hash of the compiler.  | `5e7fd6e`               |

They are useful for running external tools or debugging. For example:
```bait
eprintln('error in file ${$FILE}, line ${$LINE}, function ${$PKG}.${$FUN}')
```

## Global Variables
While the use of global variables is discouraged, they are important in some cases.

> :construction: In a future version, global variables will require a compiler flag to be enabled.

```bait
global my_global := 123
```

## Calling JavaScript from Bait
### JS Imports and Declarations
It's possible to import JavaScript packages and call JS code from Bait.

```bait
import 'fs' as #JS.fs

fun #JS.fs.existsSync(path #JS.String) #JS.Boolean

fun main() {
    x := #JS.fs.existsSync('hello_world.bt'.str) as bool
    println(x)
}
```

### Embed Raw Code
JS code can be embeded using the `#JS.` prefix and is only allowed in `.js.bt` files.

## Calling Bait from JavaScript
Bait functions can be exported to JS using the export attribute:
```bait
package lib

@export: 'func'
fun some_func() {}
```

In the generated code, this won't change the function name but add the line `module.exports.func = lib__some_func`.
