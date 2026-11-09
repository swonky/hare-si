## Installation

Download the [latest release](https://codeberg.org/swonky/hare-si/releases), or clone the repository and checkout the latest release tag.

```sh
git clone --depth=1 https://codeberg.org/swonky/hare-si.git
cd hare-si
git checkout v0.1.0
```

### Module installation

From the repository directory, run:

```sh
make install-lib
```

Alternatively, copy the `si` directory into your `$HAREPATH`.

## Building the CLI

### Requirements

- Hare v0.26.0 or later [^1]
- GNU Make

Optional dependencies:

- `git` — generates version information in `./si/version.ha`.
- `pandoc` — generates the man page (`./docs/si.1`).
- Python 3.12+ — generates Markdown module documentation.

Clone the repository and build:

```sh
git clone --depth=1 https://codeberg.org/swonky/hare-si.git
cd hare-si

make check   # Run tests
make         # Build executable
make install # Install executable and module
```

Run `make help` for available targets and configuration options:

```text
Targets:
  all                  Build everything (default)
  check                Run test suite
  build                Build executable and documentation
  completions          Generate embedded shell completions
  install              Install all components
  install-bin          Install executable
  install-lib          Install Hare module
  install-docs         Install man page
  install-completions  Install shell completions
  uninstall            Remove installed components
  clean                Remove generated build artifacts

Variables:
  PREFIX               Installation prefix (default: /usr/local)
  DESTDIR              Staging directory
  HARESRCDIR           Hare source directory
  BASH_DIR             Bash completion directory
  ZSH_DIR              Zsh completion directory
```

Shell completions are installed only when their respective directory variables (`BASH_DIR` or `ZSH_DIR`) are specified.

## Cleaning

Remove generated build artifacts:

```sh
make clean
```

## References

[^1]: Hare toolchain: [v0.26.0 source tarball](https://git.sr.ht/~sircmpwn/hare/archive/0.26.0.tar.gz) · [Repository](https://git.sr.ht/~sircmpwn/hare) · [Homepage](https://harelang.org/)
