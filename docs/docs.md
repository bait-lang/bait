<!--
SPDX-FileCopyrightText: 2023-present Lukas Neubert <lukas.neubert@proton.me>
SPDX-License-Identifier: MIT
-->

# Bait Documentation
> Documentation of the standard library is work in progress 🚧

## Entry Point
The entry point of any program is the `main` function. It is automatically called when the program starts.
```bait
fun main() {
	println('hello world')
}
```

## Functions
```bait
fun add(a i32, b i32) i32 {
    return a + b
}
```

The return type can be omitted, if the function returns nothing.
```bait
fun print_monday() {
    println('monday')
}
```

### Deprecation of Functions
Functions can be marked as deprecated to trigger compiler warnings when they are used.
```bait
@deprecated('Use bar() instead.')
@deprecated_after('2023-06-12')
pub fun foo() {}
```

Calling this function will cause a message like:
```
warning: function "foo" will be deprecated after 2023-06-12; Use bar() instead.
```


## Variables
Variables are declared with the `:=` operator.
```bait
greeting := 'hello'
num := 17
```

By default variables are immutable. Use the `mut` keyword if their value has to change.
```bait
mut count := 2
count = 3
```

## Constants
Constants can only be in the top level scope and are declared with the `const` keyword.
```bait
const ANSWER := 42
```


## Comments
Use `//` to start a comment.
```bait
// Line comment
x := true // Inline comment
```

