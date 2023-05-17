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

- `gen/js`: JavaScript backend that generates a single JS file for NodeJS.

- `token`: Defines tokens and their precedence.

- `ast`
  - Defines all language constructs as AST nodes.
  - Contains the scope system.
  - Contians code for the type system and the table that is shared between all compiler stages.

- `preference`: Defines all preferences, their default values and the argument parsing.

- `errors`: Handles output and formatting of errors, warnings and notes.

- `util`: Contains minor helper functions (currently for escpaing) and the Bait version.

## Tools
Most commands are implemented as separate tools that will be compiled and executed on demand.
They are located in `cli/tools/`.