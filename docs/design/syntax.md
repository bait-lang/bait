# Syntax design
Why is the syntax the way it is?


## No Block Comments
Bait only supports line comments (`//`) and _no_ block comments (`/* */`).

### Benefits
- **Simpler lexing parsing**: Nested block comments are somewhat complicated
- **Improved Readability**: Line comments are unlikely to disrupt the visual flow of code
- **Code is easily formattable**

### Drawbacks
- Hard to comment larger passages
- Potentially long comment lines

### Mitigation
Modern editors and IDEs support line wrapping and shortcuts for (un)commenting.

### References
- https://futhark-lang.org/blog/2017-10-10-block-comments-are-a-bad-idea.html.


## Casting: `val as Type`
### Benefits
- **Natural logic flow**
  - Flow from left to right, mirroring natural language
  - Consistent with general design _"value before type"_, e.g. function parameters
- **No ambiguity:** Use of the designated keyword `as`
- **Efficient parsing**

### Alternatives considered
- `Type(val)`
  - Confusable with function calls: `Type(val)` vs `func(param)`
  - Problematic parsing without unlimited lookahead, e.g.
    - References `&u8`
    - (nested) Arrays `[][]f64`
  - Harder to type as code has to be inserted before and after the casted value

### References
- [Discord: Thoughts by @zeozeozeo](https://discord.com/channels/1204569231992295494/1204741190432325652/1302526862982905866)
- https://soc.me/languages/type-annotations


## Static Variables
### Benefits
- **No name collision** with symbols in other packages
- **Clear scope** and explicit usage

### Alternatives considered
- Global variables
  - Hard to trace where a variable and value changes come from
  - Unintended coupling of independent code parts

### References
- [GH-249 by @StunxFS](https://github.com/bait-lang/bait/issues/249)


## Function Types
Parameter names of function types must be named, e.g.
```bait
type Fetch := fun (method string, url string) []u8
```

### Benefits
- **Improved Readability**:
  - Purpose of each argument is easier to understand
  - Reduced chance of parameter mix-ups
- **Better tooling support and documentation**

### Alternatives considered
- `type Fetch := fun (string, string) []u8`
