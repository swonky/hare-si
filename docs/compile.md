# Compilation

## Requirements

**Required**

- Hare v0.26.0 or later [^1]
- GNU Make

**Optional**

- `git` — generates version information in `./si/version.ha`.
- `pandoc` — generates the `./docs/si.1` man page [^2].
- `python 3.12+` — generates the markdown module documentation.

## Building

Clone this repository and build from source:

```sh
git clone --depth=1 https://codeberg.org/swonky/hare-si.git
cd hare-git

make check   # run tests
make         # build executable
make install # install binary and module
```

For more options, run `make help`:

```sh
make help

Usage: make [target] [VARIABLE=value]

Targets:
all                 Build everything
(default)
check               Run test suite
build               Build executable and documentation
completions         Generate embedded shell completions
install             Install all components
install-bin         Install executable
install-lib         Install Hare module
install-docs        Install man page
install-completions Install shell completions
uninstall           Remove installed components
clean               Remove generated build artifacts

Variables:
PREFIX              Installation prefix
(default:           /usr/local)
DESTDIR             Staging directory
HARESRCDIR          Hare source directory
BASH_DIR            Bash completion directory
ZSH_DIR             Zsh completion directory
```

Both `BASH_DIR` and `ZSH_DIR` are optional. Completion scripts are installed only when its respective target directory is explicitly specified.

## Cleaning

Remove generated build artifacts:

```sh
make clean
```

## References

[^1]: Hare toolchain: [v0.26.0 source tarball](https://git.sr.ht/~sircmpwn/hare/archive/0.26.0.tar.gz) · [Repository](https://git.sr.ht/~sircmpwn/hare) · [Homepage](https://harelang.org/)

[^2]: scdoc: [Repository](https://git.sr.ht/~sircmpwn/scdoc)
