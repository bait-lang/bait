# Compiler Design
How are core systems of the compiler designed and currently implemented?

See also the [compiler structure](../development/structure.md#compiler-structure).


## Scope System
Identifiers are bound to and only accessible in a specific context called _scope_.

### Hierarchy
```mermaid
graph TD
  F{{FFI}}
  P{{pkg 1}}
  P2{{pkg 2..n}}
  B1("file 1")
  B1_2("file 2..n")
  C["fun 1 (block)"]
  C2["fun 2..n"]

  P --> B1
  P --> B1_2
  P2 --> B2(...)
  B1 --> C
  B1_2 --> B4[...]
  B1 --> C2
  C --> E["for / if / ... (block)"]
  E --> E3[...]
  C --> E2[...]
  C2 --> B3[...]
```

### Scopes
#### Foreign Functions Interface (FFI)
- **Purpose:** Store all C / JS declarations depending on the used backend
- **Storage:** `table.Table.ffi_scope &ast.Scope`
- **Contents:** consts
- **Relevant ScopeObject fields**
  ```bait
  name = "LANG.import.decl_name"
  is_pub = true
  ```

#### Package Scopes
- **Purpose:** Store toplevel declarations and their visibility
- **Storage:** `table.Table.scopes map["full.pkg"]&ast.Scope`
- **Contents:** globals, consts

### References
- [GH-246](https://github.com/bait-lang/bait/issues/246)