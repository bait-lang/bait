# Bait Changelog
All notable changes are documented in this file.

> Bait is currently in an Alpha State (`0.0.x`). Breaking changes may occur at any time.


## 0.0.7
_unreleased_

### Breaking
- Change operator for pointer dereferencing from `^` to `*`
- `strings.Builder`: Replace `write_chars(data []u8)` with `write_u8(c u8)`
- `os`: Rename struct `Result` to `CmdRes`
- `builtin`:
  - Remove `u8.is_capital()`
    - Use `u8.is_upper()` instead
  - Rename `last_index(val)` to `index_last(val)` (affects string and array)
- Remove `cli.cmdline`
  - `parse_string()` was moved into `cli`
  - `options()` was replaced by the `cli.options` package

### New Language Features
- Implement Result type (e.g. `fun foo() !<type> {}`)
- Add `or {}` block for error handling (e.g. `foo() or { println(err) }`)
- Add `!` operator for error propagation (e.g. `foo()!`)
- Support number prefixes for different bases
  - binary (e.g. `0b1001`)
  - octal (e.g. `0o123`)
  - hex (e.g. `0x12a`)
- Add bitwise operators (`~`, `&`, `|`, `^`, `<<`, `>>`)
- Implement basic conditional compilation with `$if {} $else {}`
- _[JS]_ Add `testsuite_begin()` and `testsuite_end()` functions
- _[JS]_ Implement generic structs

### Error Checks
- Fixes and improvements regarding error positions
- Disallow leading zeros in decimal numbers
- Prevent invalid number suffixes
- MatchExpr
  - Require match to be exhaustive
  - Prevent duplicate branch conditions
  - Warn if else branch is unreachable
- Prevent redefinition of types (enum, interface, struct, type alias)
- Lexer: Add unqiue error codes

### Type Checks
- Ensure function parameter type exists
- Fix existence check for array element types
- Raise error if array type cannot be inferred
- Properly check return type of `array.last()`
- Improve integer type check to infer type in e.g. array inits `[1 as u8, 2, 3]`
- Fix inferance of wrong type for if/match expr inside another if

### Generics
- checker:
  - Fix type checking for nested generic function calls
  - Fix passing generic params as arg to another generic function
- gen:
  - `typeof(G)` now prints the concrete type
  - Fix escaping of imported types in generic function calls

### JS Backend
- Improve performance of string comparison

