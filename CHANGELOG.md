# Bait Changelog
All notable changes will be documented in this file.

> Right now Bait is in an Alpha State (`0.0.x`). Breaking changes might occur anytime.


## 0.0.4
_unreleased_

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
- build-examples`, `build-tools`, `check-md`, `test-self` and `test-all` tools
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
