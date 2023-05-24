# Bait Changelog
All notable changes will be documented in this file.

> Right now Bait is in an Alpha State (`0.0.x`). Breaking changes might occur anytime.


## 0.0.3
_unreleased_

### Breaking
- Remove `type(var)` cast syntax in favor of `as` casting: `var as Type`
- `$FILE` comptime var now gives the relative path. Use `$ABS_FILE` for the old behaviour
- JS imports are no longer supported

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

### Error Checking
- Prevent redefinition of functions and methods
- Prevent shadowing of imports with variables or function parameters
- Hide noise assign errors after an error for one of the expressions was raised

### JS Interoperability
- Require JS code to be in `.js.bt` files
- Implement JS interfaces to define JS types and methods

### Compiler
- Colorize error messages
- Create a system for annotating functions with attributes
  - Add `@deprecated` and `@deprecated_after`
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
_10 Mai 2023_

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
