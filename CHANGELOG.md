# Bait Changelog
All notable changes will be documented in this file.

> Right now Bait is in an Alpha State (`0.0.x`). Breaking changes might occur anytime.


## 0.0.2
_unreleased_

**Additions**
- bait
  - add support for launching external tools
  - add `build` command (it can be omitted)
  - add `run`, `version` and `doctor` commands
  - add `build-examples`, `build-tools`, `check-md`, `test-self` and `test-all` tools
- `build`: add `--script` option to enable script mode, where no main function is required
- add compile time pseudo variables
  - `$PKG`, `$FILE`, `$LINE`, `$FILE_LINE`, `$FUN`, `$BAITEXE`, `$BAITDIR`, `$BAITHASH`
- CI pipeline with some basic checks
- os: new functions
  - `walk_ext(string, string) []string`
  - `cp(string, string)`
  - `chdir(string)`
  - `home_dir() string`
  - `rmdir(string)`, `rmdir_all(string)`
  - `read_lines(string) []string`
  - `executable() string`
  - `getenv(string) string`, `setenv(string, string)`
  - `arch() string`
  - `exec(string) Result`
- new methods:
  - `string.split_lines() []string`
- Really basic documentation
- Issue templates

**Changes**
- move `help`, `self` and `up` into tools
- baitjs generation
  - move logic into `gen-baitjs` tool
  - include branch, hash and commit message from the corresponding bait commit
- `self`: backup the bait.js file


## 0.0.1
_28 April 2023_

- Alpha Release
