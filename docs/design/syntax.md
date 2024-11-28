# Syntax design
Why is the syntax the way it is?


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
- [soc.me: `ident: Type` over `Type ident`](https://soc.me/languages/type-annotations)
