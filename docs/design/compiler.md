# Compiler Design
How are internal core systems of the compiler designed and currently implemented?

See also the [compiler structure](../development/structure.md#compiler-structure).


## Scope System
Identifiers are bound to and only accessible in a specific context called _scope_.

This system performs the following tasks:
- Store symbol names and their visibility
- Find and track redefinitions


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
- **Storage:**
  - `ast.SemanticContext.scopes["LANG.foreign_pkg"]`
  - ScopeObject
    ```bait
    pkg = "foreign_pkg"
    is_pub = true
    ```
- **Content:** consts

#### Package Scopes
- **Purpose:** Store toplevel declarations and their visibility
- **Storage:** `ast.SemanticContext.scopes["full.pkg"]`
- **Content:** static vars, consts, function names, type names

#### File Scope
- **Content:** import aliases

#### Block Scopes
- **Purpose:** Store local symbols
- **Content:** _TODO_


### References
- [GH-246](https://github.com/bait-lang/bait/issues/246)
