# Bait Programming Language
Simple compiled language for building reliable software.

```bait
fun main() {
    println('hello world')
}
```

## Key Features
> **Note** Bait is in an alpha state. Incomplete features are marked with :construction:. Breaking changes may occur.

- Clean and simple syntax that is easy to learn
- :construction: type and memory safety with immutability by default
- JavaScript backend
- :construction: C and native backends
- :construction: cross-platform support and cross-compilation

## Documentation
- [Language Overview](docs/docs.md)

## Building from Source
> Required dependencies: `git` and `NodeJS >= 16`

```sh
git clone https://github.com/tiabeast/bait
cd bait
./make.sh
sudo ./bait symlink
```

Now you should have Bait compiled to JS at `<repo>/bait.js`.

Due to the symlinked wrapper script, the compiler can be used like `bait run examples/hello_world.bt`.

## Upgrading to the latest version
To update Bait to the latest commit, run `bait up`.

## License
Bait is licensed under the Mozilla Public License (`MPL-2.0`).
See [LICENSE.txt](./LICENSE.txt) for details.<br>
Copyright is retained by the contributors.
