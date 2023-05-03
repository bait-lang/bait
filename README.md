# Bait Programming Language
Simple compiled language for building reliable software.

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
```sh
git clone https://github.com/tiabeast/bait
cd bait
./make.sh
```

Now you should have Bait compiled to JS at `<path to repo>/bait.js`.

The compiler has to be used like `node ./bait.js examples/hello_world.bt`.

To update Bait to the latest commit, run `node ./bait.js up`.

## License
Bait is licensed under the Mozilla Public License (`MPL-2.0`).
See [LICENSE.txt](./LICENSE.txt) for details.
Copyright is retained by the contributors.
