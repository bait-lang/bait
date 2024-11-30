# Structure
See also the [design of core compiler systems](../design/compiler.md).


## Repository Structure
```
├─ cli/       Compiler CLI, tools and help texts
├─ docs/      Documentation files
   ├─ design/   Design of language syntax and compiler core systems
   ├─ dev/      Contribution flow and high-level code structure
   └─ .         User documentation
├─ lib/       Root for all standard library packages
   ├─ bait/     Core compiler implementation
   └─ ...
├─ tests/     Tests for general language features
└─ ...
```


## Compiler Structure
The compiler consists of the following core packages that are all in the `bait` namespace:

- `ast`: Defines AST nodes, the scope system and the type system
- `builder`: Collect files, resolve imports and run all compilation stages
- `checker`:
  - Resolve all type information
  - Perfrom error and type checks
- Code Generation
  - `gen.c`: C backend (🚧)
  - `gen.js`: JavaScript backend
- `lexer`: Break source code into tokens
- `parser`: Create the AST and perform basic type resolving for constants and globals
- `preference`: Define preferences and argument parsing
- `token`: Defines tokens and their precedence
- `transformer`: Perform some optimizations on the AST

Other packages include:

- `errors`: Data structures for compiler messages and their printing
- Utilities
  - `util.escape`: Helpers to escape charaters in strings
  - `util.testing`: Common logic for in-out tests
  - `util.timers`: Helpers to measure performance of compiler stages
  - `util.tools`: Logic to launch tools in `cli/tools/`
