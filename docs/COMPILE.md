# Compilation

## Requirements

**Required**
- Hare v0.26.0 or later [^1]
- GNU Make

**Optional**
- `git` — generates version information in `./si/version.ha`
- `scdoc` — generates the `./docs/si.1` man page [^2]
- `groff` and `col` — generate the plain-text `./docs/si.1.txt` man page

## Building

Display options

```sh
make help
```

Build the executable and generate available documentation:

```sh
make
```

Install all components:

```sh
make install PREFIX="/usr/local"
```

Or, install individual components:

```sh
make install-bin
make install-lib
make install-docs
make install-completions \
    BASH_DIR="$HOME/.local/share/bash-completion/completions" \
    ZSH_DIR="$HOME/.local/share/zsh/site-functions"
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
