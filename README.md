<img align="left" width=110 src="docs/img/bait-logo.png">

# Bait Programming Language
---

Simple compiled language for building reliable software.

This repository contains the compiler, standard library and documentation for Bait.

```bait
fun main() {
    println('hello world')
}
```

## Key Features
> **Note:** Bait is under heavy development. Incomplete features are marked with :construction:.
> While it is quite stable already, breaking changes might happen.

- Clean, simple and consistent syntax
- Type and memory safety with immutability by default
- JavaScript backend (NodeJS, :construction: Web)
- :construction: C backend
- Cross-platform support (Linux, Windows)

## Documentation
- [Language Overview](docs/docs.md)
- [Examples](examples) and [Rosetta Code](https://github.com/bait-lang/rosetta-bait)

## Installation
Right now Bait has to be compiled from source.
Precompiled binaries will be available in the future.

> Required dependencies: `git` and `NodeJS >= 16`

Linux:
```sh
git clone https://github.com/bait-lang/bait
cd bait
./make.sh
sudo ./bait symlink
```

Windows:
```powershell
git clone https://github.com/bait-lang/bait
cd bait
./make.bat

# In admin shell:
./bait.bat symlink
```

Now you should have Bait compiled to JS at `<repo>/bait.js`.

Due to the symlinked wrapper script, the compiler can be used like `bait run examples/hello_world.bt`.

### Upgrading to the latest version
To update Bait to the latest commit, run `bait up`.

## License
Bait is licensed under the Mozilla Public License (MPL-2.0).
See [LICENSE](./LICENSE.txt) for details.
