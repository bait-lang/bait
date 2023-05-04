# Bait Changelog
All notable changes will be documented in this file.

> Right now Bait is in an Alpha State (`0.0.x`). Breaking changes might occur anytime.


## 0.0.2
_unreleased_

**Additions**
- bait
  - add support for launching external tools
  - add `build` command (it can be omitted)
  - add `version` command
  - add `build-examples`, `build-tools` and `test-all` tools
- compile time variables (`$BAITEXE` and `$BAITROOT`)
- CI pipeline with very basic checks
- os: new functions
  - `cp(string, string)`
  - `chdir(string)`
  - `home_dir() string`
  - `rmdir(string)`, `rmdir_all(string)`
  - `read_lines(string) []string`
  - `executable() string`
  - `getenv(string) string`, `setenv(string, string)`
  - `exec(string) Result`
- Really basic documentation

**Changes**
- move `help`, `self` and `up` into tools
- baitjs generation
  - move logic into `gen-baitjs` tool
  - include branch, hash and commit message from the corresponding bait commit
- `self`: backup the bait.js file


## 0.0.1
_28 April 2023_

- Alpha Release
