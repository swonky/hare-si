## [si]{.heading-body}[+x86_64 +linux ]{.heading-extra}

::: readme
si: A module for parsing, converting, and formatting physical quantities
expressed with the International System of Units.

- Repository: https://codeberg.org/swonky/hare-si.git

=== Examples ===

- Defining quantities using predefined constants:

const distance = si::quantity { \
    unit = si::METRE, \
    value = 1500.0,\
};\
const duration = si::quantity { \
    unit = si::SECOND, \
    value = 120.0 \
};\

- Performing arithmetic with quantities:

const speed = si::divq(distance, duration);\
assert(speed.value == 12.5);\

- Defining your own derived dimensions, units, and quantities:

const pressure  = dimension { \
    mass = 1,\
    length = -1, \
    time = -2,\
    \... \
}; \
const pascal = unit { \
    dim = pressure,\
    scale = 1.0,\
};\
const atmospheric_pressure  = quantity { \
    unit = pascal,\
    value = 101325.0,\
};\

- Parsing ([strp](#strp){.ref}) and formatting ([strf](#strf){.ref})
  strings:

const acceleration = si::strp(\"20 m/s\^2\") as si::quantity;\
\
const output = si::strf(acceleration, \"km\*s\^-2\") as str;\
\>\> 0.02 km⋅s⁻²\
\
const output = si::strf(\
    acceleration,\
    \"km/s\^2\",\
    prec=3,\
    notation=si::E,\
    encoding=si::ASCII,\
) as str;\
\>\> 2.00e-02 km/s\^2\

=== Supported units ===

All symbols are case sensitive unless otherwise indicated.

Decimal prefix symbols \[symbol=exponent\]

- [QUETTA](#QUETTA){.ref} (Q) = 1e30
- [RONNA](#RONNA){.ref} (R) = 1e27
- [YOTTA](#YOTTA){.ref} (Y) = 1e24
- [ZETTA](#ZETTA){.ref} (Z) = 1e21
- [EXA](#EXA){.ref} (E) = 1e18
- [PETA](#PETA){.ref} (P) = 1e15
- [TERA](#TERA){.ref} (T) = 1e12
- [GIGA](#GIGA){.ref} (G) = 1e9
- [MEGA](#MEGA){.ref} (M) = 1e6
- [KILO](#KILO){.ref} (k) = 1e3
- [HECTO](#HECTO){.ref} (h) = 1e2
- [DECA](#DECA){.ref} (da) = 1e1
- [DECI](#DECI){.ref} (d) = 1e-1
- [CENTI](#CENTI){.ref} (c) = 1e-2
- [MILLI](#MILLI){.ref} (m) = 1e-3
- [MICRO](#MICRO){.ref} (µ) = 1e-6
- [NANO](#NANO){.ref} (n) = 1e-9
- [PICO](#PICO){.ref} (p) = 1e-12
- [FEMTO](#FEMTO){.ref} (f) = 1e-15
- [ATTO](#ATTO){.ref} (a) = 1e-18
- [ZEPTO](#ZEPTO){.ref} (z) = 1e-21
- [YOCTO](#YOCTO){.ref} (y) = 1e-24
- [RONTO](#RONTO){.ref} (r) = 1e-27
- [QUECTO](#QUECTO){.ref} (q) = 1e-30

Notes:

- Formatted ASCII output for [MICRO](#MICRO){.ref} uses LATIN SMALL
  LETTER U (U+0075)
- Formattted UTF-8 output for [MICRO](#MICRO){.ref} uses GREEK SMALL
  LETTER MU (U+03BC).
- The parser for [MICRO](#MICRO){.ref} also accepts MICRO SIGN (U+00B5).

SI unit symbols

- [AMPERE](#AMPERE){.ref} (A)
- [BECQUEREL](#BECQUEREL){.ref} (Bq)
- [CANDELA](#CANDELA){.ref} (cd)
- [COULOMB](#COULOMB){.ref} (C)
- [FARAD](#FARAD){.ref} (F)
- [GRAM](#GRAM){.ref} (g)
- [GRAY](#GRAY){.ref} (Gy)
- [HENRY](#HENRY){.ref} (H)
- [HERTZ](#HERTZ){.ref} (Hz)
- [JOULE](#JOULE){.ref} (J)
- [KATAL](#KATAL){.ref} (kat)
- [KELVIN](#KELVIN){.ref} (K)
- [LUMEN](#LUMEN){.ref} (lm)
- [LUX](#LUX){.ref} (lx)
- [METRE](#METRE){.ref} (m)
- [MOLE](#MOLE){.ref} (mol)
- [NEWTON](#NEWTON){.ref} (N)
- [OHM](#OHM){.ref} (ohm/Ω)
- [PASCAL](#PASCAL){.ref} (Pa)
- [RADIAN](#RADIAN){.ref} (rad)
- [SECOND](#SECOND){.ref} (s)
- [SIEMENS](#SIEMENS){.ref} (S)
- [SIEVERT](#SIEVERT){.ref} (Sv)
- [STERADIAN](#STERADIAN){.ref} (sr)
- [TESLA](#TESLA){.ref} (T)
- [VOLT](#VOLT){.ref} (V)
- [WATT](#WATT){.ref} (W)
- [WEBER](#WEBER){.ref} (Wb)

Notes:

- UTF-8 output for [OHM](#OHM){.ref} uses GREEK CAPITAL LETTER OMEGA
  (U+03A9).
- The parser for [OHM](#OHM){.ref} also accepts OHM SIGN (U+2126).

Non-SI unit symbols \[name=symbol\]

- [ASTRONOMICAL_UNIT](#ASTRONOMICAL_UNIT){.ref} (au)
- [BEL](#BEL){.ref} (B)
- [DALTON](#DALTON){.ref} (Da)
- [DAY](#DAY){.ref} (d)
- [DEGREE](#DEGREE){.ref} (deg/°)
- [DEGREE_CELSIUS](#DEGREE_CELSIUS){.ref} (degC/°C)
- [ELECTRONVOLT](#ELECTRONVOLT){.ref} (eV)
- [HECTARE](#HECTARE){.ref} (ha)
- [HOUR](#HOUR){.ref} (h)
- [LITRE](#LITRE){.ref} (L)
- [MINUTE](#MINUTE){.ref} (min)
- [NEPER](#NEPER){.ref} (Np)
- [TONNE](#TONNE){.ref} (t)

Notes:

- Logarithmic units [BEL](#BEL){.ref} and [NEPER](#NEPER){.ref} do not
  currently support conversion.
- Temperature conversions are not currently supported.
  [DEGREE_CELSIUS](#DEGREE_CELSIUS){.ref} is treated as
  [KELVIN](#KELVIN){.ref}.
- The formatted UTF-8 outputs for [DEGREE](#DEGREE){.ref} use DEGREE
  SIGN (U+00B0).
- The formatted output for [LITRE](#LITRE){.ref} uses LATIN CAPITAL
  LETTER L (U+004C).
- The parser for [LITRE](#LITRE){.ref} also accepts LATIN SMALL LETTER L
  (U+006C).
:::

### Index

#### Types

\
[type]{.keyword} [dimension](#dimension);\
[type]{.keyword} [encoding](#encoding);\
[type]{.keyword} [notation](#notation);\
[type]{.keyword} [prefix_kind](#prefix_kind);\
[type]{.keyword} [quantity](#quantity);\
[type]{.keyword} [symbol_kind](#symbol_kind);\
[type]{.keyword} [unit](#unit);\
\
[// Undocumented types:]{.comment}\
[type]{.keyword} [token](#token);\
[type]{.keyword} [token_kind](#token_kind);\
[type]{.keyword} [unit_kind](#unit_kind);\

#### Errors

\
[type]{.keyword} [dimension_mismatch](#dimension_mismatch);\
[type]{.keyword} [error](#error);\
[type]{.keyword} [invalid](#invalid);\
[type]{.keyword} [invalid_exponent](#invalid_exponent);\
[type]{.keyword} [no_match](#no_match);\
[type]{.keyword} [not_implemented](#not_implemented);\
\
[// Undocumented Errors:]{.comment}\
[type]{.keyword} [invalid_token](#invalid_token);\
[type]{.keyword} [unclosed_scope](#unclosed_scope);\
[type]{.keyword} [unexpected_token](#unexpected_token);\

#### Constants

\
[def]{.keyword} [ABSORBED_DOSE](#ABSORBED_DOSE) = dimension {\
    length = 2,\
    time = -2,\
    \...\
};\
[def]{.keyword} [ACTIVITY](#ACTIVITY) = dimension {\
    time = -1,\
    \...\
};\
[def]{.keyword} [ANGSTROM](#ANGSTROM) = unit {\
    dim = LENGTH,\
    scale = 1.0e-10,\
};\
[def]{.keyword} [ASTRONOMICAL_UNIT](#ASTRONOMICAL_UNIT) = unit {\
    dim = LENGTH,\
    scale = 149597870700.0,\
};\
[def]{.keyword} [ATMOSPHERE](#ATMOSPHERE) = unit {\
    dim = PRESSURE,\
    scale = 101325.0,\
};\
[def]{.keyword} [AVOGADRO](#AVOGADRO) = quantity {\
    unit = RECIPROCAL_MOLE,\
    value = 6.02214076e23,\
};\
[def]{.keyword} [BAR](#BAR) = unit {\
    dim = PRESSURE,\
    scale = 1.0e5,\
};\
[def]{.keyword} [BARN](#BARN) = unit {\
    dim = AREA,\
    scale = 1.0e-28,\
};\
[def]{.keyword} [BEL](#BEL) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
[def]{.keyword} [BOLTZMANN](#BOLTZMANN) = quantity {\
    unit = JOULE_PER_KELVIN,\
    value = 1.380649e-23,\
};\
[def]{.keyword} [CALORIE](#CALORIE) = unit {\
    dim = ENERGY,\
    scale = 4.184,\
};\
[def]{.keyword} [CAPACITANCE](#CAPACITANCE) = dimension {\
    mass = -1,\
    length = -2,\
    time = 4,\
    current = 2,\
    \...\
};\
[def]{.keyword} [CATALYTIC_ACTIVITY](#CATALYTIC_ACTIVITY) = dimension {\
    time = -1,\
    substance = 1,\
    \...\
};\
[def]{.keyword} [CENTIMETRE](#CENTIMETRE) = unit {\
    dim = LENGTH,\
    scale = 0.01,\
};\
[def]{.keyword} [CONDUCTANCE](#CONDUCTANCE) = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    current = 2,\
    \...\
};\
[def]{.keyword} [CUBIC_CENTIMETRE](#CUBIC_CENTIMETRE) = unit {\
    dim = VOLUME,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [CUBIC_MILLIMETRE](#CUBIC_MILLIMETRE) = unit {\
    dim = VOLUME,\
    scale = 1.0e-9,\
};\
[def]{.keyword} [CURIE](#CURIE) = unit {\
    dim = ACTIVITY,\
    scale = 3.7e10,\
};\
[def]{.keyword} [CURRENT](#CURRENT) = dimension {\
    current = 1,\
    \...\
};\
[def]{.keyword} [DALTON](#DALTON) = unit {\
    dim = MASS,\
    scale = 1.66053906892e-27,\
};\
[def]{.keyword} [DAY](#DAY) = unit {\
    dim = TIME,\
    scale = 86400.0,\
};\
[def]{.keyword} [DECAMETRE](#DECAMETRE) = unit {\
    dim = LENGTH,\
    scale = 10.0,\
};\
[def]{.keyword} [DECIMETRE](#DECIMETRE) = unit {\
    dim = LENGTH,\
    scale = 0.1,\
};\
[def]{.keyword} [DEGREE](#DEGREE) = unit {\
    dim = DIMENSIONLESS,\
    scale = 0.017453292519943295,\
};\
[def]{.keyword} [DIMENSIONLESS](#DIMENSIONLESS) = dimension {\
    \...\
};\
[def]{.keyword} [DOSE_EQUIVALENT](#DOSE_EQUIVALENT) = dimension {\
    length = 2,\
    time = -2,\
    \...\
};\
[def]{.keyword} [DYNAMIC_VISCOSITY](#DYNAMIC_VISCOSITY) = dimension {\
    mass = 1,\
    length = -1,\
    time = -1,\
    \...\
};\
[def]{.keyword} [DYNE](#DYNE) = unit {\
    dim = FORCE,\
    scale = 1.0e-5,\
};\
[def]{.keyword} [ELECTRIC_CHARGE](#ELECTRIC_CHARGE) = dimension {\
    time = 1,\
    current = 1,\
    \...\
};\
[def]{.keyword} [ELECTRIC_POTENTIAL](#ELECTRIC_POTENTIAL) = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -1,\
    \...\
};\
[def]{.keyword} [ELECTRONVOLT](#ELECTRONVOLT) = unit {\
    dim = ENERGY,\
    scale = 1.602176634e-19,\
};\
[def]{.keyword} [ELEMENTARY_CHARGE](#ELEMENTARY_CHARGE) = quantity {\
    unit = COULOMB,\
    value = 1.602176634e-19,\
};\
[def]{.keyword} [ENERGY](#ENERGY) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    \...\
};\
[def]{.keyword} [ERG](#ERG) = unit {\
    dim = ENERGY,\
    scale = 1.0e-7,\
};\
[def]{.keyword} [EXPOSURE](#EXPOSURE) = dimension {\
    mass = -1,\
    time = 1,\
    current = 1,\
    \...\
};\
[def]{.keyword} [FORCE](#FORCE) = dimension {\
    mass = 1,\
    length = 1,\
    time = -2,\
    \...\
};\
[def]{.keyword} [FREQUENCY](#FREQUENCY) = dimension {\
    time = -1,\
    \...\
};\
[def]{.keyword} [GAL](#GAL) = unit {\
    dim = ACCELERATION,\
    scale = 0.01,\
};\
[def]{.keyword} [GAUSS](#GAUSS) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-4,\
};\
[def]{.keyword} [GIGAHERTZ](#GIGAHERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0e9,\
};\
[def]{.keyword} [GIGAJOULE](#GIGAJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e9,\
};\
[def]{.keyword} [GIGAPASCAL](#GIGAPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e9,\
};\
[def]{.keyword} [GIGAWATT](#GIGAWATT) = unit {\
    dim = POWER,\
    scale = 1.0e9,\
};\
[def]{.keyword} [GRAM](#GRAM) = unit {\
    dim = MASS,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [HECTARE](#HECTARE) = unit {\
    dim = AREA,\
    scale = 1.0e4,\
};\
[def]{.keyword} [HECTOMETRE](#HECTOMETRE) = unit {\
    dim = LENGTH,\
    scale = 100.0,\
};\
[def]{.keyword} [HECTOPASCAL](#HECTOPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 100.0,\
};\
[def]{.keyword} [HOUR](#HOUR) = unit {\
    dim = TIME,\
    scale = 3600.0,\
};\
[def]{.keyword} [HYPERFINE_TRANSITION_CAESIUM_133](#HYPERFINE_TRANSITION_CAESIUM_133) = quantity {\
    unit = HERTZ,\
    value = 9192631770.0,\
};\
[def]{.keyword} [ILLUMINANCE](#ILLUMINANCE) = dimension {\
    length = -2,\
    luminosity = 1,\
    \...\
};\
[def]{.keyword} [INDUCTANCE](#INDUCTANCE) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -2,\
    \...\
};\
[def]{.keyword} [JOULE_PER_KELVIN](#JOULE_PER_KELVIN) = unit {\
    dim = ENTROPY,\
    scale = 1.0,\
};\
[def]{.keyword} [JOULE_SECOND](#JOULE_SECOND) = unit {\
    dim = ACTION,\
    scale = 1.0,\
};\
[def]{.keyword} [KILOHERTZ](#KILOHERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILOJOULE](#KILOJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILOMETRE](#KILOMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILONEWTON](#KILONEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILOOHM](#KILOOHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILOPASCAL](#KILOPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILOVOLT](#KILOVOLT) = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KILOWATT](#KILOWATT) = unit {\
    dim = POWER,\
    scale = 1.0e3,\
};\
[def]{.keyword} [KINEMATIC_VISCOSITY](#KINEMATIC_VISCOSITY) = dimension {\
    length = 2,\
    time = -1,\
    \...\
};\
[def]{.keyword} [LENGTH](#LENGTH) = dimension {\
    length = 1,\
    \...\
};\
[def]{.keyword} [LITRE](#LITRE) = unit {\
    dim = VOLUME,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [LUMINOSITY](#LUMINOSITY) = dimension {\
    luminosity = 1,\
    \...\
};\
[def]{.keyword} [LUMINOUS_EFFICACY_540_THZ](#LUMINOUS_EFFICACY_540_THZ) = quantity {\
    unit = LUMEN_PER_WATT,\
    value = 683.0,\
};\
[def]{.keyword} [LUMINOUS_FLUX](#LUMINOUS_FLUX) = dimension {\
    luminosity = 1,\
    \...\
};\
[def]{.keyword} [MAGNETIC_FLUX](#MAGNETIC_FLUX) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -1,\
    \...\
};\
[def]{.keyword} [MAGNETIC_FLUX_DENSITY](#MAGNETIC_FLUX_DENSITY) = dimension {\
    mass = 1,\
    time = -2,\
    current = -1,\
    \...\
};\
[def]{.keyword} [MASS](#MASS) = dimension {\
    mass = 1,\
    \...\
};\
[def]{.keyword} [MAXWELL](#MAXWELL) = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-8,\
};\
[def]{.keyword} [MEGAHERTZ](#MEGAHERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0e6,\
};\
[def]{.keyword} [MEGAJOULE](#MEGAJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e6,\
};\
[def]{.keyword} [MEGANEWTON](#MEGANEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0e6,\
};\
[def]{.keyword} [MEGAOHM](#MEGAOHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0e6,\
};\
[def]{.keyword} [MEGAPASCAL](#MEGAPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e6,\
};\
[def]{.keyword} [MEGAWATT](#MEGAWATT) = unit {\
    dim = POWER,\
    scale = 1.0e6,\
};\
[def]{.keyword} [MICROAMPERE](#MICROAMPERE) = unit {\
    dim = CURRENT,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MICROCOULOMB](#MICROCOULOMB) = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MICROFARAD](#MICROFARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MICROGRAM](#MICROGRAM) = unit {\
    dim = MASS,\
    scale = 1.0e-9,\
};\
[def]{.keyword} [MICROMETRE](#MICROMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MICRON](#MICRON) = MICROMETRE;\
[def]{.keyword} [MICROSECOND](#MICROSECOND) = unit {\
    dim = TIME,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MICROTESLA](#MICROTESLA) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MILLIAMPERE](#MILLIAMPERE) = unit {\
    dim = CURRENT,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLICOULOMB](#MILLICOULOMB) = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIGRAM](#MILLIGRAM) = unit {\
    dim = MASS,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [MILLIJOULE](#MILLIJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIMETRE](#MILLIMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIMETRES_OF_MERCURY](#MILLIMETRES_OF_MERCURY) = unit {\
    dim = PRESSURE,\
    scale = 133.322,\
};\
[def]{.keyword} [MILLINEWTON](#MILLINEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIOHM](#MILLIOHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIPASCAL](#MILLIPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIPASCAL_SECOND](#MILLIPASCAL_SECOND) = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLISECOND](#MILLISECOND) = unit {\
    dim = TIME,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLITESLA](#MILLITESLA) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIVOLT](#MILLIVOLT) = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIWATT](#MILLIWATT) = unit {\
    dim = POWER,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MILLIWEBER](#MILLIWEBER) = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-3,\
};\
[def]{.keyword} [MINUTE](#MINUTE) = unit {\
    dim = TIME,\
    scale = 60.0,\
};\
[def]{.keyword} [NANOFARAD](#NANOFARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-9,\
};\
[def]{.keyword} [NANOMETRE](#NANOMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-9,\
};\
[def]{.keyword} [NANOSECOND](#NANOSECOND) = unit {\
    dim = TIME,\
    scale = 1.0e-9,\
};\
[def]{.keyword} [NEPER](#NEPER) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
[def]{.keyword} [NEWTON_METRE](#NEWTON_METRE) = unit {\
    dim = TORQUE,\
    scale = 1.0,\
};\
[def]{.keyword} [NEWTON_PER_METRE](#NEWTON_PER_METRE) = unit {\
    dim = SURFACE_TENSION,\
    scale = 1.0,\
};\
[def]{.keyword} [OERSTED](#OERSTED) = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 79.57747155,\
};\
[def]{.keyword} [PASCAL_SECOND](#PASCAL_SECOND) = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [PICOFARAD](#PICOFARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-12,\
};\
[def]{.keyword} [PICOMETRE](#PICOMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-12,\
};\
[def]{.keyword} [PLANCK](#PLANCK) = quantity {\
    unit = JOULE_SECOND,\
    value = 6.62607015e-34,\
};\
[def]{.keyword} [POISE](#POISE) = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 0.1,\
};\
[def]{.keyword} [POWER](#POWER) = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    \...\
};\
[def]{.keyword} [PRESSURE](#PRESSURE) = dimension {\
    mass = 1,\
    length = -1,\
    time = -2,\
    \...\
};\
[def]{.keyword} [RAD](#RAD) = unit {\
    dim = ABSORBED_DOSE,\
    scale = 0.01,\
};\
[def]{.keyword} [RECIPROCAL_CURRENT](#RECIPROCAL_CURRENT) = dimension {\
    current = -1,\
    \...\
};\
[def]{.keyword} [RECIPROCAL_LUMINOSITY](#RECIPROCAL_LUMINOSITY) = dimension {\
    luminosity = -1,\
    \...\
};\
[def]{.keyword} [RECIPROCAL_MASS](#RECIPROCAL_MASS) = dimension {\
    mass = -1,\
    \...\
};\
[def]{.keyword} [RECIPROCAL_SUBSTANCE](#RECIPROCAL_SUBSTANCE) = dimension {\
    substance = -1,\
    \...\
};\
[def]{.keyword} [RECIPROCAL_TEMPERATURE](#RECIPROCAL_TEMPERATURE) = dimension {\
    temperature = -1,\
    \...\
};\
[def]{.keyword} [REM](#REM) = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 0.01,\
};\
[def]{.keyword} [RESISTANCE](#RESISTANCE) = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -2,\
    \...\
};\
[def]{.keyword} [ROENTGEN](#ROENTGEN) = unit {\
    dim = EXPOSURE,\
    scale = 2.58e-4,\
};\
[def]{.keyword} [SPEED_OF_LIGHT](#SPEED_OF_LIGHT) = quantity {\
    unit = METRE_PER_SECOND,\
    value = 299792458.0,\
};\
[def]{.keyword} [SQUARE_CENTIMETRE](#SQUARE_CENTIMETRE) = unit {\
    dim = AREA,\
    scale = 1.0e-4,\
};\
[def]{.keyword} [SQUARE_KILOMETRE](#SQUARE_KILOMETRE) = unit {\
    dim = AREA,\
    scale = 1.0e6,\
};\
[def]{.keyword} [SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND) = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [SQUARE_MILLIMETRE](#SQUARE_MILLIMETRE) = unit {\
    dim = AREA,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [SQUARE_MILLIMETRE_PER_SECOND](#SQUARE_MILLIMETRE_PER_SECOND) = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-6,\
};\
[def]{.keyword} [STOKES](#STOKES) = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-4,\
};\
[def]{.keyword} [SUBSTANCE](#SUBSTANCE) = dimension {\
    substance = 1,\
    \...\
};\
[def]{.keyword} [TEMPERATURE](#TEMPERATURE) = dimension {\
    temperature = 1,\
    \...\
};\
[def]{.keyword} [TIME](#TIME) = dimension {\
    time = 1,\
    \...\
};\
[def]{.keyword} [TONNE](#TONNE) = unit {\
    dim = MASS,\
    scale = 1.0e3,\
};\
[def]{.keyword} [TORR](#TORR) = unit {\
    dim = PRESSURE,\
    scale = 133.322368421,\
};\
[def]{.keyword} [WAVENUMBER](#WAVENUMBER) = dimension {\
    length = -1,\
    \...\
};\
\
[// Undocumented constants:]{.comment}\
[def]{.keyword} [ACCELERATION](#ACCELERATION) = dimension {\
    length = 1,\
    time = -2,\
    \...\
};\
[def]{.keyword} [ACTION](#ACTION) = dimension {\
    mass = 1,\
    length = 2,\
    time = -1,\
    \...\
};\
[def]{.keyword} [AMPERE](#AMPERE) = unit {\
    dim = CURRENT,\
    scale = 1.0,\
};\
[def]{.keyword} [AMPERE_PER_METRE](#AMPERE_PER_METRE) = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 1.0,\
};\
[def]{.keyword} [AMPERE_PER_SQUARE_METRE](#AMPERE_PER_SQUARE_METRE) = unit {\
    dim = CURRENT_DENSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [AREA](#AREA) = dimension {\
    length = 2,\
    \...\
};\
[def]{.keyword} [ATTO](#ATTO): [f64]{.type} = 1.0e-18;\
[def]{.keyword} [BECQUEREL](#BECQUEREL) = unit {\
    dim = ACTIVITY,\
    scale = 1.0,\
};\
[def]{.keyword} [CANDELA](#CANDELA) = unit {\
    dim = LUMINOSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [CANDELA_PER_SQUARE_METRE](#CANDELA_PER_SQUARE_METRE) = unit {\
    dim = LUMINANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [CENTI](#CENTI): [f64]{.type} = 0.01;\
[def]{.keyword} [CONCENTRATION](#CONCENTRATION) = dimension {\
    substance = 1,\
    length = -3,\
    \...\
};\
[def]{.keyword} [COULOMB](#COULOMB) = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0,\
};\
[def]{.keyword} [COULOMB_PER_KILOGRAM](#COULOMB_PER_KILOGRAM) = unit {\
    dim = EXPOSURE,\
    scale = 1.0,\
};\
[def]{.keyword} [CUBIC_METRE](#CUBIC_METRE) = unit {\
    dim = VOLUME,\
    scale = 1.0,\
};\
[def]{.keyword} [CUBIC_METRE_PER_KILOGRAM](#CUBIC_METRE_PER_KILOGRAM) = unit {\
    dim = SPECIFIC_VOLUME,\
    scale = 1.0,\
};\
[def]{.keyword} [CURRENT_DENSITY](#CURRENT_DENSITY) = dimension {\
    current = 1,\
    length = -2,\
    \...\
};\
[def]{.keyword} [DECA](#DECA): [f64]{.type} = 10.0;\
[def]{.keyword} [DECI](#DECI): [f64]{.type} = 0.1;\
[def]{.keyword} [DEGREE_CELSIUS](#DEGREE_CELSIUS) = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};\
[def]{.keyword} [DENSITY](#DENSITY) = dimension {\
    mass = 1,\
    length = -3,\
    \...\
};\
[def]{.keyword} [DIMENSIONLESS_UNIT](#DIMENSIONLESS_UNIT) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
[def]{.keyword} [ENTROPY](#ENTROPY) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    temperature = -1,\
    \...\
};\
[def]{.keyword} [EXA](#EXA): [f64]{.type} = 1.0e18;\
[def]{.keyword} [FARAD](#FARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [FEMTO](#FEMTO): [f64]{.type} = 1.0e-15;\
[def]{.keyword} [GIGA](#GIGA): [f64]{.type} = 1.0e9;\
[def]{.keyword} [GRAY](#GRAY) = unit {\
    dim = ABSORBED_DOSE,\
    scale = 1.0,\
};\
[def]{.keyword} [HECTO](#HECTO): [f64]{.type} = 100.0;\
[def]{.keyword} [HENRY](#HENRY) = unit {\
    dim = INDUCTANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [HERTZ](#HERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0,\
};\
[def]{.keyword} [JOULE](#JOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0,\
};\
[def]{.keyword} [KATAL](#KATAL) = unit {\
    dim = CATALYTIC_ACTIVITY,\
    scale = 1.0,\
};\
[def]{.keyword} [KELVIN](#KELVIN) = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};\
[def]{.keyword} [KILO](#KILO): [f64]{.type} = 1.0e3;\
[def]{.keyword} [KILOGRAM](#KILOGRAM) = unit {\
    dim = MASS,\
    scale = 1.0,\
};\
[def]{.keyword} [KILOGRAM_PER_CUBIC_METRE](#KILOGRAM_PER_CUBIC_METRE) = unit {\
    dim = DENSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [KILOGRAM_PER_SQUARE_METRE](#KILOGRAM_PER_SQUARE_METRE) = unit {\
    dim = SURFACE_DENSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [LUMEN](#LUMEN) = unit {\
    dim = LUMINOUS_FLUX,\
    scale = 1.0,\
};\
[def]{.keyword} [LUMEN_PER_WATT](#LUMEN_PER_WATT) = unit {\
    dim = LUMINOUS_EFFICACY,\
    scale = 1.0,\
};\
[def]{.keyword} [LUMINANCE](#LUMINANCE) = dimension {\
    luminosity = 1,\
    length = -2,\
    \...\
};\
[def]{.keyword} [LUMINOUS_EFFICACY](#LUMINOUS_EFFICACY) = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    luminosity = 1,\
    \...\
};\
[def]{.keyword} [LUX](#LUX) = unit {\
    dim = ILLUMINANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [MAGNETIC_FIELD_STRENGTH](#MAGNETIC_FIELD_STRENGTH) = dimension {\
    current = 1,\
    length = -1,\
    \...\
};\
[def]{.keyword} [MEGA](#MEGA): [f64]{.type} = 1.0e6;\
[def]{.keyword} [METRE](#METRE) = unit {\
    dim = LENGTH,\
    scale = 1.0,\
};\
[def]{.keyword} [METRE_PER_SECOND](#METRE_PER_SECOND) = unit {\
    dim = VELOCITY,\
    scale = 1.0,\
};\
[def]{.keyword} [METRE_PER_SECOND_SQUARED](#METRE_PER_SECOND_SQUARED) = unit {\
    dim = ACCELERATION,\
    scale = 1.0,\
};\
[def]{.keyword} [MICRO](#MICRO): [f64]{.type} = 1.0e-6;\
[def]{.keyword} [MILLI](#MILLI): [f64]{.type} = 1.0e-3;\
[def]{.keyword} [MOLE](#MOLE) = unit {\
    dim = SUBSTANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [MOLE_PER_CUBIC_METRE](#MOLE_PER_CUBIC_METRE) = unit {\
    dim = CONCENTRATION,\
    scale = 1.0,\
};\
[def]{.keyword} [NANO](#NANO): [f64]{.type} = 1.0e-9;\
[def]{.keyword} [NEWTON](#NEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0,\
};\
[def]{.keyword} [NONE](#NONE): [f64]{.type} = 1.0;\
[def]{.keyword} [OHM](#OHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [PASCAL](#PASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0,\
};\
[def]{.keyword} [PETA](#PETA): [f64]{.type} = 1.0e15;\
[def]{.keyword} [PICO](#PICO): [f64]{.type} = 1.0e-12;\
[def]{.keyword} [QUECTO](#QUECTO): [f64]{.type} = 1.0e-30;\
[def]{.keyword} [QUETTA](#QUETTA): [f64]{.type} = 1.0e30;\
[def]{.keyword} [RADIAN](#RADIAN) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
[def]{.keyword} [RECIPROCAL_AMPERE](#RECIPROCAL_AMPERE) = unit {\
    dim = RECIPROCAL_CURRENT,\
    scale = 1.0,\
};\
[def]{.keyword} [RECIPROCAL_CANDELA](#RECIPROCAL_CANDELA) = unit {\
    dim = RECIPROCAL_LUMINOSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [RECIPROCAL_KELVIN](#RECIPROCAL_KELVIN) = unit {\
    dim = RECIPROCAL_TEMPERATURE,\
    scale = 1.0,\
};\
[def]{.keyword} [RECIPROCAL_KILOGRAM](#RECIPROCAL_KILOGRAM) = unit {\
    dim = RECIPROCAL_MASS,\
    scale = 1.0,\
};\
[def]{.keyword} [RECIPROCAL_METRE](#RECIPROCAL_METRE) = unit {\
    dim = WAVENUMBER,\
    scale = 1.0,\
};\
[def]{.keyword} [RECIPROCAL_MOLE](#RECIPROCAL_MOLE) = unit {\
    dim = RECIPROCAL_SUBSTANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [RONNA](#RONNA): [f64]{.type} = 1.0e27;\
[def]{.keyword} [RONTO](#RONTO): [f64]{.type} = 1.0e-27;\
[def]{.keyword} [SECOND](#SECOND) = unit {\
    dim = TIME,\
    scale = 1.0,\
};\
[def]{.keyword} [SIEMENS](#SIEMENS) = unit {\
    dim = CONDUCTANCE,\
    scale = 1.0,\
};\
[def]{.keyword} [SIEVERT](#SIEVERT) = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 1.0,\
};\
[def]{.keyword} [SPECIFIC_VOLUME](#SPECIFIC_VOLUME) = dimension {\
    mass = -1,\
    length = 3,\
    \...\
};\
[def]{.keyword} [SQUARE_METRE](#SQUARE_METRE) = unit {\
    dim = AREA,\
    scale = 1.0,\
};\
[def]{.keyword} [STERADIAN](#STERADIAN) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
[def]{.keyword} [SURFACE_DENSITY](#SURFACE_DENSITY) = dimension {\
    mass = 1,\
    length = -2,\
    \...\
};\
[def]{.keyword} [SURFACE_TENSION](#SURFACE_TENSION) = dimension {\
    mass = 1,\
    length = 0,\
    time = -2,\
    \...\
};\
[def]{.keyword} [TERA](#TERA): [f64]{.type} = 1.0e12;\
[def]{.keyword} [TESLA](#TESLA) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0,\
};\
[def]{.keyword} [TORQUE](#TORQUE) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    \...\
};\
[def]{.keyword} [VELOCITY](#VELOCITY) = dimension {\
    length = 1,\
    time = -1,\
    \...\
};\
[def]{.keyword} [VOLT](#VOLT) = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0,\
};\
[def]{.keyword} [VOLUME](#VOLUME) = dimension {\
    length = 3,\
    \...\
};\
[def]{.keyword} [WATT](#WATT) = unit {\
    dim = POWER,\
    scale = 1.0,\
};\
[def]{.keyword} [WEBER](#WEBER) = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0,\
};\
[def]{.keyword} [YOCTO](#YOCTO): [f64]{.type} = 1.0e-24;\
[def]{.keyword} [YOTTA](#YOTTA): [f64]{.type} = 1.0e24;\
[def]{.keyword} [ZEPTO](#ZEPTO): [f64]{.type} = 1.0e-21;\
[def]{.keyword} [ZETTA](#ZETTA): [f64]{.type} = 1.0e21;\

#### Globals

\
[const]{.keyword} [GIT_VERSION](#GIT_VERSION): [str]{.type};\
[const]{.keyword} [SEM_VERSION](#SEM_VERSION): [str]{.type};\

#### Functions

\
[fn]{.keyword} [add](#add)(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [(]{.type}[quantity]{.type} [\|]{.type} [dimension_mismatch]{.type}[)]{.type};\
[fn]{.keyword} [divd](#divd)(a: [dimension]{.type}, b: [dimension]{.type}) [dimension]{.type};\
[fn]{.keyword} [divq](#divq)(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [quantity]{.type};\
[fn]{.keyword} [divu](#divu)(a: [unit]{.type}, b: [unit]{.type}) [unit]{.type};\
[fn]{.keyword} [encodejson](#encodejson)(h: [io]{.type}[::]{.type}[handle]{.type}, obj: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [equal](#equal)(a: [dimension]{.type}, b: [dimension]{.type}) [bool]{.type};\
[fn]{.keyword} [fprint](#fprint)(out: [io]{.type}[::]{.type}[handle]{.type}, x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [identify](#identify)(in: [str]{.type}) [(]{.type}[prefix_kind]{.type}[,]{.type} [unit_kind]{.type}[)]{.type};\
[fn]{.keyword} [isclose](#isclose)(a: [quantity]{.type}, b: [quantity]{.type}, tol: [f64]{.type} = math::STANDARD_TOL) [(]{.type}[bool]{.type} [\|]{.type} [dimension_mismatch]{.type}[)]{.type};\
[fn]{.keyword} [isinf](#isinf)(q: [quantity]{.type}) [bool]{.type};\
[fn]{.keyword} [isnan](#isnan)(q: [quantity]{.type}) [bool]{.type};\
[fn]{.keyword} [muld](#muld)(a: [dimension]{.type}, b: [dimension]{.type}) [dimension]{.type};\
[fn]{.keyword} [mulq](#mulq)(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [quantity]{.type};\
[fn]{.keyword} [mulu](#mulu)(a: [unit]{.type}, b: [unit]{.type}) [unit]{.type};\
[fn]{.keyword} [powd](#powd)(x: [dimension]{.type}, p: [int]{.type}) [dimension]{.type};\
[fn]{.keyword} [powq](#powq)(x: [quantity]{.type}, p: [int]{.type}) [quantity]{.type};\
[fn]{.keyword} [powu](#powu)(x: [unit]{.type}, p: [int]{.type}) [unit]{.type};\
[fn]{.keyword} [print](#print)(x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [println](#println)(x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [scale](#scale)(u: [unit]{.type}, fac: [(]{.type}[prefix_kind]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [unit]{.type};\
[fn]{.keyword} [strerror](#strerror)(err: [error]{.type}) [str]{.type};\
[fn]{.keyword} [strf](#strf)(x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[str]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [strp](#strp)(s: [str]{.type}) [(]{.type}[quantity]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [strpu](#strpu)(s: [str]{.type}) [(]{.type}[unit]{.type} [\|]{.type} [error]{.type}[)]{.type};\
[fn]{.keyword} [sub](#sub)(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [(]{.type}[quantity]{.type} [\|]{.type} [dimension_mismatch]{.type}[)]{.type};\
[fn]{.keyword} [tojson](#tojson)(obj: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}) [(]{.type}[str]{.type} [\|]{.type} [error]{.type}[)]{.type};\
\
[// Undocumented functions:]{.comment}\
[fn]{.keyword} [split](#split)(input: [str]{.type}) [(]{.type}[(]{.type}[str]{.type}[,]{.type} [str]{.type}[)]{.type} [\|]{.type} [error]{.type}[)]{.type};\

### Types

::: {.section .member}
#### [type dimension]{.heading-body}[[\[permalink\]](#dimension)]{.heading-extra} {#dimension}

\
[type]{.keyword} dimension = [struct]{.type} {\
[  ]{.comment}[//]{.comment}[ mass]{.comment}[\
]{.comment} mass: [int]{.type},\
[  ]{.comment}[//]{.comment}[ length]{.comment}[\
]{.comment} length: [int]{.type},\
[  ]{.comment}[//]{.comment}[ time]{.comment}[\
]{.comment} time: [int]{.type},\
[  ]{.comment}[//]{.comment}[ electric current]{.comment}[\
]{.comment} current: [int]{.type},\
[  ]{.comment}[//]{.comment}[ thermodynamic temperature]{.comment}[\
]{.comment} temperature: [int]{.type},\
[  ]{.comment}[//]{.comment}[ amount of substance]{.comment}[\
]{.comment} substance: [int]{.type},\
[  ]{.comment}[//]{.comment}[ luminous intensity]{.comment}[\
]{.comment} luminosity: [int]{.type},\
};

Represents the dimensional exponents of the seven SI base dimensions.
:::

::: {.section .member}
#### [type encoding]{.heading-body}[[\[permalink\]](#encoding)]{.heading-extra} {#encoding}

\
[type]{.keyword} encoding = [enum]{.type} [u8]{.type} {\
    ASCII,\
    UTF8,\
    JSON,\
};

Specifies the character encoding options.
:::

::: {.section .member}
#### [type notation]{.heading-body}[[\[permalink\]](#notation)]{.heading-extra} {#notation}

\
[type]{.keyword} notation = [enum]{.type} [u8]{.type} {\
    GENERAL,\
    FIXED,\
    SCIENTIFIC,\
    E_UPPER,\
    E_LOWER,\
};

Specifies the notation used to format floating-point values.
:::

::: {.section .member}
#### [type prefix_kind]{.heading-body}[[\[permalink\]](#prefix_kind)]{.heading-extra} {#prefix_kind}

\
[type]{.keyword} prefix_kind = [enum]{.type} [i8]{.type} {\
    QUETTA,\
    RONNA,\
    YOTTA,\
    ZETTA,\
    EXA,\
    PETA,\
    TERA,\
    GIGA,\
    MEGA,\
    KILO,\
    HECTO,\
    DECA,\
    NONE,\
    DECI,\
    CENTI,\
    MILLI,\
    MICRO,\
    NANO,\
    PICO,\
    FEMTO,\
    ATTO,\
    ZEPTO,\
    YOCTO,\
    RONTO,\
    QUECTO,\
};

Unit prefix decimal exponents
:::

::: {.section .member}
#### [type quantity]{.heading-body}[[\[permalink\]](#quantity)]{.heading-extra} {#quantity}

\
[type]{.keyword} quantity = [struct]{.type} {\
    unit: [unit]{.type},\
    value: [f64]{.type},\
};

Represents a physical quantity as a unit and numerical value.
:::

::: {.section .member}
#### [type symbol_kind]{.heading-body}[[\[permalink\]](#symbol_kind)]{.heading-extra} {#symbol_kind}

\
[type]{.keyword} symbol_kind = [(]{.type}[prefix_kind]{.type} [\|]{.type} [unit_kind]{.type}[)]{.type};

Union of symbol enum types.
:::

::: {.section .member}
#### [type unit]{.heading-body}[[\[permalink\]](#unit)]{.heading-extra} {#unit}

\
[type]{.keyword} unit = [struct]{.type} {\
    dim: [dimension]{.type},\
    scale: [f64]{.type},\
};

Represents a unit of measurement by its physical
[dimension](#dimension){.ref} and scale.
:::

::: {.section .member}
#### [type token]{.heading-body}[[\[permalink\]](#token)]{.heading-extra} {#token}

Show undocumented member

\
[type]{.keyword} token = [struct]{.type} {\
    kind: [token_kind]{.type},\
    text: [str]{.type},\
    pos: [size]{.type},\
};
:::

::: {.section .member}
#### [type token_kind]{.heading-body}[[\[permalink\]](#token_kind)]{.heading-extra} {#token_kind}

Show undocumented member

\
[type]{.keyword} token_kind = [enum]{.type} [u8]{.type} {\
    UNSPECIFIED,\
    IDENTIFIER,\
    INTEGER,\
    SUPER_INTEGER,\
    MULTIPLY,\
    POWER,\
    SOLIDUS,\
    PLUS,\
    SUPER_PLUS,\
    MINUS,\
    SUPER_MINUS,\
    LPAREN,\
    RPAREN,\
    LBRACE,\
    RBRACE,\
    EXPONENT,\
    POINT,\
    COMMA,\
};
:::

::: {.section .member}
#### [type unit_kind]{.heading-body}[[\[permalink\]](#unit_kind)]{.heading-extra} {#unit_kind}

Show undocumented member

\
[type]{.keyword} unit_kind = [enum]{.type} {\
    NONE,\
    AMPERE,\
    ASTRONOMICAL_UNIT,\
    BECQUEREL,\
    BEL,\
    CANDELA,\
    COULOMB,\
    DALTON,\
    DAY,\
    DEGREE,\
    DEGREE_CELSIUS,\
    ELECTRONVOLT,\
    FARAD,\
    GAUSS,\
    GRAM,\
    GRAY,\
    HECTARE,\
    HENRY,\
    HERTZ,\
    HOUR,\
    JOULE,\
    KATAL,\
    KELVIN,\
    LITRE,\
    LUMEN,\
    LUX,\
    METRE,\
    MINUTE,\
    MOLE,\
    NEPER,\
    NEWTON,\
    OHM,\
    PASCAL,\
    RADIAN,\
    SECOND,\
    SIEMENS,\
    SIEVERT,\
    STERADIAN,\
    TESLA,\
    TONNE,\
    VOLT,\
    WATT,\
    WEBER,\
};
:::

### Errors

::: {.section .member}
#### [type dimension_mismatch]{.heading-body}[[\[permalink\]](#dimension_mismatch)]{.heading-extra} {#dimension_mismatch}

\
[type]{.keyword} dimension_mismatch = [!]{.type}[void]{.type};

The dimensions of two units or quantities do not match.
:::

::: {.section .member}
#### [type error]{.heading-body}[[\[permalink\]](#error)]{.heading-extra} {#error}

\
[type]{.keyword} error = [!]{.type}[(]{.type}[no_match]{.type} [\|]{.type} [invalid_exponent]{.type} [\|]{.type} [unexpected_token]{.type} [\|]{.type} [unclosed_scope]{.type} [\|]{.type} [invalid_token]{.type} [\|]{.type} [dimension_mismatch]{.type} [\|]{.type} [not_implemented]{.type} [\|]{.type} [invalid]{.type} [\|]{.type} [io]{.type}[::]{.type}[error]{.type} [\|]{.type} [strconv]{.type}[::]{.type}[invalid]{.type} [\|]{.type} [strconv]{.type}[::]{.type}[overflow]{.type} [\|]{.type} [utf8]{.type}[::]{.type}[invalid]{.type} [\|]{.type} [nomem]{.type}[)]{.type};

Represents any error that can occur in the si library
:::

::: {.section .member}
#### [type invalid]{.heading-body}[[\[permalink\]](#invalid)]{.heading-extra} {#invalid}

\
[type]{.keyword} invalid = [!]{.type}[void]{.type};

The input is invalid.
:::

::: {.section .member}
#### [type invalid_exponent]{.heading-body}[[\[permalink\]](#invalid_exponent)]{.heading-extra} {#invalid_exponent}

\
[type]{.keyword} invalid_exponent = [!]{.type}[void]{.type};

An invalid exponent was encountered.
:::

::: {.section .member}
#### [type no_match]{.heading-body}[[\[permalink\]](#no_match)]{.heading-extra} {#no_match}

\
[type]{.keyword} no_match = [!]{.type}[str]{.type};

No matching unit or prefix was found.
:::

::: {.section .member}
#### [type not_implemented]{.heading-body}[[\[permalink\]](#not_implemented)]{.heading-extra} {#not_implemented}

\
[type]{.keyword} not_implemented = [!]{.type}[void]{.type};

The requested operation is not implemented.
:::

::: {.section .member}
#### [type invalid_token]{.heading-body}[[\[permalink\]](#invalid_token)]{.heading-extra} {#invalid_token}

Show undocumented member

\
[type]{.keyword} invalid_token = [!]{.type}[token]{.type};
:::

::: {.section .member}
#### [type unclosed_scope]{.heading-body}[[\[permalink\]](#unclosed_scope)]{.heading-extra} {#unclosed_scope}

Show undocumented member

\
[type]{.keyword} unclosed_scope = [!]{.type}[void]{.type};
:::

::: {.section .member}
#### [type unexpected_token]{.heading-body}[[\[permalink\]](#unexpected_token)]{.heading-extra} {#unexpected_token}

Show undocumented member

\
[type]{.keyword} unexpected_token = [!]{.type}[token]{.type};
:::

### Constants

::: {.section .member}
#### [def ABSORBED_DOSE]{.heading-body}[[\[permalink\]](#ABSORBED_DOSE)]{.heading-extra} {#ABSORBED_DOSE}

\
[def]{.keyword} ABSORBED_DOSE = dimension {\
    length = 2,\
    time = -2,\
    \...\
};

The SI derived dimension of absorbed dose. Its SI unit is
[GRAY](#GRAY){.ref}.
:::

::: {.section .member}
#### [def ACTIVITY]{.heading-body}[[\[permalink\]](#ACTIVITY)]{.heading-extra} {#ACTIVITY}

\
[def]{.keyword} ACTIVITY = dimension {\
    time = -1,\
    \...\
};

The SI derived dimension of radioactive activity. Its SI unit is
[BECQUEREL](#BECQUEREL){.ref}.
:::

::: {.section .member}
#### [def ANGSTROM]{.heading-body}[[\[permalink\]](#ANGSTROM)]{.heading-extra} {#ANGSTROM}

\
[def]{.keyword} ANGSTROM = unit {\
    dim = LENGTH,\
    scale = 1.0e-10,\
};

The angstrom is a non-SI unit of length still widely used in the natural
sciences and technology to express atomic-scale lengths. See
[METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def ASTRONOMICAL_UNIT]{.heading-body}[[\[permalink\]](#ASTRONOMICAL_UNIT)]{.heading-extra} {#ASTRONOMICAL_UNIT}

\
[def]{.keyword} ASTRONOMICAL_UNIT = unit {\
    dim = LENGTH,\
    scale = 149597870700.0,\
};

The astronomical unit is a non-SI unit of length that approximately
equates to the average distance between the Sun and the Earth. As of
2012, it is standardised to a fixed length in metres. See
[METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def ATMOSPHERE]{.heading-body}[[\[permalink\]](#ATMOSPHERE)]{.heading-extra} {#ATMOSPHERE}

\
[def]{.keyword} ATMOSPHERE = unit {\
    dim = PRESSURE,\
    scale = 101325.0,\
};

The standard atmosphere is widely used in chemistry, physics, and
engineering as a reference pressure. See [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def AVOGADRO]{.heading-body}[[\[permalink\]](#AVOGADRO)]{.heading-extra} {#AVOGADRO}

\
[def]{.keyword} AVOGADRO = quantity {\
    unit = RECIPROCAL_MOLE,\
    value = 6.02214076e23,\
};

The Avogadro constant, an exact defining constant of the SI representing
the number of elementary entities in one mole. Its SI unit is
[RECIPROCAL_MOLE](#RECIPROCAL_MOLE){.ref}.
:::

::: {.section .member}
#### [def BAR]{.heading-body}[[\[permalink\]](#BAR)]{.heading-extra} {#BAR}

\
[def]{.keyword} BAR = unit {\
    dim = PRESSURE,\
    scale = 1.0e5,\
};

The bar is a metric unit of pressure commonly used in meteorology and
acoustics. Not to be confused with the CGS unit \'Barye\'.
:::

::: {.section .member}
#### [def BARN]{.heading-body}[[\[permalink\]](#BARN)]{.heading-extra} {#BARN}

\
[def]{.keyword} BARN = unit {\
    dim = AREA,\
    scale = 1.0e-28,\
};

The barn is commonly used in nuclear and particle physics to express
cross-sectional areas of atomic nuclei and subatomic interactions.
:::

::: {.section .member}
#### [def BEL]{.heading-body}[[\[permalink\]](#BEL)]{.heading-extra} {#BEL}

\
[def]{.keyword} BEL = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

The bel is a non-SI relative logarithmic unit commonly used in
acoustics, telecommunications, and signal processing to express ratios
of power quantities. This unit is dimensionless and does not support
conversion. See also: [NEPER](#NEPER){.ref}.
:::

::: {.section .member}
#### [def BOLTZMANN]{.heading-body}[[\[permalink\]](#BOLTZMANN)]{.heading-extra} {#BOLTZMANN}

\
[def]{.keyword} BOLTZMANN = quantity {\
    unit = JOULE_PER_KELVIN,\
    value = 1.380649e-23,\
};

The Boltzmann constant, an exact defining constant of the SI relating
thermal energy to thermodynamic temperature. Its SI unit is
[JOULE_PER_KELVIN](#JOULE_PER_KELVIN){.ref}.
:::

::: {.section .member}
#### [def CALORIE]{.heading-body}[[\[permalink\]](#CALORIE)]{.heading-extra} {#CALORIE}

\
[def]{.keyword} CALORIE = unit {\
    dim = ENERGY,\
    scale = 4.184,\
};

The calorie is non-SI unit commonly used in thermodynamics, chemistry,
and nutritional science to express energy. See [JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def CAPACITANCE]{.heading-body}[[\[permalink\]](#CAPACITANCE)]{.heading-extra} {#CAPACITANCE}

\
[def]{.keyword} CAPACITANCE = dimension {\
    mass = -1,\
    length = -2,\
    time = 4,\
    current = 2,\
    \...\
};

The SI derived dimension of capacitance. Its SI unit is
[FARAD](#FARAD){.ref}.
:::

::: {.section .member}
#### [def CATALYTIC_ACTIVITY]{.heading-body}[[\[permalink\]](#CATALYTIC_ACTIVITY)]{.heading-extra} {#CATALYTIC_ACTIVITY}

\
[def]{.keyword} CATALYTIC_ACTIVITY = dimension {\
    time = -1,\
    substance = 1,\
    \...\
};

The SI derived dimension of catalytic activity. Its SI unit is
[KATAL](#KATAL){.ref}.
:::

::: {.section .member}
#### [def CENTIMETRE]{.heading-body}[[\[permalink\]](#CENTIMETRE)]{.heading-extra} {#CENTIMETRE}

\
[def]{.keyword} CENTIMETRE = unit {\
    dim = LENGTH,\
    scale = 0.01,\
};

The centimetre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def CONDUCTANCE]{.heading-body}[[\[permalink\]](#CONDUCTANCE)]{.heading-extra} {#CONDUCTANCE}

\
[def]{.keyword} CONDUCTANCE = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    current = 2,\
    \...\
};

The SI derived dimension of electrical conductance. Its SI unit is
[SIEMENS](#SIEMENS){.ref}.
:::

::: {.section .member}
#### [def CUBIC_CENTIMETRE]{.heading-body}[[\[permalink\]](#CUBIC_CENTIMETRE)]{.heading-extra} {#CUBIC_CENTIMETRE}

\
[def]{.keyword} CUBIC_CENTIMETRE = unit {\
    dim = VOLUME,\
    scale = 1.0e-6,\
};

The cubic centimetre is a scaled SI unit of volume. The corresponding
unscaled SI unit is the [CUBIC_METRE](#CUBIC_METRE){.ref}.
:::

::: {.section .member}
#### [def CUBIC_MILLIMETRE]{.heading-body}[[\[permalink\]](#CUBIC_MILLIMETRE)]{.heading-extra} {#CUBIC_MILLIMETRE}

\
[def]{.keyword} CUBIC_MILLIMETRE = unit {\
    dim = VOLUME,\
    scale = 1.0e-9,\
};

The cubic millimetre is a scaled SI unit of volume. The corresponding
unscaled SI unit is the [CUBIC_METRE](#CUBIC_METRE){.ref}.
:::

::: {.section .member}
#### [def CURIE]{.heading-body}[[\[permalink\]](#CURIE)]{.heading-extra} {#CURIE}

\
[def]{.keyword} CURIE = unit {\
    dim = ACTIVITY,\
    scale = 3.7e10,\
};

The curie is a non-SI unit historically used in nuclear physics to
express radioactivity. See [BECQUEREL](#BECQUEREL){.ref}.
:::

::: {.section .member}
#### [def CURRENT]{.heading-body}[[\[permalink\]](#CURRENT)]{.heading-extra} {#CURRENT}

\
[def]{.keyword} CURRENT = dimension {\
    current = 1,\
    \...\
};

The SI base dimension of electric current.
:::

::: {.section .member}
#### [def DALTON]{.heading-body}[[\[permalink\]](#DALTON)]{.heading-extra} {#DALTON}

\
[def]{.keyword} DALTON = unit {\
    dim = MASS,\
    scale = 1.66053906892e-27,\
};

The dalton
:::

::: {.section .member}
#### [def DAY]{.heading-body}[[\[permalink\]](#DAY)]{.heading-extra} {#DAY}

\
[def]{.keyword} DAY = unit {\
    dim = TIME,\
    scale = 86400.0,\
};

The day is a non-SI unit of time. See [SECOND](#SECOND){.ref}.
:::

::: {.section .member}
#### [def DECAMETRE]{.heading-body}[[\[permalink\]](#DECAMETRE)]{.heading-extra} {#DECAMETRE}

\
[def]{.keyword} DECAMETRE = unit {\
    dim = LENGTH,\
    scale = 10.0,\
};

The decametre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def DECIMETRE]{.heading-body}[[\[permalink\]](#DECIMETRE)]{.heading-extra} {#DECIMETRE}

\
[def]{.keyword} DECIMETRE = unit {\
    dim = LENGTH,\
    scale = 0.1,\
};

The decimetre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def DEGREE]{.heading-body}[[\[permalink\]](#DEGREE)]{.heading-extra} {#DEGREE}

\
[def]{.keyword} DEGREE = unit {\
    dim = DIMENSIONLESS,\
    scale = 0.017453292519943295,\
};

The degree
:::

::: {.section .member}
#### [def DIMENSIONLESS]{.heading-body}[[\[permalink\]](#DIMENSIONLESS)]{.heading-extra} {#DIMENSIONLESS}

\
[def]{.keyword} DIMENSIONLESS = dimension {\
    \...\
};

The dimensionless dimension, with all SI base dimension exponents equal
to zero.
:::

::: {.section .member}
#### [def DOSE_EQUIVALENT]{.heading-body}[[\[permalink\]](#DOSE_EQUIVALENT)]{.heading-extra} {#DOSE_EQUIVALENT}

\
[def]{.keyword} DOSE_EQUIVALENT = dimension {\
    length = 2,\
    time = -2,\
    \...\
};

The SI derived dimension of dose equivalent. Its SI unit is
[SIEVERT](#SIEVERT){.ref}.
:::

::: {.section .member}
#### [def DYNAMIC_VISCOSITY]{.heading-body}[[\[permalink\]](#DYNAMIC_VISCOSITY)]{.heading-extra} {#DYNAMIC_VISCOSITY}

\
[def]{.keyword} DYNAMIC_VISCOSITY = dimension {\
    mass = 1,\
    length = -1,\
    time = -1,\
    \...\
};

The SI derived dimension of dynamic viscosity. Its SI unit is
[PASCAL_SECOND](#PASCAL_SECOND){.ref}.
:::

::: {.section .member}
#### [def DYNE]{.heading-body}[[\[permalink\]](#DYNE)]{.heading-extra} {#DYNE}

\
[def]{.keyword} DYNE = unit {\
    dim = FORCE,\
    scale = 1.0e-5,\
};

The dyne is a CGS unit used in mechanics and fluid dynamics to express
force. See [NEWTON](#NEWTON){.ref}.
:::

::: {.section .member}
#### [def ELECTRIC_CHARGE]{.heading-body}[[\[permalink\]](#ELECTRIC_CHARGE)]{.heading-extra} {#ELECTRIC_CHARGE}

\
[def]{.keyword} ELECTRIC_CHARGE = dimension {\
    time = 1,\
    current = 1,\
    \...\
};

The SI derived dimension of electric charge. Its SI unit is
[COULOMB](#COULOMB){.ref}.
:::

::: {.section .member}
#### [def ELECTRIC_POTENTIAL]{.heading-body}[[\[permalink\]](#ELECTRIC_POTENTIAL)]{.heading-extra} {#ELECTRIC_POTENTIAL}

\
[def]{.keyword} ELECTRIC_POTENTIAL = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -1,\
    \...\
};

The SI derived dimension of electric potential. Its SI unit is
[VOLT](#VOLT){.ref}.
:::

::: {.section .member}
#### [def ELECTRONVOLT]{.heading-body}[[\[permalink\]](#ELECTRONVOLT)]{.heading-extra} {#ELECTRONVOLT}

\
[def]{.keyword} ELECTRONVOLT = unit {\
    dim = ENERGY,\
    scale = 1.602176634e-19,\
};

The electronvolt
:::

::: {.section .member}
#### [def ELEMENTARY_CHARGE]{.heading-body}[[\[permalink\]](#ELEMENTARY_CHARGE)]{.heading-extra} {#ELEMENTARY_CHARGE}

\
[def]{.keyword} ELEMENTARY_CHARGE = quantity {\
    unit = COULOMB,\
    value = 1.602176634e-19,\
};

The elementary charge, an exact defining constant of the SI
corresponding to the magnitude of the electric charge of a proton. Its
SI unit is [COULOMB](#COULOMB){.ref}.
:::

::: {.section .member}
#### [def ENERGY]{.heading-body}[[\[permalink\]](#ENERGY)]{.heading-extra} {#ENERGY}

\
[def]{.keyword} ENERGY = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    \...\
};

The SI derived dimension of energy. Its SI unit is
[JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def ERG]{.heading-body}[[\[permalink\]](#ERG)]{.heading-extra} {#ERG}

\
[def]{.keyword} ERG = unit {\
    dim = ENERGY,\
    scale = 1.0e-7,\
};

The erg is a CGS unit commonly used in classical mechanics,
astrophysics, and other areas of physics to express energy. The SI
counterpart unit is the [JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def EXPOSURE]{.heading-body}[[\[permalink\]](#EXPOSURE)]{.heading-extra} {#EXPOSURE}

\
[def]{.keyword} EXPOSURE = dimension {\
    mass = -1,\
    time = 1,\
    current = 1,\
    \...\
};

The SI derived dimension of exposure to ionising radiation. Its SI unit
is [COULOMB_PER_KILOGRAM](#COULOMB_PER_KILOGRAM){.ref}.
:::

::: {.section .member}
#### [def FORCE]{.heading-body}[[\[permalink\]](#FORCE)]{.heading-extra} {#FORCE}

\
[def]{.keyword} FORCE = dimension {\
    mass = 1,\
    length = 1,\
    time = -2,\
    \...\
};

The SI derived dimension of force. Its SI unit is
[NEWTON](#NEWTON){.ref}.
:::

::: {.section .member}
#### [def FREQUENCY]{.heading-body}[[\[permalink\]](#FREQUENCY)]{.heading-extra} {#FREQUENCY}

\
[def]{.keyword} FREQUENCY = dimension {\
    time = -1,\
    \...\
};

The SI derived dimension of frequency. Its SI unit is
[HERTZ](#HERTZ){.ref}.
:::

::: {.section .member}
#### [def GAL]{.heading-body}[[\[permalink\]](#GAL)]{.heading-extra} {#GAL}

\
[def]{.keyword} GAL = unit {\
    dim = ACCELERATION,\
    scale = 0.01,\
};

The gal is a CGS unit commonly used in geophysics and gravimetry to
express acceleration. The SI counterpart unit is the
[METRE_PER_SECOND_SQUARED](#METRE_PER_SECOND_SQUARED){.ref}
:::

::: {.section .member}
#### [def GAUSS]{.heading-body}[[\[permalink\]](#GAUSS)]{.heading-extra} {#GAUSS}

\
[def]{.keyword} GAUSS = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-4,\
};

The gauss is a CGS unit commonly used in physics and engineering to
express magnetic flux density. The SI counterpart unit is the
[TESLA](#TESLA){.ref}
:::

::: {.section .member}
#### [def GIGAHERTZ]{.heading-body}[[\[permalink\]](#GIGAHERTZ)]{.heading-extra} {#GIGAHERTZ}

\
[def]{.keyword} GIGAHERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0e9,\
};

The gigahertz is a scaled SI unit of frequency. The corresponding
unscaled SI unit is the [HERTZ](#HERTZ){.ref}.
:::

::: {.section .member}
#### [def GIGAJOULE]{.heading-body}[[\[permalink\]](#GIGAJOULE)]{.heading-extra} {#GIGAJOULE}

\
[def]{.keyword} GIGAJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e9,\
};

The gigajoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the [JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def GIGAPASCAL]{.heading-body}[[\[permalink\]](#GIGAPASCAL)]{.heading-extra} {#GIGAPASCAL}

\
[def]{.keyword} GIGAPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e9,\
};

The gigapascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def GIGAWATT]{.heading-body}[[\[permalink\]](#GIGAWATT)]{.heading-extra} {#GIGAWATT}

\
[def]{.keyword} GIGAWATT = unit {\
    dim = POWER,\
    scale = 1.0e9,\
};

The gigawatt is a scaled SI unit of power. The corresponding unscaled SI
unit is the [WATT](#WATT){.ref}.
:::

::: {.section .member}
#### [def GRAM]{.heading-body}[[\[permalink\]](#GRAM)]{.heading-extra} {#GRAM}

\
[def]{.keyword} GRAM = unit {\
    dim = MASS,\
    scale = 1.0e-3,\
};

The gram is a scaled SI unit of mass. The corresponding unscaled SI unit
is the [KILOGRAM](#KILOGRAM){.ref}.
:::

::: {.section .member}
#### [def HECTARE]{.heading-body}[[\[permalink\]](#HECTARE)]{.heading-extra} {#HECTARE}

\
[def]{.keyword} HECTARE = unit {\
    dim = AREA,\
    scale = 1.0e4,\
};

The hectare is non-SI metric unit commonly used to express areas of
land. The SI counterpart unit is the [SQUARE_METRE](#SQUARE_METRE){.ref}
:::

::: {.section .member}
#### [def HECTOMETRE]{.heading-body}[[\[permalink\]](#HECTOMETRE)]{.heading-extra} {#HECTOMETRE}

\
[def]{.keyword} HECTOMETRE = unit {\
    dim = LENGTH,\
    scale = 100.0,\
};

The hectometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def HECTOPASCAL]{.heading-body}[[\[permalink\]](#HECTOPASCAL)]{.heading-extra} {#HECTOPASCAL}

\
[def]{.keyword} HECTOPASCAL = unit {\
    dim = PRESSURE,\
    scale = 100.0,\
};

The hectopascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def HOUR]{.heading-body}[[\[permalink\]](#HOUR)]{.heading-extra} {#HOUR}

\
[def]{.keyword} HOUR = unit {\
    dim = TIME,\
    scale = 3600.0,\
};

The hour is non-SI unit of time. The SI counterpart unit is the
[SECOND](#SECOND){.ref}
:::

::: {.section .member}
#### [def HYPERFINE_TRANSITION_CAESIUM_133]{.heading-body}[[\[permalink\]](#HYPERFINE_TRANSITION_CAESIUM_133)]{.heading-extra} {#HYPERFINE_TRANSITION_CAESIUM_133}

\
[def]{.keyword} HYPERFINE_TRANSITION_CAESIUM_133 = quantity {\
    unit = HERTZ,\
    value = 9192631770.0,\
};

The caesium-133 hyperfine transition frequency, which defines the SI
second. Its SI unit is [HERTZ](#HERTZ){.ref}.
:::

::: {.section .member}
#### [def ILLUMINANCE]{.heading-body}[[\[permalink\]](#ILLUMINANCE)]{.heading-extra} {#ILLUMINANCE}

\
[def]{.keyword} ILLUMINANCE = dimension {\
    length = -2,\
    luminosity = 1,\
    \...\
};

The SI derived dimension of illuminance. Its SI unit is
[LUX](#LUX){.ref}.
:::

::: {.section .member}
#### [def INDUCTANCE]{.heading-body}[[\[permalink\]](#INDUCTANCE)]{.heading-extra} {#INDUCTANCE}

\
[def]{.keyword} INDUCTANCE = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -2,\
    \...\
};

The SI derived dimension of inductance. Its SI unit is
[HENRY](#HENRY){.ref}.
:::

::: {.section .member}
#### [def JOULE_PER_KELVIN]{.heading-body}[[\[permalink\]](#JOULE_PER_KELVIN)]{.heading-extra} {#JOULE_PER_KELVIN}

\
[def]{.keyword} JOULE_PER_KELVIN = unit {\
    dim = ENTROPY,\
    scale = 1.0,\
};

The joule per kelvin is the coherent SI unit of
[ENTROPY](#ENTROPY){.ref}.
:::

::: {.section .member}
#### [def JOULE_SECOND]{.heading-body}[[\[permalink\]](#JOULE_SECOND)]{.heading-extra} {#JOULE_SECOND}

\
[def]{.keyword} JOULE_SECOND = unit {\
    dim = ACTION,\
    scale = 1.0,\
};

The joule-second is the coherent SI unit of [ACTION](#ACTION){.ref}.
:::

::: {.section .member}
#### [def KILOHERTZ]{.heading-body}[[\[permalink\]](#KILOHERTZ)]{.heading-extra} {#KILOHERTZ}

\
[def]{.keyword} KILOHERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0e3,\
};

The kilohertz is a scaled SI unit of frequency. The corresponding
unscaled SI unit is the [HERTZ](#HERTZ){.ref}.
:::

::: {.section .member}
#### [def KILOJOULE]{.heading-body}[[\[permalink\]](#KILOJOULE)]{.heading-extra} {#KILOJOULE}

\
[def]{.keyword} KILOJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e3,\
};

The kilojoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the [JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def KILOMETRE]{.heading-body}[[\[permalink\]](#KILOMETRE)]{.heading-extra} {#KILOMETRE}

\
[def]{.keyword} KILOMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e3,\
};

The kilometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def KILONEWTON]{.heading-body}[[\[permalink\]](#KILONEWTON)]{.heading-extra} {#KILONEWTON}

\
[def]{.keyword} KILONEWTON = unit {\
    dim = FORCE,\
    scale = 1.0e3,\
};

The kilonewton is a scaled SI unit of force. The corresponding unscaled
SI unit is the [NEWTON](#NEWTON){.ref}.
:::

::: {.section .member}
#### [def KILOOHM]{.heading-body}[[\[permalink\]](#KILOOHM)]{.heading-extra} {#KILOOHM}

\
[def]{.keyword} KILOOHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0e3,\
};

The kiloohm is a scaled SI unit of electrical resistance. The
corresponding unscaled SI unit is the [OHM](#OHM){.ref}.
:::

::: {.section .member}
#### [def KILOPASCAL]{.heading-body}[[\[permalink\]](#KILOPASCAL)]{.heading-extra} {#KILOPASCAL}

\
[def]{.keyword} KILOPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e3,\
};

The kilopascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def KILOVOLT]{.heading-body}[[\[permalink\]](#KILOVOLT)]{.heading-extra} {#KILOVOLT}

\
[def]{.keyword} KILOVOLT = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e3,\
};

The kilovolt is a scaled SI unit of electric potential. The
corresponding unscaled SI unit is the [VOLT](#VOLT){.ref}.
:::

::: {.section .member}
#### [def KILOWATT]{.heading-body}[[\[permalink\]](#KILOWATT)]{.heading-extra} {#KILOWATT}

\
[def]{.keyword} KILOWATT = unit {\
    dim = POWER,\
    scale = 1.0e3,\
};

The kilowatt is a scaled SI unit of power. The corresponding unscaled SI
unit is the [WATT](#WATT){.ref}.
:::

::: {.section .member}
#### [def KINEMATIC_VISCOSITY]{.heading-body}[[\[permalink\]](#KINEMATIC_VISCOSITY)]{.heading-extra} {#KINEMATIC_VISCOSITY}

\
[def]{.keyword} KINEMATIC_VISCOSITY = dimension {\
    length = 2,\
    time = -1,\
    \...\
};

The SI derived dimension of kinematic viscosity. Its SI unit is
[SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND){.ref}.
:::

::: {.section .member}
#### [def LENGTH]{.heading-body}[[\[permalink\]](#LENGTH)]{.heading-extra} {#LENGTH}

\
[def]{.keyword} LENGTH = dimension {\
    length = 1,\
    \...\
};

The SI base dimension of length.
:::

::: {.section .member}
#### [def LITRE]{.heading-body}[[\[permalink\]](#LITRE)]{.heading-extra} {#LITRE}

\
[def]{.keyword} LITRE = unit {\
    dim = VOLUME,\
    scale = 1.0e-3,\
};

The litre is a non-SI metric unit of volume in common general use. See
[CUBIC_METRE](#CUBIC_METRE){.ref}.
:::

::: {.section .member}
#### [def LUMINOSITY]{.heading-body}[[\[permalink\]](#LUMINOSITY)]{.heading-extra} {#LUMINOSITY}

\
[def]{.keyword} LUMINOSITY = dimension {\
    luminosity = 1,\
    \...\
};

The SI base dimension of luminous intensity.
:::

::: {.section .member}
#### [def LUMINOUS_EFFICACY_540_THZ]{.heading-body}[[\[permalink\]](#LUMINOUS_EFFICACY_540_THZ)]{.heading-extra} {#LUMINOUS_EFFICACY_540_THZ}

\
[def]{.keyword} LUMINOUS_EFFICACY_540_THZ = quantity {\
    unit = LUMEN_PER_WATT,\
    value = 683.0,\
};

The luminous efficacy of monochromatic radiation at 540 THz, an exact
defining constant of the SI for
[LUMINOUS_EFFICACY](#LUMINOUS_EFFICACY){.ref}. Its SI unit is
[LUMEN_PER_WATT](#LUMEN_PER_WATT){.ref}.
:::

::: {.section .member}
#### [def LUMINOUS_FLUX]{.heading-body}[[\[permalink\]](#LUMINOUS_FLUX)]{.heading-extra} {#LUMINOUS_FLUX}

\
[def]{.keyword} LUMINOUS_FLUX = dimension {\
    luminosity = 1,\
    \...\
};

The SI derived dimension of luminous flux. Its SI unit is
[LUMEN](#LUMEN){.ref}.
:::

::: {.section .member}
#### [def MAGNETIC_FLUX]{.heading-body}[[\[permalink\]](#MAGNETIC_FLUX)]{.heading-extra} {#MAGNETIC_FLUX}

\
[def]{.keyword} MAGNETIC_FLUX = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -1,\
    \...\
};

The SI derived dimension of magnetic flux. Its SI unit is
[WEBER](#WEBER){.ref}.
:::

::: {.section .member}
#### [def MAGNETIC_FLUX_DENSITY]{.heading-body}[[\[permalink\]](#MAGNETIC_FLUX_DENSITY)]{.heading-extra} {#MAGNETIC_FLUX_DENSITY}

\
[def]{.keyword} MAGNETIC_FLUX_DENSITY = dimension {\
    mass = 1,\
    time = -2,\
    current = -1,\
    \...\
};

The SI derived dimension of magnetic flux density. Its SI unit is
[TESLA](#TESLA){.ref}.
:::

::: {.section .member}
#### [def MASS]{.heading-body}[[\[permalink\]](#MASS)]{.heading-extra} {#MASS}

\
[def]{.keyword} MASS = dimension {\
    mass = 1,\
    \...\
};

The SI base dimension of mass.
:::

::: {.section .member}
#### [def MAXWELL]{.heading-body}[[\[permalink\]](#MAXWELL)]{.heading-extra} {#MAXWELL}

\
[def]{.keyword} MAXWELL = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-8,\
};

The maxwell is a CGS electromagnetic unit used to express magnetic flux.
The SI counterpart unit is the [WEBER](#WEBER){.ref}
:::

::: {.section .member}
#### [def MEGAHERTZ]{.heading-body}[[\[permalink\]](#MEGAHERTZ)]{.heading-extra} {#MEGAHERTZ}

\
[def]{.keyword} MEGAHERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0e6,\
};

The megahertz is a scaled SI unit of frequency. The corresponding
unscaled SI unit is the [HERTZ](#HERTZ){.ref}.
:::

::: {.section .member}
#### [def MEGAJOULE]{.heading-body}[[\[permalink\]](#MEGAJOULE)]{.heading-extra} {#MEGAJOULE}

\
[def]{.keyword} MEGAJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e6,\
};

The megajoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the [JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def MEGANEWTON]{.heading-body}[[\[permalink\]](#MEGANEWTON)]{.heading-extra} {#MEGANEWTON}

\
[def]{.keyword} MEGANEWTON = unit {\
    dim = FORCE,\
    scale = 1.0e6,\
};

The meganewton is a scaled SI unit of force. The corresponding unscaled
SI unit is the [NEWTON](#NEWTON){.ref}.
:::

::: {.section .member}
#### [def MEGAOHM]{.heading-body}[[\[permalink\]](#MEGAOHM)]{.heading-extra} {#MEGAOHM}

\
[def]{.keyword} MEGAOHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0e6,\
};

The megaohm is a scaled SI unit of electrical resistance. The
corresponding unscaled SI unit is the [OHM](#OHM){.ref}.
:::

::: {.section .member}
#### [def MEGAPASCAL]{.heading-body}[[\[permalink\]](#MEGAPASCAL)]{.heading-extra} {#MEGAPASCAL}

\
[def]{.keyword} MEGAPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e6,\
};

The megapascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def MEGAWATT]{.heading-body}[[\[permalink\]](#MEGAWATT)]{.heading-extra} {#MEGAWATT}

\
[def]{.keyword} MEGAWATT = unit {\
    dim = POWER,\
    scale = 1.0e6,\
};

The megawatt is a scaled SI unit of power. The corresponding unscaled SI
unit is the [WATT](#WATT){.ref}.
:::

::: {.section .member}
#### [def MICROAMPERE]{.heading-body}[[\[permalink\]](#MICROAMPERE)]{.heading-extra} {#MICROAMPERE}

\
[def]{.keyword} MICROAMPERE = unit {\
    dim = CURRENT,\
    scale = 1.0e-6,\
};

The microampere is a scaled SI unit of electric current. The
corresponding unscaled SI unit is the [AMPERE](#AMPERE){.ref}.
:::

::: {.section .member}
#### [def MICROCOULOMB]{.heading-body}[[\[permalink\]](#MICROCOULOMB)]{.heading-extra} {#MICROCOULOMB}

\
[def]{.keyword} MICROCOULOMB = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-6,\
};

The microcoulomb is a scaled SI unit of electric charge. The
corresponding unscaled SI unit is the [COULOMB](#COULOMB){.ref}.
:::

::: {.section .member}
#### [def MICROFARAD]{.heading-body}[[\[permalink\]](#MICROFARAD)]{.heading-extra} {#MICROFARAD}

\
[def]{.keyword} MICROFARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-6,\
};

The microfarad is a scaled SI unit of capacitance. The corresponding
unscaled SI unit is the [FARAD](#FARAD){.ref}.
:::

::: {.section .member}
#### [def MICROGRAM]{.heading-body}[[\[permalink\]](#MICROGRAM)]{.heading-extra} {#MICROGRAM}

\
[def]{.keyword} MICROGRAM = unit {\
    dim = MASS,\
    scale = 1.0e-9,\
};

The microgram is a scaled SI unit of mass. The corresponding unscaled SI
unit is the [KILOGRAM](#KILOGRAM){.ref}.
:::

::: {.section .member}
#### [def MICROMETRE]{.heading-body}[[\[permalink\]](#MICROMETRE)]{.heading-extra} {#MICROMETRE}

\
[def]{.keyword} MICROMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-6,\
};

The micrometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def MICRON]{.heading-body}[[\[permalink\]](#MICRON)]{.heading-extra} {#MICRON}

\
[def]{.keyword} MICRON = MICROMETRE;

The micron is an alternative name for the
[MICROMETRE](#MICROMETRE){.ref}.
:::

::: {.section .member}
#### [def MICROSECOND]{.heading-body}[[\[permalink\]](#MICROSECOND)]{.heading-extra} {#MICROSECOND}

\
[def]{.keyword} MICROSECOND = unit {\
    dim = TIME,\
    scale = 1.0e-6,\
};

The microsecond is a scaled SI unit of time. The corresponding unscaled
SI unit is the [SECOND](#SECOND){.ref}.
:::

::: {.section .member}
#### [def MICROTESLA]{.heading-body}[[\[permalink\]](#MICROTESLA)]{.heading-extra} {#MICROTESLA}

\
[def]{.keyword} MICROTESLA = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-6,\
};

The microtesla is a scaled SI unit of magnetic flux density. The
corresponding unscaled SI unit is the [TESLA](#TESLA){.ref}.
:::

::: {.section .member}
#### [def MILLIAMPERE]{.heading-body}[[\[permalink\]](#MILLIAMPERE)]{.heading-extra} {#MILLIAMPERE}

\
[def]{.keyword} MILLIAMPERE = unit {\
    dim = CURRENT,\
    scale = 1.0e-3,\
};

The milliampere is a scaled SI unit of electric current. The
corresponding unscaled SI unit is the [AMPERE](#AMPERE){.ref}.
:::

::: {.section .member}
#### [def MILLICOULOMB]{.heading-body}[[\[permalink\]](#MILLICOULOMB)]{.heading-extra} {#MILLICOULOMB}

\
[def]{.keyword} MILLICOULOMB = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-3,\
};

The millicoulomb is a scaled SI unit of electric charge. The
corresponding unscaled SI unit is the [COULOMB](#COULOMB){.ref}.
:::

::: {.section .member}
#### [def MILLIGRAM]{.heading-body}[[\[permalink\]](#MILLIGRAM)]{.heading-extra} {#MILLIGRAM}

\
[def]{.keyword} MILLIGRAM = unit {\
    dim = MASS,\
    scale = 1.0e-6,\
};

The milligram is a scaled SI unit of mass. The corresponding unscaled SI
unit is the [KILOGRAM](#KILOGRAM){.ref}.
:::

::: {.section .member}
#### [def MILLIJOULE]{.heading-body}[[\[permalink\]](#MILLIJOULE)]{.heading-extra} {#MILLIJOULE}

\
[def]{.keyword} MILLIJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e-3,\
};

The millijoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the [JOULE](#JOULE){.ref}.
:::

::: {.section .member}
#### [def MILLIMETRE]{.heading-body}[[\[permalink\]](#MILLIMETRE)]{.heading-extra} {#MILLIMETRE}

\
[def]{.keyword} MILLIMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-3,\
};

The millimetre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def MILLIMETRES_OF_MERCURY]{.heading-body}[[\[permalink\]](#MILLIMETRES_OF_MERCURY)]{.heading-extra} {#MILLIMETRES_OF_MERCURY}

\
[def]{.keyword} MILLIMETRES_OF_MERCURY = unit {\
    dim = PRESSURE,\
    scale = 133.322,\
};

Millimetres of mercury are widely used in medicine and meteorology to
express pressure. The SI counterpart unit is the [PASCAL](#PASCAL){.ref}
:::

::: {.section .member}
#### [def MILLINEWTON]{.heading-body}[[\[permalink\]](#MILLINEWTON)]{.heading-extra} {#MILLINEWTON}

\
[def]{.keyword} MILLINEWTON = unit {\
    dim = FORCE,\
    scale = 1.0e-3,\
};

The millinewton is a scaled SI unit of force. The corresponding unscaled
SI unit is the [NEWTON](#NEWTON){.ref}.
:::

::: {.section .member}
#### [def MILLIOHM]{.heading-body}[[\[permalink\]](#MILLIOHM)]{.heading-extra} {#MILLIOHM}

\
[def]{.keyword} MILLIOHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0e-3,\
};

The milliohm is a scaled SI unit of electrical resistance. The
corresponding unscaled SI unit is the [OHM](#OHM){.ref}.
:::

::: {.section .member}
#### [def MILLIPASCAL]{.heading-body}[[\[permalink\]](#MILLIPASCAL)]{.heading-extra} {#MILLIPASCAL}

\
[def]{.keyword} MILLIPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e-3,\
};

The millipascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def MILLIPASCAL_SECOND]{.heading-body}[[\[permalink\]](#MILLIPASCAL_SECOND)]{.heading-extra} {#MILLIPASCAL_SECOND}

\
[def]{.keyword} MILLIPASCAL_SECOND = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0e-3,\
};

The millipascal-second is a scaled SI unit of dynamic viscosity. The
corresponding unscaled SI unit is the
[PASCAL_SECOND](#PASCAL_SECOND){.ref}.
:::

::: {.section .member}
#### [def MILLISECOND]{.heading-body}[[\[permalink\]](#MILLISECOND)]{.heading-extra} {#MILLISECOND}

\
[def]{.keyword} MILLISECOND = unit {\
    dim = TIME,\
    scale = 1.0e-3,\
};

The millisecond is a scaled SI unit of time. The corresponding unscaled
SI unit is the [SECOND](#SECOND){.ref}.
:::

::: {.section .member}
#### [def MILLITESLA]{.heading-body}[[\[permalink\]](#MILLITESLA)]{.heading-extra} {#MILLITESLA}

\
[def]{.keyword} MILLITESLA = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-3,\
};

The millitesla is a scaled SI unit of magnetic flux density. The
corresponding unscaled SI unit is the [TESLA](#TESLA){.ref}.
:::

::: {.section .member}
#### [def MILLIVOLT]{.heading-body}[[\[permalink\]](#MILLIVOLT)]{.heading-extra} {#MILLIVOLT}

\
[def]{.keyword} MILLIVOLT = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e-3,\
};

The millivolt is a scaled SI unit of electric potential. The
corresponding unscaled SI unit is the [VOLT](#VOLT){.ref}.
:::

::: {.section .member}
#### [def MILLIWATT]{.heading-body}[[\[permalink\]](#MILLIWATT)]{.heading-extra} {#MILLIWATT}

\
[def]{.keyword} MILLIWATT = unit {\
    dim = POWER,\
    scale = 1.0e-3,\
};

The milliwatt is a scaled SI unit of power. The corresponding unscaled
SI unit is the [WATT](#WATT){.ref}.
:::

::: {.section .member}
#### [def MILLIWEBER]{.heading-body}[[\[permalink\]](#MILLIWEBER)]{.heading-extra} {#MILLIWEBER}

\
[def]{.keyword} MILLIWEBER = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-3,\
};

The milliweber is a scaled SI unit of magnetic flux. The corresponding
unscaled SI unit is the [WEBER](#WEBER){.ref}.
:::

::: {.section .member}
#### [def MINUTE]{.heading-body}[[\[permalink\]](#MINUTE)]{.heading-extra} {#MINUTE}

\
[def]{.keyword} MINUTE = unit {\
    dim = TIME,\
    scale = 60.0,\
};

The minute is non-SI unit of time. The SI counterpart unit is the
[SECOND](#SECOND){.ref}
:::

::: {.section .member}
#### [def NANOFARAD]{.heading-body}[[\[permalink\]](#NANOFARAD)]{.heading-extra} {#NANOFARAD}

\
[def]{.keyword} NANOFARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-9,\
};

The nanofarad is a scaled SI unit of capacitance. The corresponding
unscaled SI unit is the [FARAD](#FARAD){.ref}.
:::

::: {.section .member}
#### [def NANOMETRE]{.heading-body}[[\[permalink\]](#NANOMETRE)]{.heading-extra} {#NANOMETRE}

\
[def]{.keyword} NANOMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-9,\
};

The nanometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def NANOSECOND]{.heading-body}[[\[permalink\]](#NANOSECOND)]{.heading-extra} {#NANOSECOND}

\
[def]{.keyword} NANOSECOND = unit {\
    dim = TIME,\
    scale = 1.0e-9,\
};

The nanosecond is a scaled SI unit of time. The corresponding unscaled
SI unit is the [SECOND](#SECOND){.ref}.
:::

::: {.section .member}
#### [def NEPER]{.heading-body}[[\[permalink\]](#NEPER)]{.heading-extra} {#NEPER}

\
[def]{.keyword} NEPER = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

The neper is a non-SI relative logarithmic unit used in acoustics,
telecommunications, and signal processing to express ratios of field
quantities. This unit is dimensionless and does not support conversion.
See also: [BEL](#BEL){.ref}.
:::

::: {.section .member}
#### [def NEWTON_METRE]{.heading-body}[[\[permalink\]](#NEWTON_METRE)]{.heading-extra} {#NEWTON_METRE}

\
[def]{.keyword} NEWTON_METRE = unit {\
    dim = TORQUE,\
    scale = 1.0,\
};

The newton-metre is the coherent SI unit of [TORQUE](#TORQUE){.ref}.
:::

::: {.section .member}
#### [def NEWTON_PER_METRE]{.heading-body}[[\[permalink\]](#NEWTON_PER_METRE)]{.heading-extra} {#NEWTON_PER_METRE}

\
[def]{.keyword} NEWTON_PER_METRE = unit {\
    dim = SURFACE_TENSION,\
    scale = 1.0,\
};

The newton per metre is the coherent SI unit of
[SURFACE_TENSION](#SURFACE_TENSION){.ref}.
:::

::: {.section .member}
#### [def OERSTED]{.heading-body}[[\[permalink\]](#OERSTED)]{.heading-extra} {#OERSTED}

\
[def]{.keyword} OERSTED = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 79.57747155,\
};

The oersted is a CGS electromagnetic unit used to express magnetic field
strength. The SI counterpart unit is the [HENRY](#HENRY){.ref}.
:::

::: {.section .member}
#### [def PASCAL_SECOND]{.heading-body}[[\[permalink\]](#PASCAL_SECOND)]{.heading-extra} {#PASCAL_SECOND}

\
[def]{.keyword} PASCAL_SECOND = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0,\
};

The pascal-second is the coherent SI unit of
[DYNAMIC_VISCOSITY](#DYNAMIC_VISCOSITY){.ref}.
:::

::: {.section .member}
#### [def PICOFARAD]{.heading-body}[[\[permalink\]](#PICOFARAD)]{.heading-extra} {#PICOFARAD}

\
[def]{.keyword} PICOFARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-12,\
};

The picofarad is a scaled SI unit of capacitance. The corresponding
unscaled SI unit is the [FARAD](#FARAD){.ref}.
:::

::: {.section .member}
#### [def PICOMETRE]{.heading-body}[[\[permalink\]](#PICOMETRE)]{.heading-extra} {#PICOMETRE}

\
[def]{.keyword} PICOMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-12,\
};

The picometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the [METRE](#METRE){.ref}.
:::

::: {.section .member}
#### [def PLANCK]{.heading-body}[[\[permalink\]](#PLANCK)]{.heading-extra} {#PLANCK}

\
[def]{.keyword} PLANCK = quantity {\
    unit = JOULE_SECOND,\
    value = 6.62607015e-34,\
};

The Planck constant, an exact defining constant of the SI relating the
energy of a photon to its frequency. Its SI unit is
[JOULE_SECOND](#JOULE_SECOND){.ref}.
:::

::: {.section .member}
#### [def POISE]{.heading-body}[[\[permalink\]](#POISE)]{.heading-extra} {#POISE}

\
[def]{.keyword} POISE = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 0.1,\
};

The poise is a CGS unit commonly used in rheology and fluid mechanics to
express dynamic viscosity.
:::

::: {.section .member}
#### [def POWER]{.heading-body}[[\[permalink\]](#POWER)]{.heading-extra} {#POWER}

\
[def]{.keyword} POWER = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    \...\
};

The SI derived dimension of power. Its SI unit is [WATT](#WATT){.ref}.
:::

::: {.section .member}
#### [def PRESSURE]{.heading-body}[[\[permalink\]](#PRESSURE)]{.heading-extra} {#PRESSURE}

\
[def]{.keyword} PRESSURE = dimension {\
    mass = 1,\
    length = -1,\
    time = -2,\
    \...\
};

The SI derived dimension of pressure. Its SI unit is
[PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def RAD]{.heading-body}[[\[permalink\]](#RAD)]{.heading-extra} {#RAD}

\
[def]{.keyword} RAD = unit {\
    dim = ABSORBED_DOSE,\
    scale = 0.01,\
};

The rad is a non-SI unit historically used in radiobiology and radiation
dosimetry to express absorbed dose. The SI counterpart unit is the
[GRAY](#GRAY){.ref}.
:::

::: {.section .member}
#### [def RECIPROCAL_CURRENT]{.heading-body}[[\[permalink\]](#RECIPROCAL_CURRENT)]{.heading-extra} {#RECIPROCAL_CURRENT}

\
[def]{.keyword} RECIPROCAL_CURRENT = dimension {\
    current = -1,\
    \...\
};

The reciprocal of the SI base dimension of electric current.
:::

::: {.section .member}
#### [def RECIPROCAL_LUMINOSITY]{.heading-body}[[\[permalink\]](#RECIPROCAL_LUMINOSITY)]{.heading-extra} {#RECIPROCAL_LUMINOSITY}

\
[def]{.keyword} RECIPROCAL_LUMINOSITY = dimension {\
    luminosity = -1,\
    \...\
};

The reciprocal of the SI base dimension of luminous intensity.
:::

::: {.section .member}
#### [def RECIPROCAL_MASS]{.heading-body}[[\[permalink\]](#RECIPROCAL_MASS)]{.heading-extra} {#RECIPROCAL_MASS}

\
[def]{.keyword} RECIPROCAL_MASS = dimension {\
    mass = -1,\
    \...\
};

The reciprocal of the SI base dimension of mass.
:::

::: {.section .member}
#### [def RECIPROCAL_SUBSTANCE]{.heading-body}[[\[permalink\]](#RECIPROCAL_SUBSTANCE)]{.heading-extra} {#RECIPROCAL_SUBSTANCE}

\
[def]{.keyword} RECIPROCAL_SUBSTANCE = dimension {\
    substance = -1,\
    \...\
};

The reciprocal of the SI base dimension of amount of substance.
:::

::: {.section .member}
#### [def RECIPROCAL_TEMPERATURE]{.heading-body}[[\[permalink\]](#RECIPROCAL_TEMPERATURE)]{.heading-extra} {#RECIPROCAL_TEMPERATURE}

\
[def]{.keyword} RECIPROCAL_TEMPERATURE = dimension {\
    temperature = -1,\
    \...\
};

The reciprocal of the SI base dimension of thermodynamic temperature.
:::

::: {.section .member}
#### [def REM]{.heading-body}[[\[permalink\]](#REM)]{.heading-extra} {#REM}

\
[def]{.keyword} REM = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 0.01,\
};

The rem (or Roentgen equivalent man) is a non-SI unit historically used
in radiation protection to express equivalent dose. The SI counterpart
unit is the [SIEVERT](#SIEVERT){.ref}.
:::

::: {.section .member}
#### [def RESISTANCE]{.heading-body}[[\[permalink\]](#RESISTANCE)]{.heading-extra} {#RESISTANCE}

\
[def]{.keyword} RESISTANCE = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -2,\
    \...\
};

The SI derived dimension of electrical resistance. Its SI unit is
[OHM](#OHM){.ref}.
:::

::: {.section .member}
#### [def ROENTGEN]{.heading-body}[[\[permalink\]](#ROENTGEN)]{.heading-extra} {#ROENTGEN}

\
[def]{.keyword} ROENTGEN = unit {\
    dim = EXPOSURE,\
    scale = 2.58e-4,\
};

The roentgen is a non-SI unit historically used in radiology and
radiation protection to express [EXPOSURE](#EXPOSURE){.ref}. The SI
counterpart unit is the
[COULOMB_PER_KILOGRAM](#COULOMB_PER_KILOGRAM){.ref}.
:::

::: {.section .member}
#### [def SPEED_OF_LIGHT]{.heading-body}[[\[permalink\]](#SPEED_OF_LIGHT)]{.heading-extra} {#SPEED_OF_LIGHT}

\
[def]{.keyword} SPEED_OF_LIGHT = quantity {\
    unit = METRE_PER_SECOND,\
    value = 299792458.0,\
};

The speed of light in vacuum, an exact defining constant of the SI. Its
SI unit is [METRE_PER_SECOND](#METRE_PER_SECOND){.ref}.
:::

::: {.section .member}
#### [def SQUARE_CENTIMETRE]{.heading-body}[[\[permalink\]](#SQUARE_CENTIMETRE)]{.heading-extra} {#SQUARE_CENTIMETRE}

\
[def]{.keyword} SQUARE_CENTIMETRE = unit {\
    dim = AREA,\
    scale = 1.0e-4,\
};

The square centimetre is a scaled SI unit of area. The corresponding
unscaled SI unit is the [SQUARE_METRE](#SQUARE_METRE){.ref}.
:::

::: {.section .member}
#### [def SQUARE_KILOMETRE]{.heading-body}[[\[permalink\]](#SQUARE_KILOMETRE)]{.heading-extra} {#SQUARE_KILOMETRE}

\
[def]{.keyword} SQUARE_KILOMETRE = unit {\
    dim = AREA,\
    scale = 1.0e6,\
};

The square kilometre is a scaled SI unit of area. The corresponding
unscaled SI unit is the [SQUARE_METRE](#SQUARE_METRE){.ref}.
:::

::: {.section .member}
#### [def SQUARE_METRE_PER_SECOND]{.heading-body}[[\[permalink\]](#SQUARE_METRE_PER_SECOND)]{.heading-extra} {#SQUARE_METRE_PER_SECOND}

\
[def]{.keyword} SQUARE_METRE_PER_SECOND = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0,\
};

The square metre per second is the coherent SI unit of
[KINEMATIC_VISCOSITY](#KINEMATIC_VISCOSITY){.ref}.
:::

::: {.section .member}
#### [def SQUARE_MILLIMETRE]{.heading-body}[[\[permalink\]](#SQUARE_MILLIMETRE)]{.heading-extra} {#SQUARE_MILLIMETRE}

\
[def]{.keyword} SQUARE_MILLIMETRE = unit {\
    dim = AREA,\
    scale = 1.0e-6,\
};

The square millimetre is a scaled SI unit of area. The corresponding
unscaled SI unit is the [SQUARE_METRE](#SQUARE_METRE){.ref}.
:::

::: {.section .member}
#### [def SQUARE_MILLIMETRE_PER_SECOND]{.heading-body}[[\[permalink\]](#SQUARE_MILLIMETRE_PER_SECOND)]{.heading-extra} {#SQUARE_MILLIMETRE_PER_SECOND}

\
[def]{.keyword} SQUARE_MILLIMETRE_PER_SECOND = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-6,\
};

The square millimetre per second is a scaled SI unit of kinematic
viscosity. The corresponding unscaled SI unit is the
[SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND){.ref}.
:::

::: {.section .member}
#### [def STOKES]{.heading-body}[[\[permalink\]](#STOKES)]{.heading-extra} {#STOKES}

\
[def]{.keyword} STOKES = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-4,\
};

The stokes is a CGS unit commonly used in fluid mechanics to express
viscosity. The SI counterpart unit is the
[SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND){.ref}.
:::

::: {.section .member}
#### [def SUBSTANCE]{.heading-body}[[\[permalink\]](#SUBSTANCE)]{.heading-extra} {#SUBSTANCE}

\
[def]{.keyword} SUBSTANCE = dimension {\
    substance = 1,\
    \...\
};

The SI base dimension of amount of substance.
:::

::: {.section .member}
#### [def TEMPERATURE]{.heading-body}[[\[permalink\]](#TEMPERATURE)]{.heading-extra} {#TEMPERATURE}

\
[def]{.keyword} TEMPERATURE = dimension {\
    temperature = 1,\
    \...\
};

The SI base dimension of thermodynamic temperature.
:::

::: {.section .member}
#### [def TIME]{.heading-body}[[\[permalink\]](#TIME)]{.heading-extra} {#TIME}

\
[def]{.keyword} TIME = dimension {\
    time = 1,\
    \...\
};

The SI base dimension of time.
:::

::: {.section .member}
#### [def TONNE]{.heading-body}[[\[permalink\]](#TONNE)]{.heading-extra} {#TONNE}

\
[def]{.keyword} TONNE = unit {\
    dim = MASS,\
    scale = 1.0e3,\
};

The tonne is a non-SI metric unit of mass still in common general use.
Not to be confused with the ton units used in Imperial or Customary
systems. See [KILOGRAM](#KILOGRAM){.ref}.
:::

::: {.section .member}
#### [def TORR]{.heading-body}[[\[permalink\]](#TORR)]{.heading-extra} {#TORR}

\
[def]{.keyword} TORR = unit {\
    dim = PRESSURE,\
    scale = 133.322368421,\
};

The torr is non-SI unit historically used in physics. The SI counterpart
unit is the [PASCAL](#PASCAL){.ref}.
:::

::: {.section .member}
#### [def WAVENUMBER]{.heading-body}[[\[permalink\]](#WAVENUMBER)]{.heading-extra} {#WAVENUMBER}

\
[def]{.keyword} WAVENUMBER = dimension {\
    length = -1,\
    \...\
};

The SI derived dimension of spatial frequency, expressed as the
reciprocal of length.
:::

::: {.section .member}
#### [def ACCELERATION]{.heading-body}[[\[permalink\]](#ACCELERATION)]{.heading-extra} {#ACCELERATION}

Show undocumented member

\
[def]{.keyword} ACCELERATION = dimension {\
    length = 1,\
    time = -2,\
    \...\
};
:::

::: {.section .member}
#### [def ACTION]{.heading-body}[[\[permalink\]](#ACTION)]{.heading-extra} {#ACTION}

Show undocumented member

\
[def]{.keyword} ACTION = dimension {\
    mass = 1,\
    length = 2,\
    time = -1,\
    \...\
};
:::

::: {.section .member}
#### [def AMPERE]{.heading-body}[[\[permalink\]](#AMPERE)]{.heading-extra} {#AMPERE}

Show undocumented member

\
[def]{.keyword} AMPERE = unit {\
    dim = CURRENT,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def AMPERE_PER_METRE]{.heading-body}[[\[permalink\]](#AMPERE_PER_METRE)]{.heading-extra} {#AMPERE_PER_METRE}

Show undocumented member

\
[def]{.keyword} AMPERE_PER_METRE = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def AMPERE_PER_SQUARE_METRE]{.heading-body}[[\[permalink\]](#AMPERE_PER_SQUARE_METRE)]{.heading-extra} {#AMPERE_PER_SQUARE_METRE}

Show undocumented member

\
[def]{.keyword} AMPERE_PER_SQUARE_METRE = unit {\
    dim = CURRENT_DENSITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def AREA]{.heading-body}[[\[permalink\]](#AREA)]{.heading-extra} {#AREA}

Show undocumented member

\
[def]{.keyword} AREA = dimension {\
    length = 2,\
    \...\
};
:::

::: {.section .member}
#### [def ATTO]{.heading-body}[[\[permalink\]](#ATTO)]{.heading-extra} {#ATTO}

Show undocumented member

\
[def]{.keyword} ATTO: [f64]{.type} = 1.0e-18;
:::

::: {.section .member}
#### [def BECQUEREL]{.heading-body}[[\[permalink\]](#BECQUEREL)]{.heading-extra} {#BECQUEREL}

Show undocumented member

\
[def]{.keyword} BECQUEREL = unit {\
    dim = ACTIVITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def CANDELA]{.heading-body}[[\[permalink\]](#CANDELA)]{.heading-extra} {#CANDELA}

Show undocumented member

\
[def]{.keyword} CANDELA = unit {\
    dim = LUMINOSITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def CANDELA_PER_SQUARE_METRE]{.heading-body}[[\[permalink\]](#CANDELA_PER_SQUARE_METRE)]{.heading-extra} {#CANDELA_PER_SQUARE_METRE}

Show undocumented member

\
[def]{.keyword} CANDELA_PER_SQUARE_METRE = unit {\
    dim = LUMINANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def CENTI]{.heading-body}[[\[permalink\]](#CENTI)]{.heading-extra} {#CENTI}

Show undocumented member

\
[def]{.keyword} CENTI: [f64]{.type} = 0.01;
:::

::: {.section .member}
#### [def CONCENTRATION]{.heading-body}[[\[permalink\]](#CONCENTRATION)]{.heading-extra} {#CONCENTRATION}

Show undocumented member

\
[def]{.keyword} CONCENTRATION = dimension {\
    substance = 1,\
    length = -3,\
    \...\
};
:::

::: {.section .member}
#### [def COULOMB]{.heading-body}[[\[permalink\]](#COULOMB)]{.heading-extra} {#COULOMB}

Show undocumented member

\
[def]{.keyword} COULOMB = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def COULOMB_PER_KILOGRAM]{.heading-body}[[\[permalink\]](#COULOMB_PER_KILOGRAM)]{.heading-extra} {#COULOMB_PER_KILOGRAM}

Show undocumented member

\
[def]{.keyword} COULOMB_PER_KILOGRAM = unit {\
    dim = EXPOSURE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def CUBIC_METRE]{.heading-body}[[\[permalink\]](#CUBIC_METRE)]{.heading-extra} {#CUBIC_METRE}

Show undocumented member

\
[def]{.keyword} CUBIC_METRE = unit {\
    dim = VOLUME,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def CUBIC_METRE_PER_KILOGRAM]{.heading-body}[[\[permalink\]](#CUBIC_METRE_PER_KILOGRAM)]{.heading-extra} {#CUBIC_METRE_PER_KILOGRAM}

Show undocumented member

\
[def]{.keyword} CUBIC_METRE_PER_KILOGRAM = unit {\
    dim = SPECIFIC_VOLUME,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def CURRENT_DENSITY]{.heading-body}[[\[permalink\]](#CURRENT_DENSITY)]{.heading-extra} {#CURRENT_DENSITY}

Show undocumented member

\
[def]{.keyword} CURRENT_DENSITY = dimension {\
    current = 1,\
    length = -2,\
    \...\
};
:::

::: {.section .member}
#### [def DECA]{.heading-body}[[\[permalink\]](#DECA)]{.heading-extra} {#DECA}

Show undocumented member

\
[def]{.keyword} DECA: [f64]{.type} = 10.0;
:::

::: {.section .member}
#### [def DECI]{.heading-body}[[\[permalink\]](#DECI)]{.heading-extra} {#DECI}

Show undocumented member

\
[def]{.keyword} DECI: [f64]{.type} = 0.1;
:::

::: {.section .member}
#### [def DEGREE_CELSIUS]{.heading-body}[[\[permalink\]](#DEGREE_CELSIUS)]{.heading-extra} {#DEGREE_CELSIUS}

Show undocumented member

\
[def]{.keyword} DEGREE_CELSIUS = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def DENSITY]{.heading-body}[[\[permalink\]](#DENSITY)]{.heading-extra} {#DENSITY}

Show undocumented member

\
[def]{.keyword} DENSITY = dimension {\
    mass = 1,\
    length = -3,\
    \...\
};
:::

::: {.section .member}
#### [def DIMENSIONLESS_UNIT]{.heading-body}[[\[permalink\]](#DIMENSIONLESS_UNIT)]{.heading-extra} {#DIMENSIONLESS_UNIT}

Show undocumented member

\
[def]{.keyword} DIMENSIONLESS_UNIT = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def ENTROPY]{.heading-body}[[\[permalink\]](#ENTROPY)]{.heading-extra} {#ENTROPY}

Show undocumented member

\
[def]{.keyword} ENTROPY = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    temperature = -1,\
    \...\
};
:::

::: {.section .member}
#### [def EXA]{.heading-body}[[\[permalink\]](#EXA)]{.heading-extra} {#EXA}

Show undocumented member

\
[def]{.keyword} EXA: [f64]{.type} = 1.0e18;
:::

::: {.section .member}
#### [def FARAD]{.heading-body}[[\[permalink\]](#FARAD)]{.heading-extra} {#FARAD}

Show undocumented member

\
[def]{.keyword} FARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def FEMTO]{.heading-body}[[\[permalink\]](#FEMTO)]{.heading-extra} {#FEMTO}

Show undocumented member

\
[def]{.keyword} FEMTO: [f64]{.type} = 1.0e-15;
:::

::: {.section .member}
#### [def GIGA]{.heading-body}[[\[permalink\]](#GIGA)]{.heading-extra} {#GIGA}

Show undocumented member

\
[def]{.keyword} GIGA: [f64]{.type} = 1.0e9;
:::

::: {.section .member}
#### [def GRAY]{.heading-body}[[\[permalink\]](#GRAY)]{.heading-extra} {#GRAY}

Show undocumented member

\
[def]{.keyword} GRAY = unit {\
    dim = ABSORBED_DOSE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def HECTO]{.heading-body}[[\[permalink\]](#HECTO)]{.heading-extra} {#HECTO}

Show undocumented member

\
[def]{.keyword} HECTO: [f64]{.type} = 100.0;
:::

::: {.section .member}
#### [def HENRY]{.heading-body}[[\[permalink\]](#HENRY)]{.heading-extra} {#HENRY}

Show undocumented member

\
[def]{.keyword} HENRY = unit {\
    dim = INDUCTANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def HERTZ]{.heading-body}[[\[permalink\]](#HERTZ)]{.heading-extra} {#HERTZ}

Show undocumented member

\
[def]{.keyword} HERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def JOULE]{.heading-body}[[\[permalink\]](#JOULE)]{.heading-extra} {#JOULE}

Show undocumented member

\
[def]{.keyword} JOULE = unit {\
    dim = ENERGY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def KATAL]{.heading-body}[[\[permalink\]](#KATAL)]{.heading-extra} {#KATAL}

Show undocumented member

\
[def]{.keyword} KATAL = unit {\
    dim = CATALYTIC_ACTIVITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def KELVIN]{.heading-body}[[\[permalink\]](#KELVIN)]{.heading-extra} {#KELVIN}

Show undocumented member

\
[def]{.keyword} KELVIN = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def KILO]{.heading-body}[[\[permalink\]](#KILO)]{.heading-extra} {#KILO}

Show undocumented member

\
[def]{.keyword} KILO: [f64]{.type} = 1.0e3;
:::

::: {.section .member}
#### [def KILOGRAM]{.heading-body}[[\[permalink\]](#KILOGRAM)]{.heading-extra} {#KILOGRAM}

Show undocumented member

\
[def]{.keyword} KILOGRAM = unit {\
    dim = MASS,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def KILOGRAM_PER_CUBIC_METRE]{.heading-body}[[\[permalink\]](#KILOGRAM_PER_CUBIC_METRE)]{.heading-extra} {#KILOGRAM_PER_CUBIC_METRE}

Show undocumented member

\
[def]{.keyword} KILOGRAM_PER_CUBIC_METRE = unit {\
    dim = DENSITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def KILOGRAM_PER_SQUARE_METRE]{.heading-body}[[\[permalink\]](#KILOGRAM_PER_SQUARE_METRE)]{.heading-extra} {#KILOGRAM_PER_SQUARE_METRE}

Show undocumented member

\
[def]{.keyword} KILOGRAM_PER_SQUARE_METRE = unit {\
    dim = SURFACE_DENSITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def LUMEN]{.heading-body}[[\[permalink\]](#LUMEN)]{.heading-extra} {#LUMEN}

Show undocumented member

\
[def]{.keyword} LUMEN = unit {\
    dim = LUMINOUS_FLUX,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def LUMEN_PER_WATT]{.heading-body}[[\[permalink\]](#LUMEN_PER_WATT)]{.heading-extra} {#LUMEN_PER_WATT}

Show undocumented member

\
[def]{.keyword} LUMEN_PER_WATT = unit {\
    dim = LUMINOUS_EFFICACY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def LUMINANCE]{.heading-body}[[\[permalink\]](#LUMINANCE)]{.heading-extra} {#LUMINANCE}

Show undocumented member

\
[def]{.keyword} LUMINANCE = dimension {\
    luminosity = 1,\
    length = -2,\
    \...\
};
:::

::: {.section .member}
#### [def LUMINOUS_EFFICACY]{.heading-body}[[\[permalink\]](#LUMINOUS_EFFICACY)]{.heading-extra} {#LUMINOUS_EFFICACY}

Show undocumented member

\
[def]{.keyword} LUMINOUS_EFFICACY = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    luminosity = 1,\
    \...\
};
:::

::: {.section .member}
#### [def LUX]{.heading-body}[[\[permalink\]](#LUX)]{.heading-extra} {#LUX}

Show undocumented member

\
[def]{.keyword} LUX = unit {\
    dim = ILLUMINANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def MAGNETIC_FIELD_STRENGTH]{.heading-body}[[\[permalink\]](#MAGNETIC_FIELD_STRENGTH)]{.heading-extra} {#MAGNETIC_FIELD_STRENGTH}

Show undocumented member

\
[def]{.keyword} MAGNETIC_FIELD_STRENGTH = dimension {\
    current = 1,\
    length = -1,\
    \...\
};
:::

::: {.section .member}
#### [def MEGA]{.heading-body}[[\[permalink\]](#MEGA)]{.heading-extra} {#MEGA}

Show undocumented member

\
[def]{.keyword} MEGA: [f64]{.type} = 1.0e6;
:::

::: {.section .member}
#### [def METRE]{.heading-body}[[\[permalink\]](#METRE)]{.heading-extra} {#METRE}

Show undocumented member

\
[def]{.keyword} METRE = unit {\
    dim = LENGTH,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def METRE_PER_SECOND]{.heading-body}[[\[permalink\]](#METRE_PER_SECOND)]{.heading-extra} {#METRE_PER_SECOND}

Show undocumented member

\
[def]{.keyword} METRE_PER_SECOND = unit {\
    dim = VELOCITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def METRE_PER_SECOND_SQUARED]{.heading-body}[[\[permalink\]](#METRE_PER_SECOND_SQUARED)]{.heading-extra} {#METRE_PER_SECOND_SQUARED}

Show undocumented member

\
[def]{.keyword} METRE_PER_SECOND_SQUARED = unit {\
    dim = ACCELERATION,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def MICRO]{.heading-body}[[\[permalink\]](#MICRO)]{.heading-extra} {#MICRO}

Show undocumented member

\
[def]{.keyword} MICRO: [f64]{.type} = 1.0e-6;
:::

::: {.section .member}
#### [def MILLI]{.heading-body}[[\[permalink\]](#MILLI)]{.heading-extra} {#MILLI}

Show undocumented member

\
[def]{.keyword} MILLI: [f64]{.type} = 1.0e-3;
:::

::: {.section .member}
#### [def MOLE]{.heading-body}[[\[permalink\]](#MOLE)]{.heading-extra} {#MOLE}

Show undocumented member

\
[def]{.keyword} MOLE = unit {\
    dim = SUBSTANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def MOLE_PER_CUBIC_METRE]{.heading-body}[[\[permalink\]](#MOLE_PER_CUBIC_METRE)]{.heading-extra} {#MOLE_PER_CUBIC_METRE}

Show undocumented member

\
[def]{.keyword} MOLE_PER_CUBIC_METRE = unit {\
    dim = CONCENTRATION,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def NANO]{.heading-body}[[\[permalink\]](#NANO)]{.heading-extra} {#NANO}

Show undocumented member

\
[def]{.keyword} NANO: [f64]{.type} = 1.0e-9;
:::

::: {.section .member}
#### [def NEWTON]{.heading-body}[[\[permalink\]](#NEWTON)]{.heading-extra} {#NEWTON}

Show undocumented member

\
[def]{.keyword} NEWTON = unit {\
    dim = FORCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def NONE]{.heading-body}[[\[permalink\]](#NONE)]{.heading-extra} {#NONE}

Show undocumented member

\
[def]{.keyword} NONE: [f64]{.type} = 1.0;
:::

::: {.section .member}
#### [def OHM]{.heading-body}[[\[permalink\]](#OHM)]{.heading-extra} {#OHM}

Show undocumented member

\
[def]{.keyword} OHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def PASCAL]{.heading-body}[[\[permalink\]](#PASCAL)]{.heading-extra} {#PASCAL}

Show undocumented member

\
[def]{.keyword} PASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def PETA]{.heading-body}[[\[permalink\]](#PETA)]{.heading-extra} {#PETA}

Show undocumented member

\
[def]{.keyword} PETA: [f64]{.type} = 1.0e15;
:::

::: {.section .member}
#### [def PICO]{.heading-body}[[\[permalink\]](#PICO)]{.heading-extra} {#PICO}

Show undocumented member

\
[def]{.keyword} PICO: [f64]{.type} = 1.0e-12;
:::

::: {.section .member}
#### [def QUECTO]{.heading-body}[[\[permalink\]](#QUECTO)]{.heading-extra} {#QUECTO}

Show undocumented member

\
[def]{.keyword} QUECTO: [f64]{.type} = 1.0e-30;
:::

::: {.section .member}
#### [def QUETTA]{.heading-body}[[\[permalink\]](#QUETTA)]{.heading-extra} {#QUETTA}

Show undocumented member

\
[def]{.keyword} QUETTA: [f64]{.type} = 1.0e30;
:::

::: {.section .member}
#### [def RADIAN]{.heading-body}[[\[permalink\]](#RADIAN)]{.heading-extra} {#RADIAN}

Show undocumented member

\
[def]{.keyword} RADIAN = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RECIPROCAL_AMPERE]{.heading-body}[[\[permalink\]](#RECIPROCAL_AMPERE)]{.heading-extra} {#RECIPROCAL_AMPERE}

Show undocumented member

\
[def]{.keyword} RECIPROCAL_AMPERE = unit {\
    dim = RECIPROCAL_CURRENT,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RECIPROCAL_CANDELA]{.heading-body}[[\[permalink\]](#RECIPROCAL_CANDELA)]{.heading-extra} {#RECIPROCAL_CANDELA}

Show undocumented member

\
[def]{.keyword} RECIPROCAL_CANDELA = unit {\
    dim = RECIPROCAL_LUMINOSITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RECIPROCAL_KELVIN]{.heading-body}[[\[permalink\]](#RECIPROCAL_KELVIN)]{.heading-extra} {#RECIPROCAL_KELVIN}

Show undocumented member

\
[def]{.keyword} RECIPROCAL_KELVIN = unit {\
    dim = RECIPROCAL_TEMPERATURE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RECIPROCAL_KILOGRAM]{.heading-body}[[\[permalink\]](#RECIPROCAL_KILOGRAM)]{.heading-extra} {#RECIPROCAL_KILOGRAM}

Show undocumented member

\
[def]{.keyword} RECIPROCAL_KILOGRAM = unit {\
    dim = RECIPROCAL_MASS,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RECIPROCAL_METRE]{.heading-body}[[\[permalink\]](#RECIPROCAL_METRE)]{.heading-extra} {#RECIPROCAL_METRE}

Show undocumented member

\
[def]{.keyword} RECIPROCAL_METRE = unit {\
    dim = WAVENUMBER,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RECIPROCAL_MOLE]{.heading-body}[[\[permalink\]](#RECIPROCAL_MOLE)]{.heading-extra} {#RECIPROCAL_MOLE}

Show undocumented member

\
[def]{.keyword} RECIPROCAL_MOLE = unit {\
    dim = RECIPROCAL_SUBSTANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def RONNA]{.heading-body}[[\[permalink\]](#RONNA)]{.heading-extra} {#RONNA}

Show undocumented member

\
[def]{.keyword} RONNA: [f64]{.type} = 1.0e27;
:::

::: {.section .member}
#### [def RONTO]{.heading-body}[[\[permalink\]](#RONTO)]{.heading-extra} {#RONTO}

Show undocumented member

\
[def]{.keyword} RONTO: [f64]{.type} = 1.0e-27;
:::

::: {.section .member}
#### [def SECOND]{.heading-body}[[\[permalink\]](#SECOND)]{.heading-extra} {#SECOND}

Show undocumented member

\
[def]{.keyword} SECOND = unit {\
    dim = TIME,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def SIEMENS]{.heading-body}[[\[permalink\]](#SIEMENS)]{.heading-extra} {#SIEMENS}

Show undocumented member

\
[def]{.keyword} SIEMENS = unit {\
    dim = CONDUCTANCE,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def SIEVERT]{.heading-body}[[\[permalink\]](#SIEVERT)]{.heading-extra} {#SIEVERT}

Show undocumented member

\
[def]{.keyword} SIEVERT = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def SPECIFIC_VOLUME]{.heading-body}[[\[permalink\]](#SPECIFIC_VOLUME)]{.heading-extra} {#SPECIFIC_VOLUME}

Show undocumented member

\
[def]{.keyword} SPECIFIC_VOLUME = dimension {\
    mass = -1,\
    length = 3,\
    \...\
};
:::

::: {.section .member}
#### [def SQUARE_METRE]{.heading-body}[[\[permalink\]](#SQUARE_METRE)]{.heading-extra} {#SQUARE_METRE}

Show undocumented member

\
[def]{.keyword} SQUARE_METRE = unit {\
    dim = AREA,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def STERADIAN]{.heading-body}[[\[permalink\]](#STERADIAN)]{.heading-extra} {#STERADIAN}

Show undocumented member

\
[def]{.keyword} STERADIAN = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def SURFACE_DENSITY]{.heading-body}[[\[permalink\]](#SURFACE_DENSITY)]{.heading-extra} {#SURFACE_DENSITY}

Show undocumented member

\
[def]{.keyword} SURFACE_DENSITY = dimension {\
    mass = 1,\
    length = -2,\
    \...\
};
:::

::: {.section .member}
#### [def SURFACE_TENSION]{.heading-body}[[\[permalink\]](#SURFACE_TENSION)]{.heading-extra} {#SURFACE_TENSION}

Show undocumented member

\
[def]{.keyword} SURFACE_TENSION = dimension {\
    mass = 1,\
    length = 0,\
    time = -2,\
    \...\
};
:::

::: {.section .member}
#### [def TERA]{.heading-body}[[\[permalink\]](#TERA)]{.heading-extra} {#TERA}

Show undocumented member

\
[def]{.keyword} TERA: [f64]{.type} = 1.0e12;
:::

::: {.section .member}
#### [def TESLA]{.heading-body}[[\[permalink\]](#TESLA)]{.heading-extra} {#TESLA}

Show undocumented member

\
[def]{.keyword} TESLA = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def TORQUE]{.heading-body}[[\[permalink\]](#TORQUE)]{.heading-extra} {#TORQUE}

Show undocumented member

\
[def]{.keyword} TORQUE = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    \...\
};
:::

::: {.section .member}
#### [def VELOCITY]{.heading-body}[[\[permalink\]](#VELOCITY)]{.heading-extra} {#VELOCITY}

Show undocumented member

\
[def]{.keyword} VELOCITY = dimension {\
    length = 1,\
    time = -1,\
    \...\
};
:::

::: {.section .member}
#### [def VOLT]{.heading-body}[[\[permalink\]](#VOLT)]{.heading-extra} {#VOLT}

Show undocumented member

\
[def]{.keyword} VOLT = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def VOLUME]{.heading-body}[[\[permalink\]](#VOLUME)]{.heading-extra} {#VOLUME}

Show undocumented member

\
[def]{.keyword} VOLUME = dimension {\
    length = 3,\
    \...\
};
:::

::: {.section .member}
#### [def WATT]{.heading-body}[[\[permalink\]](#WATT)]{.heading-extra} {#WATT}

Show undocumented member

\
[def]{.keyword} WATT = unit {\
    dim = POWER,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def WEBER]{.heading-body}[[\[permalink\]](#WEBER)]{.heading-extra} {#WEBER}

Show undocumented member

\
[def]{.keyword} WEBER = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0,\
};
:::

::: {.section .member}
#### [def YOCTO]{.heading-body}[[\[permalink\]](#YOCTO)]{.heading-extra} {#YOCTO}

Show undocumented member

\
[def]{.keyword} YOCTO: [f64]{.type} = 1.0e-24;
:::

::: {.section .member}
#### [def YOTTA]{.heading-body}[[\[permalink\]](#YOTTA)]{.heading-extra} {#YOTTA}

Show undocumented member

\
[def]{.keyword} YOTTA: [f64]{.type} = 1.0e24;
:::

::: {.section .member}
#### [def ZEPTO]{.heading-body}[[\[permalink\]](#ZEPTO)]{.heading-extra} {#ZEPTO}

Show undocumented member

\
[def]{.keyword} ZEPTO: [f64]{.type} = 1.0e-21;
:::

::: {.section .member}
#### [def ZETTA]{.heading-body}[[\[permalink\]](#ZETTA)]{.heading-extra} {#ZETTA}

Show undocumented member

\
[def]{.keyword} ZETTA: [f64]{.type} = 1.0e21;
:::

### Globals

::: {.section .member}
#### [let GIT_VERSION]{.heading-body}[[\[permalink\]](#GIT_VERSION)]{.heading-extra} {#GIT_VERSION}

\
[const]{.keyword} GIT_VERSION: [str]{.type};

Git commit identifier of the current build. Appended with \"-dirty\"
when the working tree contains uncommitted changes.
:::

::: {.section .member}
#### [let SEM_VERSION]{.heading-body}[[\[permalink\]](#SEM_VERSION)]{.heading-extra} {#SEM_VERSION}

\
[const]{.keyword} SEM_VERSION: [str]{.type};

Semantic version of the current release.
:::

### Functions

::: {.section .member}
#### [fn add]{.heading-body}[[\[permalink\]](#add)]{.heading-extra} {#add}

\
[fn]{.keyword} add(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [(]{.type}[quantity]{.type} [\|]{.type} [dimension_mismatch]{.type}[)]{.type};

Returns the sum of quantities a and b, converting b to a\'s unit. If b
is an f64, it is treated as a value in a\'s unit.
:::

::: {.section .member}
#### [fn divd]{.heading-body}[[\[permalink\]](#divd)]{.heading-extra} {#divd}

\
[fn]{.keyword} divd(a: [dimension]{.type}, b: [dimension]{.type}) [dimension]{.type};

Returns the quotient of units a and b.
:::

::: {.section .member}
#### [fn divq]{.heading-body}[[\[permalink\]](#divq)]{.heading-extra} {#divq}

\
[fn]{.keyword} divq(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [quantity]{.type};

Returns the quotient of quantities a and b, or scales a by 1/b if b is
an f64.
:::

::: {.section .member}
#### [fn divu]{.heading-body}[[\[permalink\]](#divu)]{.heading-extra} {#divu}

\
[fn]{.keyword} divu(a: [unit]{.type}, b: [unit]{.type}) [unit]{.type};

Returns the quotient of units a and b.
:::

::: {.section .member}
#### [fn encodejson]{.heading-body}[[\[permalink\]](#encodejson)]{.heading-extra} {#encodejson}

\
[fn]{.keyword} encodejson(h: [io]{.type}[::]{.type}[handle]{.type}, obj: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};

Writes JSON encoded representation of a quantity or unit.
:::

::: {.section .member}
#### [fn equal]{.heading-body}[[\[permalink\]](#equal)]{.heading-extra} {#equal}

\
[fn]{.keyword} equal(a: [dimension]{.type}, b: [dimension]{.type}) [bool]{.type};

Returns true if dimensions a and b are equal.
:::

::: {.section .member}
#### [fn fprint]{.heading-body}[[\[permalink\]](#fprint)]{.heading-extra} {#fprint}

\
[fn]{.keyword} fprint(out: [io]{.type}[::]{.type}[handle]{.type}, x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};

Formats and prints x to handler h. Returns the number of bytes printed.
See also: [fprint](#fprint){.ref}, [println](#println){.ref}.
:::

::: {.section .member}
#### [fn identify]{.heading-body}[[\[permalink\]](#identify)]{.heading-extra} {#identify}

\
[fn]{.keyword} identify(in: [str]{.type}) [(]{.type}[prefix_kind]{.type}[,]{.type} [unit_kind]{.type}[)]{.type};

Returns the decimal prefix and unit symbol componants of the input
string. If the input string does not match any prefix or unit symbol,
the first componant of the tuple will be empty. Output is trimmed and
borrowed from input string.
:::

::: {.section .member}
#### [fn isclose]{.heading-body}[[\[permalink\]](#isclose)]{.heading-extra} {#isclose}

\
[fn]{.keyword} isclose(a: [quantity]{.type}, b: [quantity]{.type}, tol: [f64]{.type} = math::STANDARD_TOL) [(]{.type}[bool]{.type} [\|]{.type} [dimension_mismatch]{.type}[)]{.type};

Returns whether a and b are within tol of each other.
:::

::: {.section .member}
#### [fn isinf]{.heading-body}[[\[permalink\]](#isinf)]{.heading-extra} {#isinf}

\
[fn]{.keyword} isinf(q: [quantity]{.type}) [bool]{.type};

Returns true if the value of the quantity or scale of its unit is
infinite.
:::

::: {.section .member}
#### [fn isnan]{.heading-body}[[\[permalink\]](#isnan)]{.heading-extra} {#isnan}

\
[fn]{.keyword} isnan(q: [quantity]{.type}) [bool]{.type};

Returns true if the value of the quantity or scale of its unit is NaN.
:::

::: {.section .member}
#### [fn muld]{.heading-body}[[\[permalink\]](#muld)]{.heading-extra} {#muld}

\
[fn]{.keyword} muld(a: [dimension]{.type}, b: [dimension]{.type}) [dimension]{.type};

Returns the product of units a and b.
:::

::: {.section .member}
#### [fn mulq]{.heading-body}[[\[permalink\]](#mulq)]{.heading-extra} {#mulq}

\
[fn]{.keyword} mulq(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [quantity]{.type};

Returns the product of quantities a and b, or scales a by b if b is an
f64.
:::

::: {.section .member}
#### [fn mulu]{.heading-body}[[\[permalink\]](#mulu)]{.heading-extra} {#mulu}

\
[fn]{.keyword} mulu(a: [unit]{.type}, b: [unit]{.type}) [unit]{.type};

Returns the product of units a and b.
:::

::: {.section .member}
#### [fn powd]{.heading-body}[[\[permalink\]](#powd)]{.heading-extra} {#powd}

\
[fn]{.keyword} powd(x: [dimension]{.type}, p: [int]{.type}) [dimension]{.type};

Returns the dimension x raised to the power of p
:::

::: {.section .member}
#### [fn powq]{.heading-body}[[\[permalink\]](#powq)]{.heading-extra} {#powq}

\
[fn]{.keyword} powq(x: [quantity]{.type}, p: [int]{.type}) [quantity]{.type};

Returns quantity x raised to the integer power p.
:::

::: {.section .member}
#### [fn powu]{.heading-body}[[\[permalink\]](#powu)]{.heading-extra} {#powu}

\
[fn]{.keyword} powu(x: [unit]{.type}, p: [int]{.type}) [unit]{.type};

Returns the quantity x raised to the integer power p.
:::

::: {.section .member}
#### [fn print]{.heading-body}[[\[permalink\]](#print)]{.heading-extra} {#print}

\
[fn]{.keyword} print(x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};

Formats and prints x to [os::stdout](../os#stdout){.ref}. Returns the
number of bytes printed. See also: [fprint](#fprint){.ref},
[println](#println){.ref}.
:::

::: {.section .member}
#### [fn println]{.heading-body}[[\[permalink\]](#println)]{.heading-extra} {#println}

\
[fn]{.keyword} println(x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[size]{.type} [\|]{.type} [error]{.type}[)]{.type};

Formats and prints x followed by a newline to h. Returns the number of
bytes printed. See also: [fprint](#fprint){.ref}, [print](#print){.ref}.
:::

::: {.section .member}
#### [fn scale]{.heading-body}[[\[permalink\]](#scale)]{.heading-extra} {#scale}

\
[fn]{.keyword} scale(u: [unit]{.type}, fac: [(]{.type}[prefix_kind]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [unit]{.type};

Scales the unit by a f64 or metric prefix factor.
:::

::: {.section .member}
#### [fn strerror]{.heading-body}[[\[permalink\]](#strerror)]{.heading-extra} {#strerror}

\
[fn]{.keyword} strerror(err: [error]{.type}) [str]{.type};

Returns a human-readable description of an error. Returned value should
NOT be freed by the caller.
:::

::: {.section .member}
#### [fn strf]{.heading-body}[[\[permalink\]](#strf)]{.heading-extra} {#strf}

\
[fn]{.keyword} strf(x: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}, ustr: [(]{.type}[str]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, prec: [(]{.type}[uint]{.type} [\|]{.type} [void]{.type}[)]{.type} = [void]{.keyword}, repr: [notation]{.type} = notation::GENERAL, enc: [encoding]{.type} = encoding::UTF8) [(]{.type}[str]{.type} [\|]{.type} [error]{.type}[)]{.type};

Formats a quantity as a string using the specified unit format,
precision, notation, and character encoding. The result must be freed
after use.
:::

::: {.section .member}
#### [fn strp]{.heading-body}[[\[permalink\]](#strp)]{.heading-extra} {#strp}

\
[fn]{.keyword} strp(s: [str]{.type}) [(]{.type}[quantity]{.type} [\|]{.type} [error]{.type}[)]{.type};

Parses a numeric quantity and unit expression. Accepts fixed-point and
scientific notation, with permissive unit syntax including alternative
multiplication operators (\*, ×, ·, ⋅), exponent notation (\^, \*\*,
superscripts), exponent signs (+, −), grouping (( ), { }), ASCII or
UTF-8 encoded symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols.
Whitespace is permitted.

Valid examples:

strp(\"67 m\");\
strp(\"1.21 GW\");\
strp(\"9.80665 m/s\^2\");\
strp(\"32°C\");\
strp(\"1.5 kΩ\");\
strp(\"1.5 kohm\");\
strp(\"6.022e23 mol\*\*-1\");\
strp(\"20 m²\");\

Returns the parsed [quantity](#quantity){.ref} on success, or an
[error](#error){.ref} if the input is invalid.

- see also: [strpu](#strpu){.ref}
:::

::: {.section .member}
#### [fn strpu]{.heading-body}[[\[permalink\]](#strpu)]{.heading-extra} {#strpu}

\
[fn]{.keyword} strpu(s: [str]{.type}) [(]{.type}[unit]{.type} [\|]{.type} [error]{.type}[)]{.type};

Parses a unit expression. Accepts fixed-point and scientific notation,
with permissive unit syntax including alternative multiplication
operators (\*, ×, ·, ⋅), exponent notation (\^, \*\*, superscripts),
exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded
symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is
permitted.

Valid examples:

strpu(\"m\");\
strpu(\"m/s\^2\");\
strpu(\"°C\");\
strpu(\"kΩ\");\
strpu(\"kohm\");\
strpu(\"mol\*\*-1\");\
strpu(\"m²\");\

Returns the parsed [unit](#unit){.ref} on success, or an
[error](#error){.ref} if the input is invalid.

- see also: [strp](#strp){.ref}
:::

::: {.section .member}
#### [fn sub]{.heading-body}[[\[permalink\]](#sub)]{.heading-extra} {#sub}

\
[fn]{.keyword} sub(a: [quantity]{.type}, b: [(]{.type}[quantity]{.type} [\|]{.type} [f64]{.type}[)]{.type}) [(]{.type}[quantity]{.type} [\|]{.type} [dimension_mismatch]{.type}[)]{.type};

Returns the difference of quantities a and b, converting b to a\'s unit.
If b is an f64, it is treated as a value in a\'s unit.
:::

::: {.section .member}
#### [fn tojson]{.heading-body}[[\[permalink\]](#tojson)]{.heading-extra} {#tojson}

\
[fn]{.keyword} tojson(obj: [(]{.type}[quantity]{.type} [\|]{.type} [unit]{.type}[)]{.type}) [(]{.type}[str]{.type} [\|]{.type} [error]{.type}[)]{.type};

Returns JSON encoded string representation of a quantity or unit.
:::

::: {.section .member}
#### [fn split]{.heading-body}[[\[permalink\]](#split)]{.heading-extra} {#split}

Show undocumented member

\
[fn]{.keyword} split(input: [str]{.type}) [(]{.type}[(]{.type}[str]{.type}[,]{.type} [str]{.type}[)]{.type} [\|]{.type} [error]{.type}[)]{.type};
:::
