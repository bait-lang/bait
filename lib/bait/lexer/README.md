# Lexer
Turns the source code into a sequence of tokens.

## Design
- **Incremental lexing**: Processes and returns one token at a time
- **Comment handling**
  - **discard**: Comments are ignored. The next non-comment token is returned _(default)_
  - **store**: Return comments as tokens, which is useful for various tools
- **Separation of token properties**: Each token has up to three properties (kind, value and position) that are stored separately
- **Reusable**: The state of a instance can be reset to reuse it for another source code

## Usage Example
```bait
import os
import bait.lexer

// Read source code from file
source_code := os.read_file('lexer.bt')

// Create new instance
mut l := lexer.Lexer{}

// Initialize state with source code and comment mode
l.init(source_code, .discard)

// Get token, value and position
tok := l.next()
val := l.val()
pos := l.pos()
```
