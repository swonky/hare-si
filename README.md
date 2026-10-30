# hare-si

A library and command-line tool for parsing, converting, and formatting quantities using the International System of Units (SI).

Written in pure Hare with zero dependencies.

## Features
- [x] Parses ASCII and UTF-8 encoded unit representations.
- [x] Parses arbitrary compound unit expressions.
- [x] Formats UTF-8 encoded unit representations.
- [ ] Formats ASCII encoded unit representations.
- [X] Conversions
- [ ] Arithmetic

### Supported units
- [X] SI prefixes (`Q` `R` `Y` `Z` `E` `P` `T` `G` `M` `k` `h` `da` `d` `c` `m` `µ` or `u` `n` `p` `f` `a` `z` `y` `r` `q`)
- [x] SI base units (`kg` `m` `s` `A` `K` `mol` `cd`)
- [x] SI derived units (`Bq` `C` `°C` or `degC` `F` `Gy` `H` `Hz` `J` `kat` `lm` `lx` `N` `Ω` or `ohm` `Pa` `rad` `S` `sr` `Sv` `T` `V` `W` `Wb`)
- [x] Formerly accepted non-SI units (`min` `h` `d` `au` `°` `′` `″` `as` `ha` `L` `t` `Da` `eV` `Np` `B`)

## Supported representations
| Parsing | Formatting | Feature |
| ------- | ---------- | ------- |
|x|x| Scientific notation. |
| | | Decimal points/commas. |
| | | Space digit grouping (SI-recommended). |
| | | Alternative digit grouping (comma, period, apostrophe). |
| | | Long formatting in International English. |
| | | Long formatting in other languages. |
| | | LaTeX unit representations. |

## Installation

## Usage

## References
