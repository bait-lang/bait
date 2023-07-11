# Code Structure
## Compiler
- `cli/bait.bt`: Entry point
  - Calls `preference` to parse arguments and options
  - Initiates launch of external tool for most commands
  - Calls `builder` to compile or run tests
