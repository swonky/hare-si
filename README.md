# hare-si

> WARNING: hare-si is currently unstable and under active development.
> Breaking changes and incomplete functionality should be expected.

A Hare module and command-line utility for parsing, converting, formatting, and
performing arithmetic with physical quantities expressed using the International
System of Units (SI).

Implemented in Hare, with no external library dependencies.

All files distributed as part of this project are licensed under the Mozilla
Public License 2.0 ([MPL-2.0](https://spdx.org/licenses/MPL-2.0.html)).

## Features

- Supports all SI symbols including all metric prefixes, base units, derived
  units, and additional selected non-SI units.
- Extensive library of predefined units, dimensions, and constants.
- Permissive parsing of quantities from ASCII and UTF-8 strings.
- String formatting of quantities with configurable units, precision, numeric
  notation, and symbol encoding.
- Unit conversion and arithmetic operations between dimensionally compatible
  units.
- Supports JSON serialisation.

## Usage

- [Installation](./docs/compile.md)
- [Module documentation](./docs/module.md)
- [CLI manpage](./docs/manpage.md)
- [License](./COPYING)
