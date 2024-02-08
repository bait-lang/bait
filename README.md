<img align="left" width=110 src="docs/img/bait-logo.png">

# Bait programming language
[![CI][ci-badge]][gh-actions]
[![Discord][discord-badge]][discord-invite]
---

Simple compiled language for building reliable software.

This repository contains the compiler, cli, standard library and documentation for Bait.

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
- Explicit error handling using Result types
- JavaScript backend (NodeJS, :construction: Web)
- :construction: C backend
- Cross-platform support (Linux, Windows)

## Documentation
> A website, extensive language docs and a documentation generater are in the works.
> The Language specification will be formalized and released during the beta phase.

The [Language Overview](docs/docs.md) provides a brief introduction to the syntax and features.

## Examples
Some basic example programs are in the [examples](examples) directory.

More complex programs can be found in the [Rosetta Code repo][rosetta].

## Installation
Right now Bait has to be compiled from source.
Precompiled binaries will be available in the future.

## Building from source
> Required dependencies: `git` and `NodeJS >= 18`

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


## Contributing
Contributions are always welcome! To get started, please take a look at [CONTRIBUTING.md](./CONTRIBUTING.md).

There is also a [Discord server][discord-invite] to ask questions and discuss the language.

## License
Bait is licensed under the Mozilla Public License (MPL-2.0).
See [LICENSE](./LICENSE.txt) for details.

<!-- links -->
[ci-badge]: https://github.com/bait-lang/bait/actions/workflows/ci.yml/badge.svg?branch=main
[gh-actions]: https://github.com/bait-lang/bait/actions/workflows/ci.yml
[discord-badge]: https://img.shields.io/discord/1204569231992295494?label=Discord
[discord-invite]: https://discord.gg/sM8mspGMnf
[rosetta]: https://github.com/bait-lang/rosetta-bait
