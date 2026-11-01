# Compilation

Requires
 - Hare v0.26
 - GNU Make
 - scdoc (optional)
 - groff (optional)

Build the executable:
```sh
make
```

Install the cli utility, hare module, and man page:
```sh
PREFIX=/usr/local make install
```

or, install components separately:
```sh
make install-docs
make install-bin
make install-lib
```