> Unlike many other languages, Bait does not support block comments
> (see [syntax design](./design/syntax.md#no-block-comments)).


## Types
### Primitive Types
```
bool

string

i8 i16 i32 i64
u8 u16 u32 u64

f32 f64
```

### Numbers
```bait
num := 123
```

By default all integers are of type `i32` and all floats of type `f64`.
To get a different type, you can use casting (see [Casting](#casting))

#### Base Prefixes
It's also possible to define numbers with a different base by using a prefix:
| Name        | Base | Prefix |
| ----------- | ---- | ------ |
| Binary      | 2    | `0b`   |
| Octal       | 8    | `0o`   |
| Hexadecimal | 16   | `0x`   |

```bait
b := 0b1010
o := 0o755
h := 0x12a
```

#### Number Promotion
> Not yet implemented

### Casting
To perform type casting you can use `var as Type`:
```bait
n := 123 as i16
```

### Arrays
An array is a zero-indexed list of values of the same type.

```bait
names := ['John', 'Max']

mut arr := []i32
arr = [1, 2, 3]

arr.push(0)
arr[3] = 4
```

#### Array Initialization
The array type is inferred from the first element:
```bait
enum MyEnum {
    A
    B
}

arr := [MyEnum.A, .B]
```

It's also possible to preallocate an array with a fixed length:
```bait
a := []i32{ length = 3 }
```

#### Array Slicing (Range Indexing)
```bait
nums := [0, 10, 20, 30]

println(nums[1..3]) // [10, 20]
println(nums[..3]) // [0, 10, 20]
println(nums[2..]) // [20, 30]
println(nums[..]) // [0, 10, 20, 30]
```


### Maps
You can initialize a map with the short literal syntax:
```bait
grades := map{
    'Alice': 92
    'Bob': 87
    'Charlie': 95
}
```

Or create an empty map and assign values later:
```bait
mut airports := map[string]string
airports['lax'] = 'Los Angeles'
airports['jfk'] = 'New York'
```

### Result Type
Result types are used for functions that possibly return an error.
They are declared by prpending `!` to the type name: `!Type`.

For more information see [Error Handling](#error-handling).


## Error Handling
### Propagation
```bait
fun get_res() ! {
    return error('failure')
}

fun other() ! {
    get_res()!
}
```

### Stop Execution
```bait
fun get_res() ! {
    return error('failure')
}

fun stop_on_error() {
    get_res() or {
        exit(1)
    }
}
```

### Provide a default value
```bait
fun int_or_fail() !i32 {
    return error('no num')
}

fun main() {
    num := int_or_fail() or { 42 }
}
```


## Importing packages
Packages are imported using the `import` keyword.
All public symbols can be accessed using the package name as prefix:

```bait
import os

fun main(){
    // Call `read_file` using the `os.` prefix
    t := os.read_file('myfile.txt')
}
```

Please note that imports are on a per-file basis.

Selective imports of specific symbols are _not_ supported.


### Subpackages
For subpackages only the last part of the name is used as prefix:
```bait
import term.color

fun main(){
    r := color.bold("hello")
}
```

This is regardless of the nesting depth,
so a function from `foo.bar.baz` would be called like `baz.func()`.


### Import aliasing
Any imported package can be aliased using the `as` keyword.
This is commonly used to avoid name conflicts.

```xbait
import hash.crc32
import custom.crc32 as mycrc32
```


## Package Declaration
```bait
package my_pkg
```


## Symbol Visibility
By default all symbols are private to the package they are declared in.
This includes [functions](#functions), [constants](#constants), [structs](#structs) and [enums](#enums).

To allow other packages to use a symbol, prepend the `pub` keyword:
```bait
package my_pkg

pub fun my_public_function() {}

fun my_private_function() {}
```

For type aliases the visibility is derived from the underlying type:
```bait
package other_pkg

type MyInt := i32 // MyInt is usable in other packages

pub struct PubStruct {}
type PubAlias := PubStruct // PubAlias is public just like PubStruct

struct PrivStruct {}
type PrivAlias := PrivStruct // PrivAlias is private
```

## If
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

## Match
```bait
day := 0
match day {
  5 { println('Saturday') }
  6 { println('Sunday') }
  else { println('Not weekend') }
}
```

## For Loops
### `for`/`in`
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

### Conditional for
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

### Classic for
```bait
for i := 0; i < 10; i += 1 {
    println(i)
}
```

### Labelled `break` and `continue`
By default `break` and `continue` affect the innermost loop.<br>
To break or continue an outer loop, you can use labels:

```bait
outer: for i := 0; i < 5; i += 1 {
    for j := 0; j < 5; j += 1 {
        if i == 2 {
            break outer
        }
        if j == 2 {
            continue outer
        }
        println(j)
    }
}
```

The above code will print:
```
0
1
0
1
```

## Structs
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

### Access Modifiers
By default struct fields are private and immutable. The access modifiers for each field can be changed using the following options:
```bait
pub struct Foo{
	a i32 // private immutable (default)
	mut b i32 // private mutable
    pub c i32 // public readonly
	pub mut d i32 // public readonly but mutable in the parent package
	global e i32 // mutable by other packages
}
```

### Required Fields
```bait
struct FooBar {
    @required a i32
    b i32
    @required
    c i32
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
    black := 30
    red // 31
    green // 32
}
```

## Type Declarations
### Type Alias
```bait
type NewType := ExistingType
```


### Function Type
Type aliases can also name a specific function signature:

```bait
type CheckInt := fun (i32) bool

// You can use the alias like any other type, for example as parameter
fun check_nums(nums []i32, c CheckInt) {
    for n in nums {
        c(n)
    }
}

// This implicitly matches the signature of `CheckInt`
fun greater_two(n i32) bool {
    return n > 2
}

// You can use `greater_two` everywhere, where `CheckInt` is expected
check_nums([2,3,4], greater_two)
```

Also take a look at the [complete example](../examples/function_types.bt).


### Sum Type
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

### Execute a Function before and after all Test Cases
There are two special functions `testsuite_begin()` and `testsuite_end()`, that can run code before/after all test cases.

This is for example useful to create and clean up temporary directories.


## Attributes
Various attributes are supported that change the behaviour of functions, struct fields and other statements.
They are defined with `@name` or `@name('value')` before the statement they should apply to.

### List of all supported Attributes
**Apply to functions:**
| Name                | Description                                  | Value                  |
| ------------------- | -------------------------------------------- | ---------------------- |
| `@deprecated`       | Marks a function as deprecated.              | Custom message _(opt)_ |
| `@deprecated_after` | Mark as deprecated after a certain date.     | Date _(req)_           |
| `@export`           | Export a function under a different name.    | Name _(req)_           |
| `@overload`         | Use a method to overload the given operator. | Operator _(req)_       |

**Apply to struct fields:**
| Name        | Description                                 | Value |
| ----------- | ------------------------------------------- | ----- |
| `@required` | The field must be initialized with a value. | -     |

**Apply to package declaration:**
| Name               | Description                                 | Value |
| ------------------ | ------------------------------------------- | ----- |
| `@silent_mismatch` | Suppress the package mismatch info message. | -     |


## Compile Time Code Evaluation (Comptime)
### Compile Time Pseudo Variables
Bait supports a few pseudo variables, which are replaced by their actual values during compilation.
They are all of the type `string`.

| Variable     | Description                       | Example                 |
| ------------ | --------------------------------- | ----------------------- |
| `$PKG`       | Current package name              | `main`                  |
| `$ABS_FILE`  | Absolute file path                | `/path/to/lib/file.bt`  |
| `$FILE`      | File path relative to working dir | `lib/file.bt`           |
| `$DIR`       | Absolute path to file's directory | `/path/to/lib`          |
| `$LINE`      | Line number of the variable       | `123`                   |
| `$FILE_LINE` | Relative path and the line        | `tests/my_test.bt:27`   |
| `$FUN`       | Current function name             | `test_read_line`        |
| `$BAITEXE`   | Absolut path to the Bait compiler | `/path/to/bait/bait.js` |
| `$BAITDIR`   | Directory of the compiler         | `/path/to/bait`         |
| `$BAITHASH`  | The compiler's short commit hash  | `5e7fd6e`               |

They are useful for running external tools or debugging. For example:
```bait
eprintln('error in file ${$FILE}, line ${$LINE}, function ${$PKG}.${$FUN}')
```

### Conditional Compilation
```bait
$if C {
    println('hi from c backend')
} $else {
    println('hi from non-c backend')
}
```

> [!IMPORTANT]
> Infix and prefix operations are not yet implemented for compile time ifs.
> Support for combining conditions using `and`, `or` and `not` will be added in a future version.

The following conditions are currently supported:
| Backend   | Operating System   |
| --------- | ------------------ |
| `C`, `JS` | `LINUX`, `WINDOWS` |


## Static Variables
While Bait has no support for global variables, you can use static package variables for a similar purpose.

```bait
static my_static_var := 123
```

They are public and mutable from everywhere:
```bait
import bait.test_pkgs.demo

demo.shared_var += 7
println(demo.shared_var) // 130
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

@export('func')
fun some_func() {}
```

In the generated code, this won't change the function name but add the line `module.exports.func = lib__some_func`.


## Appendix A: Keywords
Bait has 29 reserved keywords:
```
and
as
assert
break
const
continue
else
enum
false
for
fun
global
if
import
in
interface
is
match
mut
not
or
package
pub
return
static
struct
true
type
typeof
```


## Appendix B: Operators
| Operator | Description           | Applicable Types          |
| -------- | --------------------- | ------------------------- |
| `+`      | addition              | integers, floats, strings |
| `-`      | subtraction           | integers, floats          |
| `*`      | multiplication        | integers, floats          |
| `/`      | division              | integers, floats          |
| `%`      | remainder / modulo    | integers                  |
|          |                       |                           |
| `~`      | bitwise NOT           | integers                  |
| `&`      | bitwise AND           | integers                  |
| `\|`     | bitwise OR            | integers                  |
| `^`      | bitwise XOR           | integers                  |
| `<<`     | left shift            | integers                  |
| `>>`     | right shift           | integers                  |
|          |                       |                           |
| `not`    | logical NOT           | bools                     |
| `and`    | logical AND           | bools                     |
| `or`     | logical OR            | bools                     |
|          |                       |                           |
| `==`     | equals                | all                       |
| `!=`     | not equals            | all                       |
| `<`      | less than             | integers, floats          |
| `<=`     | less than or equal    | integers, floats          |
| `>`      | greater than          | integers, floats          |
| `>=`     | greater than or equal | integers, floats          |

Assignment operators:
```
:=  =
+=  -=
*=  /=  %=
```

### Precedence
Highest to lowest:
- `not`
- `* / % & << >>`
- `+ - | ^`
- `== != < <= > >=`
- `as is`
- `and or`
