---
title: SI
section: 1
header: User Commands
footer: SI
---

# NAME

si - parse and convert SI units

# SYNOPSIS

`si` \[`OPTION`\]... \[`EXPRESSION`\]...

# DESCRIPTION

`si` parses expressions containing SI units and converts between compatible units.

# OPTIONS

`-c`, `--completions` _SHELL_

: Generate shell completions. Supported values are `bash` and `zsh`.

`-n`, `--notation` _NOTATION_

: Set numeric notation. Supported values are `general`, `fixed`, `scientific`, `e`, and `E`.

`-o`, `--output` _FORMAT_

: Set output format. Supported values are `utf`, `ascii`, and `json`.

`-p`, `--precision` _NUMBER_

: Set decimal precision (default: 3).

`-u`, `--unit` _STRING_

: Convert the quantity to the specified target unit representation.

`-s`, `--strict`

: Enforce strict TeX-style parsing rules for values.

`-b`, `--base`

: Format output using SI base units.

`-v`, `--version`

: Display version information.

`-h`, `--help`

: Display help information.


# EXAMPLES

Parse a quantity:

```sh
si '9.80665 m/s^2'
>> 9.80665 m/s²
```

Format using ASCII symbols:

```sh
si -o=ascii '1.5 kg·cm·s⁻²'
>> 1.5 kg\*cm*s^-2
```

Use scientific notation with three decimal places:

```sh
si -n=scientific -p=3 -o=utf '123.456789 kg\*m/s^2'
>> 1.234×10² kg⋅m/s²
```

Format using SI base units:

```sh
si --base '3.0 ohm\*m^2'
>> 3 kg⋅m⁴⋅s⁻³⋅A⁻²
```

Convert to a target unit:

```sh
si -u 'Wb/mm^2' '10 T'
>> 1×10⁻⁵ Wb/mm²
```

Produce JSON output:

```sh
si -o=json '101325 kPa'
>> {"value":101325,"unit":{"dim":{"kg":1,"m":-1,"s":-2,"A":0,"K":0,"mol":0,"cd":0},"scale":1e3}}
```

# EXPRESSION SYNTAX

| SYNTAX	                  | PERMISSIVE	| STRICT
| --------------------------- | ----------- | ---------------
| multiplication		      | * × · ⋅     | *
| exponent		              | ^ **        | ^
| positive                    | +           | +
| negative                    | -           | -
| Superscript exponents (m²)  | YES         | NO
| Parentheses ( )		      | YES         | NO
| Curly braces { }		      | YES         | NO
| Unicode minus signs		  | YES         | NO
| Unicode micro/ohm symbols	  | YES         | NO

# LIST OF SUPPORTED SYMBOLS 

## Decimal prefixes

| PREFIX            | SYMBOL     | SCALE                           |
| ------            | ------     | -------                         |
| Quetta            | Q          | × 10³⁰                          |
| Ronna             | R          | × 10²⁷                          |
| Yotta             | Y          | × 10²⁴                          |
| Zetta             | Z          | × 10²¹                          |
| Exa               | E          | × 10¹⁸                          |
| Peta              | P          | × 10¹⁵                          |
| Tera              | T          | × 10¹²                          |
| Giga              | G          | × 10⁹                           |
| Mega              | M          | × 10⁶                           |
| Kilo              | k          | × 10³                           |
| Hecto             | h          | × 10²                           |
| Deca              | da         | × 10¹                           |
| Deci              | d          | × 10⁻¹                          |
| Centi             | c          | × 10⁻²                          |
| Milli             | m          | × 10⁻³                          |
| \* Micro          | μ / u      | × 10⁻⁶                          |
| Nano              | n          | × 10⁻⁹                          |
| Pico              | p          | × 10⁻¹²                         |
| Femto             | f          | × 10⁻¹⁵                         |
| Atto              | a          | × 10⁻¹⁸                         |
| Zepto             | z          | × 10⁻²¹                         |
| Yocto             | y          | × 10⁻²⁴                         |
| Ronto             | r          | × 10⁻²⁷                         |
| Quecto            | q          | × 10⁻³⁰                         |

- (\*) Formatted as _GREEK SMALL LETTER MU (U+03BC)_. The parser also accepts _MICRO SIGN (U+00B5)_.

## SI units

| UNIT              | SYMBOL     | DIMENSION                       |
| ----------------- | ---------- | ------------------------------- |
| Ampere            | A          | Electric current                |
| Becquerel         | Bq         | Reciprocal time (aperiodic)     |
| Candela           | cd         | Luminous intensity              |
| Coulomb           | C          | Electric charge                 |
| Farad             | F          | Capacitance                     |
| Gram              | g          | Mass                            |
| Gray              | Gy         | Energy per mass                 |
| Henry             | H          | Inductance                      |
| Hertz             | Hz         | Reciprocal time (periodic)      |
| Joule             | J          | Energy                          |
| Katal             | kat        | Catalytic activity              |
| Kelvin            | K          | Thermodynamic temperature       |
| Lumen             | lm         | Luminous flux                   |
| Lux               | lx         | Illuminance                     |
| Metre             | m          | Length                          |
| Mole              | mol        | Amount of substance             |
| Newton            | N          | Force                           |
| \* Ohm            | Ω / ohm    | Electrical resistance           |
| Pascal            | Pa         | Pressure                        |
| Radian            | rad        | Plane angle                     |
| Second            | s          | Time                            |
| Siemens           | S          | Electrical conductance          |
| Sievert           | Sv         | Dose equivalent                 |
| Steradian         | sr         | Solid angle                     |
| Tesla             | T          | Magnetic flux density           |
| Volt              | V          | Electric potential              |
| Watt              | W          | Power                           |
| Weber             | Wb         | Magnetic flux                   |

- (\*) Formatted as _GREEK CAPITAL LETTER OMEGA (U+03A9)_. The parser also accepts _OHM SIGN (U+2126)_.

## Non-SI units

| UNIT              | SYMBOL     | DIMENSION                       |
| ----------------- | ---------- | ------------------------------- |
| Astronomical unit | au         | Length                          |
| Bel               | B          | Dimensionless (logarithmic)     |
| Dalton            | Da         | Mass                            |
| Day               | d          | Time                            |
| Degree            | deg / °    | Plane angle                     |
| Degree Celsius    | degC / °C  | Thermodynamic temperature       |
| Electronvolt      | eV         | Energy                          |
| Hectare           | ha         | Area                            |
| Hour              | h          | Time                            |
| Litre             | L          | Volume                          |
| Minute            | min        | Time                            |
| Neper             | Np         | Dimensionless (logarithmic)     |
| Tonne             | t          | Mass                            |

- Logarithmic units __bel__ and __neper__ do not currently support conversion.
- Temperature conversions are not currently supported. __degree celsius__ is treated as __kelvin__.
- The formatted UTF-8 outputs for __degree__ use _DEGREE_SIGN_(U+00B0)_.
- The formatted output for __litre__ uses _LATIN CAPITAL LETTER L (U+004C)_
- The parser for __litre__ also accepts _LATIN SMALL LETTER L (U+006C)_.

# AUTHORS

Written by Tom Spencer <https://codeberg.org/swonky>.
