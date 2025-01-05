# Error codes
> [!IMPORTANT]
> This is still work in progress.

All compilation errors have a unique identifier of the following format:
```
X1234
^     Letter for compiler stage throwing the error
 ^^^^ Unique number
```

## Lexer
The lexer uses the prefix `L`.

| UID     | Name                            | Details                                                                   |
| ------- | ------------------------------- | ------------------------------------------------------------------------- |
| `L0001` | Unexpected character            |                                                                           |
| `L0010` | Unclosed string                 |                                                                           |
| `L0020` | Decimal with leading zeros      | Unsignificant leading zeros should be omitted (e.g. `2` instead of `002`) |
| `L0021` | Base prefix without number part | `0b`, `0o` or `0x` that are not followed by a valid number or letter      |
| `L0022` | Float must be decimal           | Floating point numbers cannot have a base prefix                          |
| `L0023` | Invalid number suffix           | Number directly followed by an invalid letter or character (e.g. `12a`)   |
| `L0024` | Trailing decimal point          | Floats should not end with decimal point (e.g. `2.0` instead of `2.`)     |