### C Backend
- Experimental generics support
- Minimal windows support (`os` package won't work)
- builder: Fixes for using the C backend on windows
- gen: Implement `assert`, `break` `continue`, `enum`, `global` and compile time variables
- Fix compiling libraries
- Fix string interpolation C error with tcc
- Fix C error when calling a method on a mutable array instance

### Standard Library
- Add new package `encoding.binary`
- Add new package `cli.options`
- Add work in progress `math` package
- `builtin`
  - Add new string method: `index_after(search, pos) i32`
  - _[C]_ Implement string methods:
    - `all_before`, `all_before_last`, `all_after`, `all_after_last`
    - `index`, `last_index`, `contains`
    - `starts_with`, `ends_with`
    - `trim_left`, `trim_right`
    - `replace`, `substr`, `repeat`
  - _[C]_ Implement array method `contains`
  - _JS backend_
    - New array method `delete()`
    - New u8 methods: `is_lower()`, `is_upper()`, `is_digit()`, `is_hex_digit()`, `is_bin_digit()`
    - New `[]u8` method: `to_string()`
- `os`:
  - New function `read_bytes(path) []u8`
  - _[JS]_ New function `is_root(path) bool`
  - _[C]_ Implement functions for Linux:
    - `read_file`, `write_file`
    - `ls`, `walk_ext`
    - `file_name`, `dir`
    - `is_dir`, `join_path`, `platform`
    - `exec`, `system`

### CLI and Tooling
- `init`
  - Add `--template` option to allow choosing a template
  - Add `bin` and `lib` templates
  - Prevent overwriting existing files
- `build`: Add `-cc` option to use a custom C compiler
- `self`: Use $BAITEXE as default out name

### Other Changes
- _[JS]_ Fix integer division assign that could result in a float
- gen:
  - Fix `!=` when `==` is overloaded
- parser:
  - Fix hangs on unexpected eof
  - Fix duplication of warnings
  - Fix typeless array inits used as call arg
- lexer:
  - Fix position of multiline strings
  - Unclosed string error now points to the opening quote
  - Prevent rare crash due to huge sequences of comments overflowing the call stack


## 0.0.6
_26 December 2023_

### Breaking
- `strings.Builder`: Rename some methods
  - `write()` to `write_chars()`
  - `write_str()` to `write()`
- Remove the tool `test-lib`
  - All standard library tests can be run with `bait test lib`
  - Compiler tests can be run with `bait test tests`
  - Tool tests can be run with `bait test cli/tools`

### Generics
- Check that concrete types for each generic type match
- Generate concrete functions on both backends
- Fix invalid error that a generic type is private
- Fix string conversion of generic types

### Package and Import System
- Import resolving order: Search for imports next to the importer first
- Significantly improve performance of import resolving
- Show builder error when
  - Imported package does not exist
  - No files belong to a imported package
  - Compiled directory is empty

### Error and Type Checks
- If conditions must be of type bool
- Prevent assigning from a void function call
- Prevent selecting fields of unsupported types (e.g. enums)
- Prevent some cases of identifier redefinition
  - Any identifier by a function name
  - Function argument by a variable
- Show an error if `break` or `continue` are not inside a loop
- Prevent invalid prefix exprs
  - `-` on non-numeric types
  - `not` on non-bool types
- Respect return type of overloaded methods
- Reduce noisy errors in the following cases
  - Assign to undefined ident
  - Method call on undefined ident
  - Use of unknown struct field in infix
  - Assign from unknown function or method

### Language Interoperability
- _[JS]_ Implement native strings `js'my str'`
- _[JS]_ Add support for declaring structs, methods, enums and type aliases
- _[JS]_ Various fixes related to interfaces

### Pointers
- Add pointer dereferencing: `^my_ptr`
- Fix `typeof()` for pointers

### CLI and Tooling
- Add `init` tool to setup new projects
- `up`: Fix make on windows
- Add option `--timings` to show time needed for all compiler stages
- `tests/output_test.bt`: Add `--fix` option
- `gen-baitjs`
  - Remove from builtin tools as it's designed for CI only
  - Various fixes related to breaking compiler changes

### Testing
- builder: Fix testing a directory with multiple test files
- `bait.util.testing`
  - BuildRunner
    - New field `oks` to check number of successful runs
    - `build_all_in_root()`: Add support for directories
    - Add new field `targets` and enum `BuildTarget` to specify what to build (default is all)
  - InOutRunner
    - Add `fix_out_file` field to overwrite out files with the actual output
    - Output tests work on windows now (internal path and line break normalization)
    - Fix checking stderr of a directory
    - Handle skips for lib tests

### Standard Library
- Add work in progress `time` package
- Add work in progress `cli` package
- Add `bait.util.timers` to aid with performance measurements
- builtin:
  - New string method `is_capital() bool`
  - New map methods `values() []any` and `clear()`
  - Implement array methods `index()` and `last_index()` on C backend too
- os:
  - Add `input(prompt) string` function _[JS]_
  - Add `exists_dir(path)` that checks if path exists and is a directory _[JS]_
  - Fix js error with `mkdir()` and `mkdir_all()` if path already exists
- strings: JS implementation of the string builder

### General Fixes
- `parser`: Fix precedence of PrefixExpr
- `checker`
  - Fix scope of smartcasted if conditions
  - Fix error for methods defined on an array of a user defined type
  - Fix error if a method shares a name with a function defined before
- `gen.js`: Fix possible crash by escaping reserved JS keywords in the `for ... in` loop

### Other Changes
- Implement real `if` and `match` expressions
- Add attribute `@noreturn`
- _[JS]_ Add support for float literals
- Support struct fields of function type that are callable like methods
- Move compiler tests from `lib/bait/tests/` into `tests/`
- Complete tokenizer rewrite and rename to `lexer`
- Many refactorings, cleanups and performance enhancements
- Documentation improvements


## 0.0.5
_27 August 2023_

### Breaking
- Interfaces: Methods must not be prefixed with `fun`. Just use `method_name(...) ...`
- `bait run`: Delete executable afterwards. Use option `--keep` for old behaviour

### Windows Support
- Initial support for Windows with the JS backend, including:
  - Bootstrapping with `make.bat`
  - Symlinking
  - setup-bait GitHub Action
  - Many adjustments in lib, the compiler and tooling

### JS Backend
- Very limited and minimal generics
- Results of integer math operations are properly floored
- Support type definition for JS constants

### Standard Library
- builtin:
  - New string methods `split(delim)`, `trim_left(cutset)`, `trim_right(cutset)` _[JS backend]_
  - New array method `last()`
- `os`
  - Add `PATH_SEP` constant
  - Implement `ARGS` for C backend
  - Add function `user_args()` that returns only the arguments passed by the user
  - `dir()`: Fix trailing slashes
  - `exec()`: Fix handling of quoted arguments with whitespace
- New package `cli.cmdline` containing functions for low level command line parsing

### CLI and Tooling
- `up`, `self`: Make tools independent of working directory
- `run`:
  - Add `--keep` flag to not delete the executable after running
  - Arguments after `--` are passed to the executable
- `make.sh`: Add `--no-self` flag to compile Bait exactly one time
- `build-examples`:
  - Fix exit code on error for the C backend
  - Do not build both backends by default but respect the `--backend` option
- `self`: Respect `--out` value in success message

### Other Changes
- Check mutability of all fields in nested selector expressions
- Prevent crash with cyclic imports
- Fix executable name if compiling directories `.` or `..`
- Parser:
  - Fix crash if a fun call closing parenthesis is missing
  - Do not get stuck due to a unexpected token inside interface declaration
- C: Codegen for string interpolation
- `bait.util.testing`: Various fixes to the inout runner


## 0.0.4
_16 July 2023_

### Breaking
- Replace struct init syntax `Struct{ field: value }` with `Struct{ field = value }`

### CLI and Tooling
- Add `--library` option to build as shared library that not requires a main function
- Add `-w` and `-W` to hide warnings or turn them into errors
- `self`: Pass other options to build command
- `ast`: Add `--tokens` option to only print the tokens
- `make.sh`: Improve error robustness

### Type System
- Check types of literal map init
- Allow typeless array inits based on context

### Immutability by Default
- Implement struct field access modifiers `mut`, `pub`, `pub mut` and `global`
- Enforce immutability and privacy of struct fields
- Enforce default immutability of variables and parameters
- Support parsing of mutable method receivers, function parameters and for-in-loop variables
- Add error when assigning to a field of a immutable struct
- Error if a method that requires a mutable receiver is called on a immutable variable

### Error Checking
- Enums
  - Cannot be declared empty
  - Prevent duplicate enum variants
- Structs
  - Prevent duplicate field names
  - Sum type fields must be initialized
- Packages and Imports
  - Compiling a folder must include a file with `package main`
  - Main package must contain a main function
  - Error if a imported package contains no Bait files
  - Fix false-positive error with variable names matching an import of an import
- Many fixes and improvements regarding symbol visibility
- Prevent assigning to non-identifiers
- Fix variable redefinition error not being thrown

### Compiler
- Struct Declarations
  - Support default field values
  - Attribute support for fields and add `@required`
- Enum fields can have default values
- Add labelled `break` and `continue`
- Arrays can be preallocated with a given length
- Implement `@export: 'jsname'` that will generate `module.exports.jsname = fun`
- Fix printing type aliased values
- Parser: Fix infinite loop with statements during script mode main function
- Builder: Do not include files in a imported directory with unexpected package name

### Testing
- `bait.util.testing`
  - Add inout runner for project directories
  - Add inout runner to check stdout
  - Allow passing an array of elements to skip

### Standard Library
- `os`
  - Add `user_os()` function
  - Fix `cp()` for directories
- builtin: New `toI32()` string method
- _[C]_ Add `strings` package containing a simple string builder

### C Backend (experimental)
- Properly implement backend selection
- Limited code generation (enough for hello world and fizzbuzz)


## 0.0.3
_30 May 2023_

### Breaking
- Remove `type(var)` cast syntax in favor of `as` casting: `var as Type`
- `$FILE` comptime var now gives the relative path. Use `$ABS_FILE` for the old behaviour

### CLI and Tooling
- Add `symlink` command that will link a helper bash script which executes bait with NodeJS
- `up`: Actually print newest version after update
- `self`, `build-xxx`: Always show stderr output
- Rename `test-self` to `test-lib`
- `gen-baitjs`: Logging improvements and fix escaping bugs
- `build`: Add `--nocolor` option to disable colorized output
- Add `--verbose` option and verbose output for launching tools
- Script mode is enabled implicitly but will cause a warning

### Type System
- Infix types must match
- Match branch exprs must be of the same type as the condition
- Check types of return values
- All array init elements must be of the same type
- `as` cast: check the target type exists
- Improve type resolving of constants
- Implement enum access without specifying the name if the type is already known
- Infer struct init default value of type alias from parent type
- Fix `typeof()`
- Type check arguments of calls to special builtin array methods

### Error Checking
- Prevent redefinition of functions and methods
- Prevent shadowing of imports with variables or function parameters
- Hide noise assign errors after an error for one of the expressions was raised

### JS Interoperability
- Require JS code to be in `.js.bt` files
- Implement JS interfaces to define JS types and methods
- Imports have to follow the scheme `import 'package' as #JS.alias`
- JS functions have to be declared with their type signature

### Compiler
- Colorize error messages
- Create a system for annotating functions with attributes
  - Add `@deprecated` and `@deprecated_after`
- Implement limited method overloading using `@overload: '<operator>'`
- Fix enum type struct fields not being initialized with 0
- Fix escaping of
  - Double quotes in strings
  - Backticks in interpolated strings
  - Double quotes in char literals
- Name of the compiled file now defaults to the source name

### Testing
- `assert`
  - Fix runtime error if non-infix asserts fail
  - Fix missing assert details on fail if left side is a empty string
  - Prevent asserting exprs that do not evaluate to a bool
  - Handle more exprs in fail messages
- Add an error if a test file contains no test functions
- Add lot's of new unit tests for lib and the compiler

### Standard Library
- builtin:
  - New `string` methods:
    - `all_before()`, `all_before_last()`
    - `all_after()`, `all_after_last()`
  - New `array` methods:
    - `copy()`
    - `index()`, `last_index()`
    - `reverse()`, `reverse_in_place()`
- `os`:
  - New functions `file_mod_time()`, `rm()`, `symlink()`
  - `exec()`: Fix missing output of stderr without execution errors

### Other Changes
- Add `$ABS_FILE` compile time variable
- Improve and expand the documentation
- `make.sh`: add `--local` flag that skips pulling the last commit
- Various refactorings


## 0.0.2
_10 May 2023_

### Breaking Changes
- Remove `testing` package
- Replace `testing.assert()` with builtin `assert` keyword
- Move `bait.prefs` to `bait.preference`

### Compiler CLI and Tooling
- `build` command (it can be omitted)
- `run`, `version` and `doctor` commands
- move `help`, `self` and `up` into tools
- `build-examples`, `build-tools`, `check-md`, `test-self` and `test-all` tools
- `build`: add `--script` option to enable script mode, where no main function is required
- `self`: backup the bait.js file

### Standard Library
- new functions
  - builtin: `panic()`
  - os: `walk_ext()`, `cp()`, `chdir()`, `home_dir()`, `rmdir()`,
    `rmdir_all()`, `read_lines()`, `executable()`, `getenv()`, `setenv()`,
    `arch()`, `exec()`
- new methods: `string.split_lines()`

### Documentation
- Syntax overview as starting point for writing the docs
- GitHub: issue templates

### Other Changes
- Improve output of failed asserts (file, line, function, got and expected)
- add compile time pseudo variables
  - `$PKG`, `$FILE`, `$LINE`, `$FILE_LINE`, `$FUN`, `$BAITEXE`, `$BAITDIR`, `$BAITHASH`
- CI pipeline with some basic checks
- baitjs generation
  - move logic into `gen-baitjs` tool
  - include branch, hash and commit message from the corresponding bait commit
- Refactor preference parsing and error printing


## 0.0.1
_28 April 2023_

- Alpha Release
