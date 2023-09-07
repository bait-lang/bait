# Code Structure
## Entry Point
The entry point is `cli/bait.bt:
- Calls `preference` to parse arguments and options
- Initiates launch of external tool for most commands
- Calls `builder` to compile or run tests

## Compiler
Compiler packages are located in `lib/bait/`. The main stages are:
- `builder`: Collect files, resolve imports and run all compilation stages
- `tokenizer`: Break source code into tokens
- `parser`
  - Convert tokens into AST
  - Limited type resolving for constants and globals
- `checker`
  - Resolve all type information
  - Perform error and type checks
- Code generation
  - `gen.js`: JavaScript backend
  - `gen.c`: :construction: C backend

The following packages are also used during compilation:
- `token`: Defines tokens and their precedence
- `ast`
  - Defines all AST nodes
  - Includes the scope system
  - Includes the type system and table with shared type information
- `preference`: Define preferences and argument parsing
- `errors`: Handles formatting of errors and warnings
- `util`: Minor helper function for escaping
  - `util.testing`: Common functions for in-out tests
  - `util.tools`: Function to launch external tools
