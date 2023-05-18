# Code Structure
## Compiler
**Entry point** is `cli/bait.bt`. It performs the following tasks:
- Initiates parsing of arguments and options into preferences.
- Launches [external tools](#tools) for most commands.
- Calls the builder for compilation or running tests.

Bait's design is very modular.<br>
The **compiler packages** are located in `lib/bait/`:
- `builder`: Collects all files that need to be compiled and calls the further stages.

- `tokenizer`: Break source code into characters and convert them to tokens.

- `parser`
  - Convert a list of tokens into an AST.
  - Type resolving is limited to constants and globals.

- `checker`
  - Resolve all types and add this information to the AST.
  - Perform type and error checking.

- `gen.js`: JavaScript backend that generates a single JS file for NodeJS.

- `token`: Defines tokens and their precedence.

- `ast`
  - Defines all language constructs as AST nodes.
  - Contains the scope system.
  - Contians code for the type system and the table that is shared between all compiler stages.

- `preference`: Defines all preferences, their default values and the argument parsing.

- `errors`: Handles output and formatting of errors, warnings and notes.

- `util`: Contains minor helper functions (currently for escpaing) and the Bait version.
  - `util.testing`: Provides common functions for running in-out or build tests.

- The `tests/` folder actually is no package but contains [Compiler Tests](#testing).

## Tools
Most commands are implemented as separate tools that will be compiled and executed on demand.
They are located in `cli/tools/`.

## Testing
Located in `lib/bait/tests/` are test files for compiler features to make sure code can compile and has the proper functionality.

### `inout_runner_test.bt`
This test compiler error messages and warnings are actually raised where needed.

It expects pairs of `.in.bt` and `.out` files in the `inout/` directory.
Each in-file will be compiled and the error output is compared to the out file.

In case it's required to run a in-file with the `test` command, name it like `foo_test.in.bt` and `foo_test.out`.
