# Bait Programming Language
Simple compiled language for building reliable software.

This repository contains the compiler, standard library and documentation for Bait.

```bait
fun main() {
    println('hello world')
}
```

## Key Features
> **Note** Bait is in an alpha state. Incomplete features are marked with :construction:. Breaking changes may occur.

- Clean, simple and consistent syntax
- Type and memory safety with immutability by default
- JavaScript backend (NodeJS)
- Cross-platform support
- :construction: C backend

## Documentation
- [Language Overview](docs/docs.md)
- [Examples](examples) and [Rosetta Code](https://github.com/tiabeast/rosetta-bait)

## Installation
Right now Bait has to be compiled from source.
Precompiled binaries will be available in the future.

> Required dependencies: `git` and `NodeJS >= 16`

Linux:
```sh
git clone https://github.com/tiabeast/bait
cd bait
./make.sh
sudo ./bait symlink
```

Windows:
```powershell
git clone https://github.com/tiabeast/bait
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
Bait is licensed under the Mozilla Public License (`MPL-2.0`).
See [LICENSE.txt](./LICENSE.txt) for details.<br>
Copyright is retained by the contributors.
