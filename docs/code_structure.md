# Code Structure
## Compiler
- `cli/bait.bt`: Entry point
  - Calls `preference` to parse arguments and options
  - Launch external tools for most commands
  - Calls `builder` to compile or run tests
