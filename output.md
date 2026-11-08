## <span class="heading-body">si</span><span class="heading-extra">+x86_64 +linux </span>

<div class="readme">

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
    ... \
}; \
const pascal = unit { \
    dim = pressure,\
    scale = 1.0,\
};\
const atmospheric_pressure  = quantity { \
    unit = pascal,\
    value = 101325.0,\
};\

- Parsing (<a href="#strp" class="ref">strp</a>) and formatting
  (<a href="#strf" class="ref">strf</a>) strings:

const acceleration = si::strp("20 m/s^2") as si::quantity;\
\
const output = si::strf(acceleration, "km\*s^-2") as str;\
\>\> 0.02 km⋅s⁻²\
\
const output = si::strf(\
    acceleration,\
    "km/s^2",\
    prec=3,\
    notation=si::E,\
    encoding=si::ASCII,\
) as str;\
\>\> 2.00e-02 km/s^2\

=== Supported units ===

All symbols are case sensitive unless otherwise indicated.

Decimal prefix symbols \[symbol=exponent\]

- <a href="#QUETTA" class="ref">QUETTA</a> (Q) = 1e30
- <a href="#RONNA" class="ref">RONNA</a> (R) = 1e27
- <a href="#YOTTA" class="ref">YOTTA</a> (Y) = 1e24
- <a href="#ZETTA" class="ref">ZETTA</a> (Z) = 1e21
- <a href="#EXA" class="ref">EXA</a> (E) = 1e18
- <a href="#PETA" class="ref">PETA</a> (P) = 1e15
- <a href="#TERA" class="ref">TERA</a> (T) = 1e12
- <a href="#GIGA" class="ref">GIGA</a> (G) = 1e9
- <a href="#MEGA" class="ref">MEGA</a> (M) = 1e6
- <a href="#KILO" class="ref">KILO</a> (k) = 1e3
- <a href="#HECTO" class="ref">HECTO</a> (h) = 1e2
- <a href="#DECA" class="ref">DECA</a> (da) = 1e1
- <a href="#DECI" class="ref">DECI</a> (d) = 1e-1
- <a href="#CENTI" class="ref">CENTI</a> (c) = 1e-2
- <a href="#MILLI" class="ref">MILLI</a> (m) = 1e-3
- <a href="#MICRO" class="ref">MICRO</a> (µ) = 1e-6
- <a href="#NANO" class="ref">NANO</a> (n) = 1e-9
- <a href="#PICO" class="ref">PICO</a> (p) = 1e-12
- <a href="#FEMTO" class="ref">FEMTO</a> (f) = 1e-15
- <a href="#ATTO" class="ref">ATTO</a> (a) = 1e-18
- <a href="#ZEPTO" class="ref">ZEPTO</a> (z) = 1e-21
- <a href="#YOCTO" class="ref">YOCTO</a> (y) = 1e-24
- <a href="#RONTO" class="ref">RONTO</a> (r) = 1e-27
- <a href="#QUECTO" class="ref">QUECTO</a> (q) = 1e-30

Notes:

- Formatted ASCII output for <a href="#MICRO" class="ref">MICRO</a> uses
  LATIN SMALL LETTER U (U+0075)
- Formattted UTF-8 output for <a href="#MICRO" class="ref">MICRO</a>
  uses GREEK SMALL LETTER MU (U+03BC).
- The parser for <a href="#MICRO" class="ref">MICRO</a> also accepts
  MICRO SIGN (U+00B5).

SI unit symbols

- <a href="#AMPERE" class="ref">AMPERE</a> (A)
- <a href="#BECQUEREL" class="ref">BECQUEREL</a> (Bq)
- <a href="#CANDELA" class="ref">CANDELA</a> (cd)
- <a href="#COULOMB" class="ref">COULOMB</a> (C)
- <a href="#FARAD" class="ref">FARAD</a> (F)
- <a href="#GRAM" class="ref">GRAM</a> (g)
- <a href="#GRAY" class="ref">GRAY</a> (Gy)
- <a href="#HENRY" class="ref">HENRY</a> (H)
- <a href="#HERTZ" class="ref">HERTZ</a> (Hz)
- <a href="#JOULE" class="ref">JOULE</a> (J)
- <a href="#KATAL" class="ref">KATAL</a> (kat)
- <a href="#KELVIN" class="ref">KELVIN</a> (K)
- <a href="#LUMEN" class="ref">LUMEN</a> (lm)
- <a href="#LUX" class="ref">LUX</a> (lx)
- <a href="#METRE" class="ref">METRE</a> (m)
- <a href="#MOLE" class="ref">MOLE</a> (mol)
- <a href="#NEWTON" class="ref">NEWTON</a> (N)
- <a href="#OHM" class="ref">OHM</a> (ohm/Ω)
- <a href="#PASCAL" class="ref">PASCAL</a> (Pa)
- <a href="#RADIAN" class="ref">RADIAN</a> (rad)
- <a href="#SECOND" class="ref">SECOND</a> (s)
- <a href="#SIEMENS" class="ref">SIEMENS</a> (S)
- <a href="#SIEVERT" class="ref">SIEVERT</a> (Sv)
- <a href="#STERADIAN" class="ref">STERADIAN</a> (sr)
- <a href="#TESLA" class="ref">TESLA</a> (T)
- <a href="#VOLT" class="ref">VOLT</a> (V)
- <a href="#WATT" class="ref">WATT</a> (W)
- <a href="#WEBER" class="ref">WEBER</a> (Wb)

Notes:

- UTF-8 output for <a href="#OHM" class="ref">OHM</a> uses GREEK CAPITAL
  LETTER OMEGA (U+03A9).
- The parser for <a href="#OHM" class="ref">OHM</a> also accepts OHM
  SIGN (U+2126).

Non-SI unit symbols \[name=symbol\]

- <a href="#ASTRONOMICAL_UNIT" class="ref">ASTRONOMICAL_UNIT</a> (au)
- <a href="#BEL" class="ref">BEL</a> (B)
- <a href="#DALTON" class="ref">DALTON</a> (Da)
- <a href="#DAY" class="ref">DAY</a> (d)
- <a href="#DEGREE" class="ref">DEGREE</a> (deg/°)
- <a href="#DEGREE_CELSIUS" class="ref">DEGREE_CELSIUS</a> (degC/°C)
- <a href="#ELECTRONVOLT" class="ref">ELECTRONVOLT</a> (eV)
- <a href="#HECTARE" class="ref">HECTARE</a> (ha)
- <a href="#HOUR" class="ref">HOUR</a> (h)
- <a href="#LITRE" class="ref">LITRE</a> (L)
- <a href="#MINUTE" class="ref">MINUTE</a> (min)
- <a href="#NEPER" class="ref">NEPER</a> (Np)
- <a href="#TONNE" class="ref">TONNE</a> (t)

Notes:

- Logarithmic units <a href="#BEL" class="ref">BEL</a> and
  <a href="#NEPER" class="ref">NEPER</a> do not currently support
  conversion.
- Temperature conversions are not currently supported.
  <a href="#DEGREE_CELSIUS" class="ref">DEGREE_CELSIUS</a> is treated as
  <a href="#KELVIN" class="ref">KELVIN</a>.
- The formatted UTF-8 outputs for
  <a href="#DEGREE" class="ref">DEGREE</a> use DEGREE SIGN (U+00B0).
- The formatted output for <a href="#LITRE" class="ref">LITRE</a> uses
  LATIN CAPITAL LETTER L (U+004C).
- The parser for <a href="#LITRE" class="ref">LITRE</a> also accepts
  LATIN SMALL LETTER L (U+006C).

</div>

### Index

#### Types

\
<span class="keyword">type</span> [dimension](#dimension);\
<span class="keyword">type</span> [encoding](#encoding);\
<span class="keyword">type</span> [notation](#notation);\
<span class="keyword">type</span> [prefix_kind](#prefix_kind);\
<span class="keyword">type</span> [quantity](#quantity);\
<span class="keyword">type</span> [symbol_kind](#symbol_kind);\
<span class="keyword">type</span> [unit](#unit);\
\
<span class="comment">// Undocumented types:</span>\
<span class="keyword">type</span> [token](#token);\
<span class="keyword">type</span> [token_kind](#token_kind);\
<span class="keyword">type</span> [unit_kind](#unit_kind);\

#### Errors

\
<span class="keyword">type</span> [dimension_mismatch](#dimension_mismatch);\
<span class="keyword">type</span> [error](#error);\
<span class="keyword">type</span> [invalid](#invalid);\
<span class="keyword">type</span> [invalid_exponent](#invalid_exponent);\
<span class="keyword">type</span> [no_match](#no_match);\
<span class="keyword">type</span> [not_implemented](#not_implemented);\
\
<span class="comment">// Undocumented Errors:</span>\
<span class="keyword">type</span> [invalid_token](#invalid_token);\
<span class="keyword">type</span> [unclosed_scope](#unclosed_scope);\
<span class="keyword">type</span> [unexpected_token](#unexpected_token);\

#### Constants

\
<span class="keyword">def</span> [ABSORBED_DOSE](#ABSORBED_DOSE) = dimension {\
    length = 2,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [ACTIVITY](#ACTIVITY) = dimension {\
    time = -1,\
    ...\
};\
<span class="keyword">def</span> [ANGSTROM](#ANGSTROM) = unit {\
    dim = LENGTH,\
    scale = 1.0e-10,\
};\
<span class="keyword">def</span> [ASTRONOMICAL_UNIT](#ASTRONOMICAL_UNIT) = unit {\
    dim = LENGTH,\
    scale = 149597870700.0,\
};\
<span class="keyword">def</span> [ATMOSPHERE](#ATMOSPHERE) = unit {\
    dim = PRESSURE,\
    scale = 101325.0,\
};\
<span class="keyword">def</span> [AVOGADRO](#AVOGADRO) = quantity {\
    unit = RECIPROCAL_MOLE,\
    value = 6.02214076e23,\
};\
<span class="keyword">def</span> [BAR](#BAR) = unit {\
    dim = PRESSURE,\
    scale = 1.0e5,\
};\
<span class="keyword">def</span> [BARN](#BARN) = unit {\
    dim = AREA,\
    scale = 1.0e-28,\
};\
<span class="keyword">def</span> [BEL](#BEL) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [BOLTZMANN](#BOLTZMANN) = quantity {\
    unit = JOULE_PER_KELVIN,\
    value = 1.380649e-23,\
};\
<span class="keyword">def</span> [CALORIE](#CALORIE) = unit {\
    dim = ENERGY,\
    scale = 4.184,\
};\
<span class="keyword">def</span> [CAPACITANCE](#CAPACITANCE) = dimension {\
    mass = -1,\
    length = -2,\
    time = 4,\
    current = 2,\
    ...\
};\
<span class="keyword">def</span> [CATALYTIC_ACTIVITY](#CATALYTIC_ACTIVITY) = dimension {\
    time = -1,\
    substance = 1,\
    ...\
};\
<span class="keyword">def</span> [CENTIMETRE](#CENTIMETRE) = unit {\
    dim = LENGTH,\
    scale = 0.01,\
};\
<span class="keyword">def</span> [CONDUCTANCE](#CONDUCTANCE) = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    current = 2,\
    ...\
};\
<span class="keyword">def</span> [CUBIC_CENTIMETRE](#CUBIC_CENTIMETRE) = unit {\
    dim = VOLUME,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [CUBIC_MILLIMETRE](#CUBIC_MILLIMETRE) = unit {\
    dim = VOLUME,\
    scale = 1.0e-9,\
};\
<span class="keyword">def</span> [CURIE](#CURIE) = unit {\
    dim = ACTIVITY,\
    scale = 3.7e10,\
};\
<span class="keyword">def</span> [CURRENT](#CURRENT) = dimension {\
    current = 1,\
    ...\
};\
<span class="keyword">def</span> [DALTON](#DALTON) = unit {\
    dim = MASS,\
    scale = 1.66053906892e-27,\
};\
<span class="keyword">def</span> [DAY](#DAY) = unit {\
    dim = TIME,\
    scale = 86400.0,\
};\
<span class="keyword">def</span> [DECAMETRE](#DECAMETRE) = unit {\
    dim = LENGTH,\
    scale = 10.0,\
};\
<span class="keyword">def</span> [DECIMETRE](#DECIMETRE) = unit {\
    dim = LENGTH,\
    scale = 0.1,\
};\
<span class="keyword">def</span> [DEGREE](#DEGREE) = unit {\
    dim = DIMENSIONLESS,\
    scale = 0.017453292519943295,\
};\
<span class="keyword">def</span> [DIMENSIONLESS](#DIMENSIONLESS) = dimension {\
    ...\
};\
<span class="keyword">def</span> [DOSE_EQUIVALENT](#DOSE_EQUIVALENT) = dimension {\
    length = 2,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [DYNAMIC_VISCOSITY](#DYNAMIC_VISCOSITY) = dimension {\
    mass = 1,\
    length = -1,\
    time = -1,\
    ...\
};\
<span class="keyword">def</span> [DYNE](#DYNE) = unit {\
    dim = FORCE,\
    scale = 1.0e-5,\
};\
<span class="keyword">def</span> [ELECTRIC_CHARGE](#ELECTRIC_CHARGE) = dimension {\
    time = 1,\
    current = 1,\
    ...\
};\
<span class="keyword">def</span> [ELECTRIC_POTENTIAL](#ELECTRIC_POTENTIAL) = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -1,\
    ...\
};\
<span class="keyword">def</span> [ELECTRONVOLT](#ELECTRONVOLT) = unit {\
    dim = ENERGY,\
    scale = 1.602176634e-19,\
};\
<span class="keyword">def</span> [ELEMENTARY_CHARGE](#ELEMENTARY_CHARGE) = quantity {\
    unit = COULOMB,\
    value = 1.602176634e-19,\
};\
<span class="keyword">def</span> [ENERGY](#ENERGY) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [ERG](#ERG) = unit {\
    dim = ENERGY,\
    scale = 1.0e-7,\
};\
<span class="keyword">def</span> [EXPOSURE](#EXPOSURE) = dimension {\
    mass = -1,\
    time = 1,\
    current = 1,\
    ...\
};\
<span class="keyword">def</span> [FORCE](#FORCE) = dimension {\
    mass = 1,\
    length = 1,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [FREQUENCY](#FREQUENCY) = dimension {\
    time = -1,\
    ...\
};\
<span class="keyword">def</span> [GAL](#GAL) = unit {\
    dim = ACCELERATION,\
    scale = 0.01,\
};\
<span class="keyword">def</span> [GAUSS](#GAUSS) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-4,\
};\
<span class="keyword">def</span> [GIGAHERTZ](#GIGAHERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0e9,\
};\
<span class="keyword">def</span> [GIGAJOULE](#GIGAJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e9,\
};\
<span class="keyword">def</span> [GIGAPASCAL](#GIGAPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e9,\
};\
<span class="keyword">def</span> [GIGAWATT](#GIGAWATT) = unit {\
    dim = POWER,\
    scale = 1.0e9,\
};\
<span class="keyword">def</span> [GRAM](#GRAM) = unit {\
    dim = MASS,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [HECTARE](#HECTARE) = unit {\
    dim = AREA,\
    scale = 1.0e4,\
};\
<span class="keyword">def</span> [HECTOMETRE](#HECTOMETRE) = unit {\
    dim = LENGTH,\
    scale = 100.0,\
};\
<span class="keyword">def</span> [HECTOPASCAL](#HECTOPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 100.0,\
};\
<span class="keyword">def</span> [HOUR](#HOUR) = unit {\
    dim = TIME,\
    scale = 3600.0,\
};\
<span class="keyword">def</span> [HYPERFINE_TRANSITION_CAESIUM_133](#HYPERFINE_TRANSITION_CAESIUM_133) = quantity {\
    unit = HERTZ,\
    value = 9192631770.0,\
};\
<span class="keyword">def</span> [ILLUMINANCE](#ILLUMINANCE) = dimension {\
    length = -2,\
    luminosity = 1,\
    ...\
};\
<span class="keyword">def</span> [INDUCTANCE](#INDUCTANCE) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -2,\
    ...\
};\
<span class="keyword">def</span> [JOULE_PER_KELVIN](#JOULE_PER_KELVIN) = unit {\
    dim = ENTROPY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [JOULE_SECOND](#JOULE_SECOND) = unit {\
    dim = ACTION,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [KILOHERTZ](#KILOHERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILOJOULE](#KILOJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILOMETRE](#KILOMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILONEWTON](#KILONEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILOOHM](#KILOOHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILOPASCAL](#KILOPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILOVOLT](#KILOVOLT) = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KILOWATT](#KILOWATT) = unit {\
    dim = POWER,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [KINEMATIC_VISCOSITY](#KINEMATIC_VISCOSITY) = dimension {\
    length = 2,\
    time = -1,\
    ...\
};\
<span class="keyword">def</span> [LENGTH](#LENGTH) = dimension {\
    length = 1,\
    ...\
};\
<span class="keyword">def</span> [LITRE](#LITRE) = unit {\
    dim = VOLUME,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [LUMINOSITY](#LUMINOSITY) = dimension {\
    luminosity = 1,\
    ...\
};\
<span class="keyword">def</span> [LUMINOUS_EFFICACY_540_THZ](#LUMINOUS_EFFICACY_540_THZ) = quantity {\
    unit = LUMEN_PER_WATT,\
    value = 683.0,\
};\
<span class="keyword">def</span> [LUMINOUS_FLUX](#LUMINOUS_FLUX) = dimension {\
    luminosity = 1,\
    ...\
};\
<span class="keyword">def</span> [MAGNETIC_FLUX](#MAGNETIC_FLUX) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -1,\
    ...\
};\
<span class="keyword">def</span> [MAGNETIC_FLUX_DENSITY](#MAGNETIC_FLUX_DENSITY) = dimension {\
    mass = 1,\
    time = -2,\
    current = -1,\
    ...\
};\
<span class="keyword">def</span> [MASS](#MASS) = dimension {\
    mass = 1,\
    ...\
};\
<span class="keyword">def</span> [MAXWELL](#MAXWELL) = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-8,\
};\
<span class="keyword">def</span> [MEGAHERTZ](#MEGAHERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [MEGAJOULE](#MEGAJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [MEGANEWTON](#MEGANEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [MEGAOHM](#MEGAOHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [MEGAPASCAL](#MEGAPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [MEGAWATT](#MEGAWATT) = unit {\
    dim = POWER,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [MICROAMPERE](#MICROAMPERE) = unit {\
    dim = CURRENT,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MICROCOULOMB](#MICROCOULOMB) = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MICROFARAD](#MICROFARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MICROGRAM](#MICROGRAM) = unit {\
    dim = MASS,\
    scale = 1.0e-9,\
};\
<span class="keyword">def</span> [MICROMETRE](#MICROMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MICRON](#MICRON) = MICROMETRE;\
<span class="keyword">def</span> [MICROSECOND](#MICROSECOND) = unit {\
    dim = TIME,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MICROTESLA](#MICROTESLA) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MILLIAMPERE](#MILLIAMPERE) = unit {\
    dim = CURRENT,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLICOULOMB](#MILLICOULOMB) = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIGRAM](#MILLIGRAM) = unit {\
    dim = MASS,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [MILLIJOULE](#MILLIJOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIMETRE](#MILLIMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIMETRES_OF_MERCURY](#MILLIMETRES_OF_MERCURY) = unit {\
    dim = PRESSURE,\
    scale = 133.322,\
};\
<span class="keyword">def</span> [MILLINEWTON](#MILLINEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIOHM](#MILLIOHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIPASCAL](#MILLIPASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIPASCAL_SECOND](#MILLIPASCAL_SECOND) = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLISECOND](#MILLISECOND) = unit {\
    dim = TIME,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLITESLA](#MILLITESLA) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIVOLT](#MILLIVOLT) = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIWATT](#MILLIWATT) = unit {\
    dim = POWER,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MILLIWEBER](#MILLIWEBER) = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-3,\
};\
<span class="keyword">def</span> [MINUTE](#MINUTE) = unit {\
    dim = TIME,\
    scale = 60.0,\
};\
<span class="keyword">def</span> [NANOFARAD](#NANOFARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-9,\
};\
<span class="keyword">def</span> [NANOMETRE](#NANOMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-9,\
};\
<span class="keyword">def</span> [NANOSECOND](#NANOSECOND) = unit {\
    dim = TIME,\
    scale = 1.0e-9,\
};\
<span class="keyword">def</span> [NEPER](#NEPER) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [NEWTON_METRE](#NEWTON_METRE) = unit {\
    dim = TORQUE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [NEWTON_PER_METRE](#NEWTON_PER_METRE) = unit {\
    dim = SURFACE_TENSION,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [OERSTED](#OERSTED) = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 79.57747155,\
};\
<span class="keyword">def</span> [PASCAL_SECOND](#PASCAL_SECOND) = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [PICOFARAD](#PICOFARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-12,\
};\
<span class="keyword">def</span> [PICOMETRE](#PICOMETRE) = unit {\
    dim = LENGTH,\
    scale = 1.0e-12,\
};\
<span class="keyword">def</span> [PLANCK](#PLANCK) = quantity {\
    unit = JOULE_SECOND,\
    value = 6.62607015e-34,\
};\
<span class="keyword">def</span> [POISE](#POISE) = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 0.1,\
};\
<span class="keyword">def</span> [POWER](#POWER) = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    ...\
};\
<span class="keyword">def</span> [PRESSURE](#PRESSURE) = dimension {\
    mass = 1,\
    length = -1,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [RAD](#RAD) = unit {\
    dim = ABSORBED_DOSE,\
    scale = 0.01,\
};\
<span class="keyword">def</span> [RECIPROCAL_CURRENT](#RECIPROCAL_CURRENT) = dimension {\
    current = -1,\
    ...\
};\
<span class="keyword">def</span> [RECIPROCAL_LUMINOSITY](#RECIPROCAL_LUMINOSITY) = dimension {\
    luminosity = -1,\
    ...\
};\
<span class="keyword">def</span> [RECIPROCAL_MASS](#RECIPROCAL_MASS) = dimension {\
    mass = -1,\
    ...\
};\
<span class="keyword">def</span> [RECIPROCAL_SUBSTANCE](#RECIPROCAL_SUBSTANCE) = dimension {\
    substance = -1,\
    ...\
};\
<span class="keyword">def</span> [RECIPROCAL_TEMPERATURE](#RECIPROCAL_TEMPERATURE) = dimension {\
    temperature = -1,\
    ...\
};\
<span class="keyword">def</span> [REM](#REM) = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 0.01,\
};\
<span class="keyword">def</span> [RESISTANCE](#RESISTANCE) = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -2,\
    ...\
};\
<span class="keyword">def</span> [ROENTGEN](#ROENTGEN) = unit {\
    dim = EXPOSURE,\
    scale = 2.58e-4,\
};\
<span class="keyword">def</span> [SPEED_OF_LIGHT](#SPEED_OF_LIGHT) = quantity {\
    unit = METRE_PER_SECOND,\
    value = 299792458.0,\
};\
<span class="keyword">def</span> [SQUARE_CENTIMETRE](#SQUARE_CENTIMETRE) = unit {\
    dim = AREA,\
    scale = 1.0e-4,\
};\
<span class="keyword">def</span> [SQUARE_KILOMETRE](#SQUARE_KILOMETRE) = unit {\
    dim = AREA,\
    scale = 1.0e6,\
};\
<span class="keyword">def</span> [SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND) = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [SQUARE_MILLIMETRE](#SQUARE_MILLIMETRE) = unit {\
    dim = AREA,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [SQUARE_MILLIMETRE_PER_SECOND](#SQUARE_MILLIMETRE_PER_SECOND) = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-6,\
};\
<span class="keyword">def</span> [STOKES](#STOKES) = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-4,\
};\
<span class="keyword">def</span> [SUBSTANCE](#SUBSTANCE) = dimension {\
    substance = 1,\
    ...\
};\
<span class="keyword">def</span> [TEMPERATURE](#TEMPERATURE) = dimension {\
    temperature = 1,\
    ...\
};\
<span class="keyword">def</span> [TIME](#TIME) = dimension {\
    time = 1,\
    ...\
};\
<span class="keyword">def</span> [TONNE](#TONNE) = unit {\
    dim = MASS,\
    scale = 1.0e3,\
};\
<span class="keyword">def</span> [TORR](#TORR) = unit {\
    dim = PRESSURE,\
    scale = 133.322368421,\
};\
<span class="keyword">def</span> [WAVENUMBER](#WAVENUMBER) = dimension {\
    length = -1,\
    ...\
};\
\
<span class="comment">// Undocumented constants:</span>\
<span class="keyword">def</span> [ACCELERATION](#ACCELERATION) = dimension {\
    length = 1,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [ACTION](#ACTION) = dimension {\
    mass = 1,\
    length = 2,\
    time = -1,\
    ...\
};\
<span class="keyword">def</span> [AMPERE](#AMPERE) = unit {\
    dim = CURRENT,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [AMPERE_PER_METRE](#AMPERE_PER_METRE) = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [AMPERE_PER_SQUARE_METRE](#AMPERE_PER_SQUARE_METRE) = unit {\
    dim = CURRENT_DENSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [AREA](#AREA) = dimension {\
    length = 2,\
    ...\
};\
<span class="keyword">def</span> [ATTO](#ATTO): <span class="type">f64</span> = 1.0e-18;\
<span class="keyword">def</span> [BECQUEREL](#BECQUEREL) = unit {\
    dim = ACTIVITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [CANDELA](#CANDELA) = unit {\
    dim = LUMINOSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [CANDELA_PER_SQUARE_METRE](#CANDELA_PER_SQUARE_METRE) = unit {\
    dim = LUMINANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [CENTI](#CENTI): <span class="type">f64</span> = 0.01;\
<span class="keyword">def</span> [CONCENTRATION](#CONCENTRATION) = dimension {\
    substance = 1,\
    length = -3,\
    ...\
};\
<span class="keyword">def</span> [COULOMB](#COULOMB) = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [COULOMB_PER_KILOGRAM](#COULOMB_PER_KILOGRAM) = unit {\
    dim = EXPOSURE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [CUBIC_METRE](#CUBIC_METRE) = unit {\
    dim = VOLUME,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [CUBIC_METRE_PER_KILOGRAM](#CUBIC_METRE_PER_KILOGRAM) = unit {\
    dim = SPECIFIC_VOLUME,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [CURRENT_DENSITY](#CURRENT_DENSITY) = dimension {\
    current = 1,\
    length = -2,\
    ...\
};\
<span class="keyword">def</span> [DECA](#DECA): <span class="type">f64</span> = 10.0;\
<span class="keyword">def</span> [DECI](#DECI): <span class="type">f64</span> = 0.1;\
<span class="keyword">def</span> [DEGREE_CELSIUS](#DEGREE_CELSIUS) = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [DENSITY](#DENSITY) = dimension {\
    mass = 1,\
    length = -3,\
    ...\
};\
<span class="keyword">def</span> [DIMENSIONLESS_UNIT](#DIMENSIONLESS_UNIT) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [ENTROPY](#ENTROPY) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    temperature = -1,\
    ...\
};\
<span class="keyword">def</span> [EXA](#EXA): <span class="type">f64</span> = 1.0e18;\
<span class="keyword">def</span> [FARAD](#FARAD) = unit {\
    dim = CAPACITANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [FEMTO](#FEMTO): <span class="type">f64</span> = 1.0e-15;\
<span class="keyword">def</span> [GIGA](#GIGA): <span class="type">f64</span> = 1.0e9;\
<span class="keyword">def</span> [GRAY](#GRAY) = unit {\
    dim = ABSORBED_DOSE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [HECTO](#HECTO): <span class="type">f64</span> = 100.0;\
<span class="keyword">def</span> [HENRY](#HENRY) = unit {\
    dim = INDUCTANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [HERTZ](#HERTZ) = unit {\
    dim = FREQUENCY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [JOULE](#JOULE) = unit {\
    dim = ENERGY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [KATAL](#KATAL) = unit {\
    dim = CATALYTIC_ACTIVITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [KELVIN](#KELVIN) = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [KILO](#KILO): <span class="type">f64</span> = 1.0e3;\
<span class="keyword">def</span> [KILOGRAM](#KILOGRAM) = unit {\
    dim = MASS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [KILOGRAM_PER_CUBIC_METRE](#KILOGRAM_PER_CUBIC_METRE) = unit {\
    dim = DENSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [KILOGRAM_PER_SQUARE_METRE](#KILOGRAM_PER_SQUARE_METRE) = unit {\
    dim = SURFACE_DENSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [LUMEN](#LUMEN) = unit {\
    dim = LUMINOUS_FLUX,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [LUMEN_PER_WATT](#LUMEN_PER_WATT) = unit {\
    dim = LUMINOUS_EFFICACY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [LUMINANCE](#LUMINANCE) = dimension {\
    luminosity = 1,\
    length = -2,\
    ...\
};\
<span class="keyword">def</span> [LUMINOUS_EFFICACY](#LUMINOUS_EFFICACY) = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    luminosity = 1,\
    ...\
};\
<span class="keyword">def</span> [LUX](#LUX) = unit {\
    dim = ILLUMINANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [MAGNETIC_FIELD_STRENGTH](#MAGNETIC_FIELD_STRENGTH) = dimension {\
    current = 1,\
    length = -1,\
    ...\
};\
<span class="keyword">def</span> [MEGA](#MEGA): <span class="type">f64</span> = 1.0e6;\
<span class="keyword">def</span> [METRE](#METRE) = unit {\
    dim = LENGTH,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [METRE_PER_SECOND](#METRE_PER_SECOND) = unit {\
    dim = VELOCITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [METRE_PER_SECOND_SQUARED](#METRE_PER_SECOND_SQUARED) = unit {\
    dim = ACCELERATION,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [MICRO](#MICRO): <span class="type">f64</span> = 1.0e-6;\
<span class="keyword">def</span> [MILLI](#MILLI): <span class="type">f64</span> = 1.0e-3;\
<span class="keyword">def</span> [MOLE](#MOLE) = unit {\
    dim = SUBSTANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [MOLE_PER_CUBIC_METRE](#MOLE_PER_CUBIC_METRE) = unit {\
    dim = CONCENTRATION,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [NANO](#NANO): <span class="type">f64</span> = 1.0e-9;\
<span class="keyword">def</span> [NEWTON](#NEWTON) = unit {\
    dim = FORCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [NONE](#NONE): <span class="type">f64</span> = 1.0;\
<span class="keyword">def</span> [OHM](#OHM) = unit {\
    dim = RESISTANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [PASCAL](#PASCAL) = unit {\
    dim = PRESSURE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [PETA](#PETA): <span class="type">f64</span> = 1.0e15;\
<span class="keyword">def</span> [PICO](#PICO): <span class="type">f64</span> = 1.0e-12;\
<span class="keyword">def</span> [QUECTO](#QUECTO): <span class="type">f64</span> = 1.0e-30;\
<span class="keyword">def</span> [QUETTA](#QUETTA): <span class="type">f64</span> = 1.0e30;\
<span class="keyword">def</span> [RADIAN](#RADIAN) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RECIPROCAL_AMPERE](#RECIPROCAL_AMPERE) = unit {\
    dim = RECIPROCAL_CURRENT,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RECIPROCAL_CANDELA](#RECIPROCAL_CANDELA) = unit {\
    dim = RECIPROCAL_LUMINOSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RECIPROCAL_KELVIN](#RECIPROCAL_KELVIN) = unit {\
    dim = RECIPROCAL_TEMPERATURE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RECIPROCAL_KILOGRAM](#RECIPROCAL_KILOGRAM) = unit {\
    dim = RECIPROCAL_MASS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RECIPROCAL_METRE](#RECIPROCAL_METRE) = unit {\
    dim = WAVENUMBER,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RECIPROCAL_MOLE](#RECIPROCAL_MOLE) = unit {\
    dim = RECIPROCAL_SUBSTANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [RONNA](#RONNA): <span class="type">f64</span> = 1.0e27;\
<span class="keyword">def</span> [RONTO](#RONTO): <span class="type">f64</span> = 1.0e-27;\
<span class="keyword">def</span> [SECOND](#SECOND) = unit {\
    dim = TIME,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [SIEMENS](#SIEMENS) = unit {\
    dim = CONDUCTANCE,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [SIEVERT](#SIEVERT) = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [SPECIFIC_VOLUME](#SPECIFIC_VOLUME) = dimension {\
    mass = -1,\
    length = 3,\
    ...\
};\
<span class="keyword">def</span> [SQUARE_METRE](#SQUARE_METRE) = unit {\
    dim = AREA,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [STERADIAN](#STERADIAN) = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [SURFACE_DENSITY](#SURFACE_DENSITY) = dimension {\
    mass = 1,\
    length = -2,\
    ...\
};\
<span class="keyword">def</span> [SURFACE_TENSION](#SURFACE_TENSION) = dimension {\
    mass = 1,\
    length = 0,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [TERA](#TERA): <span class="type">f64</span> = 1.0e12;\
<span class="keyword">def</span> [TESLA](#TESLA) = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [TORQUE](#TORQUE) = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    ...\
};\
<span class="keyword">def</span> [VELOCITY](#VELOCITY) = dimension {\
    length = 1,\
    time = -1,\
    ...\
};\
<span class="keyword">def</span> [VOLT](#VOLT) = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [VOLUME](#VOLUME) = dimension {\
    length = 3,\
    ...\
};\
<span class="keyword">def</span> [WATT](#WATT) = unit {\
    dim = POWER,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [WEBER](#WEBER) = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0,\
};\
<span class="keyword">def</span> [YOCTO](#YOCTO): <span class="type">f64</span> = 1.0e-24;\
<span class="keyword">def</span> [YOTTA](#YOTTA): <span class="type">f64</span> = 1.0e24;\
<span class="keyword">def</span> [ZEPTO](#ZEPTO): <span class="type">f64</span> = 1.0e-21;\
<span class="keyword">def</span> [ZETTA](#ZETTA): <span class="type">f64</span> = 1.0e21;\

#### Globals

\
<span class="keyword">const</span> [GIT_VERSION](#GIT_VERSION): <span class="type">str</span>;\
<span class="keyword">const</span> [SEM_VERSION](#SEM_VERSION): <span class="type">str</span>;\

#### Functions

\
<span class="keyword">fn</span> [add](#add)(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span><span class="type">)</span>;\
<span class="keyword">fn</span> [divd](#divd)(a: <span class="type">dimension</span>, b: <span class="type">dimension</span>) <span class="type">dimension</span>;\
<span class="keyword">fn</span> [divq](#divq)(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">quantity</span>;\
<span class="keyword">fn</span> [divu](#divu)(a: <span class="type">unit</span>, b: <span class="type">unit</span>) <span class="type">unit</span>;\
<span class="keyword">fn</span> [encodejson](#encodejson)(h: <span class="type">io</span><span class="type">::</span><span class="type">handle</span>, obj: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [equal](#equal)(a: <span class="type">dimension</span>, b: <span class="type">dimension</span>) <span class="type">bool</span>;\
<span class="keyword">fn</span> [fprint](#fprint)(out: <span class="type">io</span><span class="type">::</span><span class="type">handle</span>, x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [identify](#identify)(in: <span class="type">str</span>) <span class="type">(</span><span class="type">prefix_kind</span><span class="type">,</span> <span class="type">unit_kind</span><span class="type">)</span>;\
<span class="keyword">fn</span> [isclose](#isclose)(a: <span class="type">quantity</span>, b: <span class="type">quantity</span>, tol: <span class="type">f64</span> = math::STANDARD_TOL) <span class="type">(</span><span class="type">bool</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span><span class="type">)</span>;\
<span class="keyword">fn</span> [isinf](#isinf)(q: <span class="type">quantity</span>) <span class="type">bool</span>;\
<span class="keyword">fn</span> [isnan](#isnan)(q: <span class="type">quantity</span>) <span class="type">bool</span>;\
<span class="keyword">fn</span> [muld](#muld)(a: <span class="type">dimension</span>, b: <span class="type">dimension</span>) <span class="type">dimension</span>;\
<span class="keyword">fn</span> [mulq](#mulq)(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">quantity</span>;\
<span class="keyword">fn</span> [mulu](#mulu)(a: <span class="type">unit</span>, b: <span class="type">unit</span>) <span class="type">unit</span>;\
<span class="keyword">fn</span> [powd](#powd)(x: <span class="type">dimension</span>, p: <span class="type">int</span>) <span class="type">dimension</span>;\
<span class="keyword">fn</span> [powq](#powq)(x: <span class="type">quantity</span>, p: <span class="type">int</span>) <span class="type">quantity</span>;\
<span class="keyword">fn</span> [powu](#powu)(x: <span class="type">unit</span>, p: <span class="type">int</span>) <span class="type">unit</span>;\
<span class="keyword">fn</span> [print](#print)(x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [println](#println)(x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [scale](#scale)(u: <span class="type">unit</span>, fac: <span class="type">(</span><span class="type">prefix_kind</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">unit</span>;\
<span class="keyword">fn</span> [strerror](#strerror)(err: <span class="type">error</span>) <span class="type">str</span>;\
<span class="keyword">fn</span> [strf](#strf)(x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [strp](#strp)(s: <span class="type">str</span>) <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [strpu](#strpu)(s: <span class="type">str</span>) <span class="type">(</span><span class="type">unit</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
<span class="keyword">fn</span> [sub](#sub)(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span><span class="type">)</span>;\
<span class="keyword">fn</span> [tojson](#tojson)(obj: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>) <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\
\
<span class="comment">// Undocumented functions:</span>\
<span class="keyword">fn</span> [split](#split)(input: <span class="type">str</span>) <span class="type">(</span><span class="type">(</span><span class="type">str</span><span class="type">,</span> <span class="type">str</span><span class="type">)</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;\

### Types

<div class="section member">

#### <span class="heading-body">type dimension</span><span class="heading-extra">[\[permalink\]](#dimension)</span>

\
<span class="keyword">type</span> dimension = <span class="type">struct</span> {\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> mass</span><span class="comment">\
</span> mass: <span class="type">int</span>,\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> length</span><span class="comment">\
</span> length: <span class="type">int</span>,\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> time</span><span class="comment">\
</span> time: <span class="type">int</span>,\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> electric current</span><span class="comment">\
</span> current: <span class="type">int</span>,\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> thermodynamic temperature</span><span class="comment">\
</span> temperature: <span class="type">int</span>,\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> amount of substance</span><span class="comment">\
</span> substance: <span class="type">int</span>,\
<span class="comment">  </span><span class="comment">//</span><span class="comment"> luminous intensity</span><span class="comment">\
</span> luminosity: <span class="type">int</span>,\
};

Represents the dimensional exponents of the seven SI base dimensions.

</div>

<div class="section member">

#### <span class="heading-body">type encoding</span><span class="heading-extra">[\[permalink\]](#encoding)</span>

\
<span class="keyword">type</span> encoding = <span class="type">enum</span> <span class="type">u8</span> {\
    ASCII,\
    UTF8,\
    JSON,\
};

Specifies the character encoding options.

</div>

<div class="section member">

#### <span class="heading-body">type notation</span><span class="heading-extra">[\[permalink\]](#notation)</span>

\
<span class="keyword">type</span> notation = <span class="type">enum</span> <span class="type">u8</span> {\
    GENERAL,\
    FIXED,\
    SCIENTIFIC,\
    E_UPPER,\
    E_LOWER,\
};

Specifies the notation used to format floating-point values.

</div>

<div class="section member">

#### <span class="heading-body">type prefix_kind</span><span class="heading-extra">[\[permalink\]](#prefix_kind)</span>

\
<span class="keyword">type</span> prefix_kind = <span class="type">enum</span> <span class="type">i8</span> {\
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

</div>

<div class="section member">

#### <span class="heading-body">type quantity</span><span class="heading-extra">[\[permalink\]](#quantity)</span>

\
<span class="keyword">type</span> quantity = <span class="type">struct</span> {\
    unit: <span class="type">unit</span>,\
    value: <span class="type">f64</span>,\
};

Represents a physical quantity as a unit and numerical value.

</div>

<div class="section member">

#### <span class="heading-body">type symbol_kind</span><span class="heading-extra">[\[permalink\]](#symbol_kind)</span>

\
<span class="keyword">type</span> symbol_kind = <span class="type">(</span><span class="type">prefix_kind</span> <span class="type">\|</span> <span class="type">unit_kind</span><span class="type">)</span>;

Union of symbol enum types.

</div>

<div class="section member">

#### <span class="heading-body">type unit</span><span class="heading-extra">[\[permalink\]](#unit)</span>

\
<span class="keyword">type</span> unit = <span class="type">struct</span> {\
    dim: <span class="type">dimension</span>,\
    scale: <span class="type">f64</span>,\
};

Represents a unit of measurement by its physical
<a href="#dimension" class="ref">dimension</a> and scale.

</div>

<div class="section member">

#### <span class="heading-body">type token</span><span class="heading-extra">[\[permalink\]](#token)</span>

Show undocumented member

\
<span class="keyword">type</span> token = <span class="type">struct</span> {\
    kind: <span class="type">token_kind</span>,\
    text: <span class="type">str</span>,\
    pos: <span class="type">size</span>,\
};

</div>

<div class="section member">

#### <span class="heading-body">type token_kind</span><span class="heading-extra">[\[permalink\]](#token_kind)</span>

Show undocumented member

\
<span class="keyword">type</span> token_kind = <span class="type">enum</span> <span class="type">u8</span> {\
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

</div>

<div class="section member">

#### <span class="heading-body">type unit_kind</span><span class="heading-extra">[\[permalink\]](#unit_kind)</span>

Show undocumented member

\
<span class="keyword">type</span> unit_kind = <span class="type">enum</span> {\
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

</div>

### Errors

<div class="section member">

#### <span class="heading-body">type dimension_mismatch</span><span class="heading-extra">[\[permalink\]](#dimension_mismatch)</span>

\
<span class="keyword">type</span> dimension_mismatch = <span class="type">!</span><span class="type">void</span>;

The dimensions of two units or quantities do not match.

</div>

<div class="section member">

#### <span class="heading-body">type error</span><span class="heading-extra">[\[permalink\]](#error)</span>

\
<span class="keyword">type</span> error = <span class="type">!</span><span class="type">(</span><span class="type">no_match</span> <span class="type">\|</span> <span class="type">invalid_exponent</span> <span class="type">\|</span> <span class="type">unexpected_token</span> <span class="type">\|</span> <span class="type">unclosed_scope</span> <span class="type">\|</span> <span class="type">invalid_token</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span> <span class="type">\|</span> <span class="type">not_implemented</span> <span class="type">\|</span> <span class="type">invalid</span> <span class="type">\|</span> <span class="type">io</span><span class="type">::</span><span class="type">error</span> <span class="type">\|</span> <span class="type">strconv</span><span class="type">::</span><span class="type">invalid</span> <span class="type">\|</span> <span class="type">strconv</span><span class="type">::</span><span class="type">overflow</span> <span class="type">\|</span> <span class="type">utf8</span><span class="type">::</span><span class="type">invalid</span> <span class="type">\|</span> <span class="type">nomem</span><span class="type">)</span>;

Represents any error that can occur in the si library

</div>

<div class="section member">

#### <span class="heading-body">type invalid</span><span class="heading-extra">[\[permalink\]](#invalid)</span>

\
<span class="keyword">type</span> invalid = <span class="type">!</span><span class="type">void</span>;

The input is invalid.

</div>

<div class="section member">

#### <span class="heading-body">type invalid_exponent</span><span class="heading-extra">[\[permalink\]](#invalid_exponent)</span>

\
<span class="keyword">type</span> invalid_exponent = <span class="type">!</span><span class="type">void</span>;

An invalid exponent was encountered.

</div>

<div class="section member">

#### <span class="heading-body">type no_match</span><span class="heading-extra">[\[permalink\]](#no_match)</span>

\
<span class="keyword">type</span> no_match = <span class="type">!</span><span class="type">str</span>;

No matching unit or prefix was found.

</div>

<div class="section member">

#### <span class="heading-body">type not_implemented</span><span class="heading-extra">[\[permalink\]](#not_implemented)</span>

\
<span class="keyword">type</span> not_implemented = <span class="type">!</span><span class="type">void</span>;

The requested operation is not implemented.

</div>

<div class="section member">

#### <span class="heading-body">type invalid_token</span><span class="heading-extra">[\[permalink\]](#invalid_token)</span>

Show undocumented member

\
<span class="keyword">type</span> invalid_token = <span class="type">!</span><span class="type">token</span>;

</div>

<div class="section member">

#### <span class="heading-body">type unclosed_scope</span><span class="heading-extra">[\[permalink\]](#unclosed_scope)</span>

Show undocumented member

\
<span class="keyword">type</span> unclosed_scope = <span class="type">!</span><span class="type">void</span>;

</div>

<div class="section member">

#### <span class="heading-body">type unexpected_token</span><span class="heading-extra">[\[permalink\]](#unexpected_token)</span>

Show undocumented member

\
<span class="keyword">type</span> unexpected_token = <span class="type">!</span><span class="type">token</span>;

</div>

### Constants

<div class="section member">

#### <span class="heading-body">def ABSORBED_DOSE</span><span class="heading-extra">[\[permalink\]](#ABSORBED_DOSE)</span>

\
<span class="keyword">def</span> ABSORBED_DOSE = dimension {\
    length = 2,\
    time = -2,\
    ...\
};

The SI derived dimension of absorbed dose. Its SI unit is
<a href="#GRAY" class="ref">GRAY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ACTIVITY</span><span class="heading-extra">[\[permalink\]](#ACTIVITY)</span>

\
<span class="keyword">def</span> ACTIVITY = dimension {\
    time = -1,\
    ...\
};

The SI derived dimension of radioactive activity. Its SI unit is
<a href="#BECQUEREL" class="ref">BECQUEREL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ANGSTROM</span><span class="heading-extra">[\[permalink\]](#ANGSTROM)</span>

\
<span class="keyword">def</span> ANGSTROM = unit {\
    dim = LENGTH,\
    scale = 1.0e-10,\
};

The angstrom is a non-SI unit of length still widely used in the natural
sciences and technology to express atomic-scale lengths. See
<a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ASTRONOMICAL_UNIT</span><span class="heading-extra">[\[permalink\]](#ASTRONOMICAL_UNIT)</span>

\
<span class="keyword">def</span> ASTRONOMICAL_UNIT = unit {\
    dim = LENGTH,\
    scale = 149597870700.0,\
};

The astronomical unit is a non-SI unit of length that approximately
equates to the average distance between the Sun and the Earth. As of
2012, it is standardised to a fixed length in metres. See
<a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ATMOSPHERE</span><span class="heading-extra">[\[permalink\]](#ATMOSPHERE)</span>

\
<span class="keyword">def</span> ATMOSPHERE = unit {\
    dim = PRESSURE,\
    scale = 101325.0,\
};

The standard atmosphere is widely used in chemistry, physics, and
engineering as a reference pressure. See
<a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def AVOGADRO</span><span class="heading-extra">[\[permalink\]](#AVOGADRO)</span>

\
<span class="keyword">def</span> AVOGADRO = quantity {\
    unit = RECIPROCAL_MOLE,\
    value = 6.02214076e23,\
};

The Avogadro constant, an exact defining constant of the SI representing
the number of elementary entities in one mole. Its SI unit is
<a href="#RECIPROCAL_MOLE" class="ref">RECIPROCAL_MOLE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def BAR</span><span class="heading-extra">[\[permalink\]](#BAR)</span>

\
<span class="keyword">def</span> BAR = unit {\
    dim = PRESSURE,\
    scale = 1.0e5,\
};

The bar is a metric unit of pressure commonly used in meteorology and
acoustics. Not to be confused with the CGS unit 'Barye'.

</div>

<div class="section member">

#### <span class="heading-body">def BARN</span><span class="heading-extra">[\[permalink\]](#BARN)</span>

\
<span class="keyword">def</span> BARN = unit {\
    dim = AREA,\
    scale = 1.0e-28,\
};

The barn is commonly used in nuclear and particle physics to express
cross-sectional areas of atomic nuclei and subatomic interactions.

</div>

<div class="section member">

#### <span class="heading-body">def BEL</span><span class="heading-extra">[\[permalink\]](#BEL)</span>

\
<span class="keyword">def</span> BEL = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

The bel is a non-SI relative logarithmic unit commonly used in
acoustics, telecommunications, and signal processing to express ratios
of power quantities. This unit is dimensionless and does not support
conversion. See also: <a href="#NEPER" class="ref">NEPER</a>.

</div>

<div class="section member">

#### <span class="heading-body">def BOLTZMANN</span><span class="heading-extra">[\[permalink\]](#BOLTZMANN)</span>

\
<span class="keyword">def</span> BOLTZMANN = quantity {\
    unit = JOULE_PER_KELVIN,\
    value = 1.380649e-23,\
};

The Boltzmann constant, an exact defining constant of the SI relating
thermal energy to thermodynamic temperature. Its SI unit is
<a href="#JOULE_PER_KELVIN" class="ref">JOULE_PER_KELVIN</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CALORIE</span><span class="heading-extra">[\[permalink\]](#CALORIE)</span>

\
<span class="keyword">def</span> CALORIE = unit {\
    dim = ENERGY,\
    scale = 4.184,\
};

The calorie is non-SI unit commonly used in thermodynamics, chemistry,
and nutritional science to express energy. See
<a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CAPACITANCE</span><span class="heading-extra">[\[permalink\]](#CAPACITANCE)</span>

\
<span class="keyword">def</span> CAPACITANCE = dimension {\
    mass = -1,\
    length = -2,\
    time = 4,\
    current = 2,\
    ...\
};

The SI derived dimension of capacitance. Its SI unit is
<a href="#FARAD" class="ref">FARAD</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CATALYTIC_ACTIVITY</span><span class="heading-extra">[\[permalink\]](#CATALYTIC_ACTIVITY)</span>

\
<span class="keyword">def</span> CATALYTIC_ACTIVITY = dimension {\
    time = -1,\
    substance = 1,\
    ...\
};

The SI derived dimension of catalytic activity. Its SI unit is
<a href="#KATAL" class="ref">KATAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CENTIMETRE</span><span class="heading-extra">[\[permalink\]](#CENTIMETRE)</span>

\
<span class="keyword">def</span> CENTIMETRE = unit {\
    dim = LENGTH,\
    scale = 0.01,\
};

The centimetre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CONDUCTANCE</span><span class="heading-extra">[\[permalink\]](#CONDUCTANCE)</span>

\
<span class="keyword">def</span> CONDUCTANCE = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    current = 2,\
    ...\
};

The SI derived dimension of electrical conductance. Its SI unit is
<a href="#SIEMENS" class="ref">SIEMENS</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CUBIC_CENTIMETRE</span><span class="heading-extra">[\[permalink\]](#CUBIC_CENTIMETRE)</span>

\
<span class="keyword">def</span> CUBIC_CENTIMETRE = unit {\
    dim = VOLUME,\
    scale = 1.0e-6,\
};

The cubic centimetre is a scaled SI unit of volume. The corresponding
unscaled SI unit is the
<a href="#CUBIC_METRE" class="ref">CUBIC_METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CUBIC_MILLIMETRE</span><span class="heading-extra">[\[permalink\]](#CUBIC_MILLIMETRE)</span>

\
<span class="keyword">def</span> CUBIC_MILLIMETRE = unit {\
    dim = VOLUME,\
    scale = 1.0e-9,\
};

The cubic millimetre is a scaled SI unit of volume. The corresponding
unscaled SI unit is the
<a href="#CUBIC_METRE" class="ref">CUBIC_METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CURIE</span><span class="heading-extra">[\[permalink\]](#CURIE)</span>

\
<span class="keyword">def</span> CURIE = unit {\
    dim = ACTIVITY,\
    scale = 3.7e10,\
};

The curie is a non-SI unit historically used in nuclear physics to
express radioactivity. See
<a href="#BECQUEREL" class="ref">BECQUEREL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def CURRENT</span><span class="heading-extra">[\[permalink\]](#CURRENT)</span>

\
<span class="keyword">def</span> CURRENT = dimension {\
    current = 1,\
    ...\
};

The SI base dimension of electric current.

</div>

<div class="section member">

#### <span class="heading-body">def DALTON</span><span class="heading-extra">[\[permalink\]](#DALTON)</span>

\
<span class="keyword">def</span> DALTON = unit {\
    dim = MASS,\
    scale = 1.66053906892e-27,\
};

The dalton

</div>

<div class="section member">

#### <span class="heading-body">def DAY</span><span class="heading-extra">[\[permalink\]](#DAY)</span>

\
<span class="keyword">def</span> DAY = unit {\
    dim = TIME,\
    scale = 86400.0,\
};

The day is a non-SI unit of time. See
<a href="#SECOND" class="ref">SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def DECAMETRE</span><span class="heading-extra">[\[permalink\]](#DECAMETRE)</span>

\
<span class="keyword">def</span> DECAMETRE = unit {\
    dim = LENGTH,\
    scale = 10.0,\
};

The decametre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def DECIMETRE</span><span class="heading-extra">[\[permalink\]](#DECIMETRE)</span>

\
<span class="keyword">def</span> DECIMETRE = unit {\
    dim = LENGTH,\
    scale = 0.1,\
};

The decimetre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def DEGREE</span><span class="heading-extra">[\[permalink\]](#DEGREE)</span>

\
<span class="keyword">def</span> DEGREE = unit {\
    dim = DIMENSIONLESS,\
    scale = 0.017453292519943295,\
};

The degree

</div>

<div class="section member">

#### <span class="heading-body">def DIMENSIONLESS</span><span class="heading-extra">[\[permalink\]](#DIMENSIONLESS)</span>

\
<span class="keyword">def</span> DIMENSIONLESS = dimension {\
    ...\
};

The dimensionless dimension, with all SI base dimension exponents equal
to zero.

</div>

<div class="section member">

#### <span class="heading-body">def DOSE_EQUIVALENT</span><span class="heading-extra">[\[permalink\]](#DOSE_EQUIVALENT)</span>

\
<span class="keyword">def</span> DOSE_EQUIVALENT = dimension {\
    length = 2,\
    time = -2,\
    ...\
};

The SI derived dimension of dose equivalent. Its SI unit is
<a href="#SIEVERT" class="ref">SIEVERT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def DYNAMIC_VISCOSITY</span><span class="heading-extra">[\[permalink\]](#DYNAMIC_VISCOSITY)</span>

\
<span class="keyword">def</span> DYNAMIC_VISCOSITY = dimension {\
    mass = 1,\
    length = -1,\
    time = -1,\
    ...\
};

The SI derived dimension of dynamic viscosity. Its SI unit is
<a href="#PASCAL_SECOND" class="ref">PASCAL_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def DYNE</span><span class="heading-extra">[\[permalink\]](#DYNE)</span>

\
<span class="keyword">def</span> DYNE = unit {\
    dim = FORCE,\
    scale = 1.0e-5,\
};

The dyne is a CGS unit used in mechanics and fluid dynamics to express
force. See <a href="#NEWTON" class="ref">NEWTON</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ELECTRIC_CHARGE</span><span class="heading-extra">[\[permalink\]](#ELECTRIC_CHARGE)</span>

\
<span class="keyword">def</span> ELECTRIC_CHARGE = dimension {\
    time = 1,\
    current = 1,\
    ...\
};

The SI derived dimension of electric charge. Its SI unit is
<a href="#COULOMB" class="ref">COULOMB</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ELECTRIC_POTENTIAL</span><span class="heading-extra">[\[permalink\]](#ELECTRIC_POTENTIAL)</span>

\
<span class="keyword">def</span> ELECTRIC_POTENTIAL = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -1,\
    ...\
};

The SI derived dimension of electric potential. Its SI unit is
<a href="#VOLT" class="ref">VOLT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ELECTRONVOLT</span><span class="heading-extra">[\[permalink\]](#ELECTRONVOLT)</span>

\
<span class="keyword">def</span> ELECTRONVOLT = unit {\
    dim = ENERGY,\
    scale = 1.602176634e-19,\
};

The electronvolt

</div>

<div class="section member">

#### <span class="heading-body">def ELEMENTARY_CHARGE</span><span class="heading-extra">[\[permalink\]](#ELEMENTARY_CHARGE)</span>

\
<span class="keyword">def</span> ELEMENTARY_CHARGE = quantity {\
    unit = COULOMB,\
    value = 1.602176634e-19,\
};

The elementary charge, an exact defining constant of the SI
corresponding to the magnitude of the electric charge of a proton. Its
SI unit is <a href="#COULOMB" class="ref">COULOMB</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ENERGY</span><span class="heading-extra">[\[permalink\]](#ENERGY)</span>

\
<span class="keyword">def</span> ENERGY = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    ...\
};

The SI derived dimension of energy. Its SI unit is
<a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ERG</span><span class="heading-extra">[\[permalink\]](#ERG)</span>

\
<span class="keyword">def</span> ERG = unit {\
    dim = ENERGY,\
    scale = 1.0e-7,\
};

The erg is a CGS unit commonly used in classical mechanics,
astrophysics, and other areas of physics to express energy. The SI
counterpart unit is the <a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def EXPOSURE</span><span class="heading-extra">[\[permalink\]](#EXPOSURE)</span>

\
<span class="keyword">def</span> EXPOSURE = dimension {\
    mass = -1,\
    time = 1,\
    current = 1,\
    ...\
};

The SI derived dimension of exposure to ionising radiation. Its SI unit
is <a href="#COULOMB_PER_KILOGRAM" class="ref">COULOMB_PER_KILOGRAM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def FORCE</span><span class="heading-extra">[\[permalink\]](#FORCE)</span>

\
<span class="keyword">def</span> FORCE = dimension {\
    mass = 1,\
    length = 1,\
    time = -2,\
    ...\
};

The SI derived dimension of force. Its SI unit is
<a href="#NEWTON" class="ref">NEWTON</a>.

</div>

<div class="section member">

#### <span class="heading-body">def FREQUENCY</span><span class="heading-extra">[\[permalink\]](#FREQUENCY)</span>

\
<span class="keyword">def</span> FREQUENCY = dimension {\
    time = -1,\
    ...\
};

The SI derived dimension of frequency. Its SI unit is
<a href="#HERTZ" class="ref">HERTZ</a>.

</div>

<div class="section member">

#### <span class="heading-body">def GAL</span><span class="heading-extra">[\[permalink\]](#GAL)</span>

\
<span class="keyword">def</span> GAL = unit {\
    dim = ACCELERATION,\
    scale = 0.01,\
};

The gal is a CGS unit commonly used in geophysics and gravimetry to
express acceleration. The SI counterpart unit is the
<a href="#METRE_PER_SECOND_SQUARED"
class="ref">METRE_PER_SECOND_SQUARED</a>

</div>

<div class="section member">

#### <span class="heading-body">def GAUSS</span><span class="heading-extra">[\[permalink\]](#GAUSS)</span>

\
<span class="keyword">def</span> GAUSS = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-4,\
};

The gauss is a CGS unit commonly used in physics and engineering to
express magnetic flux density. The SI counterpart unit is the
<a href="#TESLA" class="ref">TESLA</a>

</div>

<div class="section member">

#### <span class="heading-body">def GIGAHERTZ</span><span class="heading-extra">[\[permalink\]](#GIGAHERTZ)</span>

\
<span class="keyword">def</span> GIGAHERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0e9,\
};

The gigahertz is a scaled SI unit of frequency. The corresponding
unscaled SI unit is the <a href="#HERTZ" class="ref">HERTZ</a>.

</div>

<div class="section member">

#### <span class="heading-body">def GIGAJOULE</span><span class="heading-extra">[\[permalink\]](#GIGAJOULE)</span>

\
<span class="keyword">def</span> GIGAJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e9,\
};

The gigajoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the <a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def GIGAPASCAL</span><span class="heading-extra">[\[permalink\]](#GIGAPASCAL)</span>

\
<span class="keyword">def</span> GIGAPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e9,\
};

The gigapascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the <a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def GIGAWATT</span><span class="heading-extra">[\[permalink\]](#GIGAWATT)</span>

\
<span class="keyword">def</span> GIGAWATT = unit {\
    dim = POWER,\
    scale = 1.0e9,\
};

The gigawatt is a scaled SI unit of power. The corresponding unscaled SI
unit is the <a href="#WATT" class="ref">WATT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def GRAM</span><span class="heading-extra">[\[permalink\]](#GRAM)</span>

\
<span class="keyword">def</span> GRAM = unit {\
    dim = MASS,\
    scale = 1.0e-3,\
};

The gram is a scaled SI unit of mass. The corresponding unscaled SI unit
is the <a href="#KILOGRAM" class="ref">KILOGRAM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def HECTARE</span><span class="heading-extra">[\[permalink\]](#HECTARE)</span>

\
<span class="keyword">def</span> HECTARE = unit {\
    dim = AREA,\
    scale = 1.0e4,\
};

The hectare is non-SI metric unit commonly used to express areas of
land. The SI counterpart unit is the
<a href="#SQUARE_METRE" class="ref">SQUARE_METRE</a>

</div>

<div class="section member">

#### <span class="heading-body">def HECTOMETRE</span><span class="heading-extra">[\[permalink\]](#HECTOMETRE)</span>

\
<span class="keyword">def</span> HECTOMETRE = unit {\
    dim = LENGTH,\
    scale = 100.0,\
};

The hectometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def HECTOPASCAL</span><span class="heading-extra">[\[permalink\]](#HECTOPASCAL)</span>

\
<span class="keyword">def</span> HECTOPASCAL = unit {\
    dim = PRESSURE,\
    scale = 100.0,\
};

The hectopascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the <a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def HOUR</span><span class="heading-extra">[\[permalink\]](#HOUR)</span>

\
<span class="keyword">def</span> HOUR = unit {\
    dim = TIME,\
    scale = 3600.0,\
};

The hour is non-SI unit of time. The SI counterpart unit is the
<a href="#SECOND" class="ref">SECOND</a>

</div>

<div class="section member">

#### <span class="heading-body">def HYPERFINE_TRANSITION_CAESIUM_133</span><span class="heading-extra">[\[permalink\]](#HYPERFINE_TRANSITION_CAESIUM_133)</span>

\
<span class="keyword">def</span> HYPERFINE_TRANSITION_CAESIUM_133 = quantity {\
    unit = HERTZ,\
    value = 9192631770.0,\
};

The caesium-133 hyperfine transition frequency, which defines the SI
second. Its SI unit is <a href="#HERTZ" class="ref">HERTZ</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ILLUMINANCE</span><span class="heading-extra">[\[permalink\]](#ILLUMINANCE)</span>

\
<span class="keyword">def</span> ILLUMINANCE = dimension {\
    length = -2,\
    luminosity = 1,\
    ...\
};

The SI derived dimension of illuminance. Its SI unit is
<a href="#LUX" class="ref">LUX</a>.

</div>

<div class="section member">

#### <span class="heading-body">def INDUCTANCE</span><span class="heading-extra">[\[permalink\]](#INDUCTANCE)</span>

\
<span class="keyword">def</span> INDUCTANCE = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -2,\
    ...\
};

The SI derived dimension of inductance. Its SI unit is
<a href="#HENRY" class="ref">HENRY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def JOULE_PER_KELVIN</span><span class="heading-extra">[\[permalink\]](#JOULE_PER_KELVIN)</span>

\
<span class="keyword">def</span> JOULE_PER_KELVIN = unit {\
    dim = ENTROPY,\
    scale = 1.0,\
};

The joule per kelvin is the coherent SI unit of
<a href="#ENTROPY" class="ref">ENTROPY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def JOULE_SECOND</span><span class="heading-extra">[\[permalink\]](#JOULE_SECOND)</span>

\
<span class="keyword">def</span> JOULE_SECOND = unit {\
    dim = ACTION,\
    scale = 1.0,\
};

The joule-second is the coherent SI unit of
<a href="#ACTION" class="ref">ACTION</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOHERTZ</span><span class="heading-extra">[\[permalink\]](#KILOHERTZ)</span>

\
<span class="keyword">def</span> KILOHERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0e3,\
};

The kilohertz is a scaled SI unit of frequency. The corresponding
unscaled SI unit is the <a href="#HERTZ" class="ref">HERTZ</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOJOULE</span><span class="heading-extra">[\[permalink\]](#KILOJOULE)</span>

\
<span class="keyword">def</span> KILOJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e3,\
};

The kilojoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the <a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOMETRE</span><span class="heading-extra">[\[permalink\]](#KILOMETRE)</span>

\
<span class="keyword">def</span> KILOMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e3,\
};

The kilometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILONEWTON</span><span class="heading-extra">[\[permalink\]](#KILONEWTON)</span>

\
<span class="keyword">def</span> KILONEWTON = unit {\
    dim = FORCE,\
    scale = 1.0e3,\
};

The kilonewton is a scaled SI unit of force. The corresponding unscaled
SI unit is the <a href="#NEWTON" class="ref">NEWTON</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOOHM</span><span class="heading-extra">[\[permalink\]](#KILOOHM)</span>

\
<span class="keyword">def</span> KILOOHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0e3,\
};

The kiloohm is a scaled SI unit of electrical resistance. The
corresponding unscaled SI unit is the
<a href="#OHM" class="ref">OHM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOPASCAL</span><span class="heading-extra">[\[permalink\]](#KILOPASCAL)</span>

\
<span class="keyword">def</span> KILOPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e3,\
};

The kilopascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the <a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOVOLT</span><span class="heading-extra">[\[permalink\]](#KILOVOLT)</span>

\
<span class="keyword">def</span> KILOVOLT = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e3,\
};

The kilovolt is a scaled SI unit of electric potential. The
corresponding unscaled SI unit is the
<a href="#VOLT" class="ref">VOLT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KILOWATT</span><span class="heading-extra">[\[permalink\]](#KILOWATT)</span>

\
<span class="keyword">def</span> KILOWATT = unit {\
    dim = POWER,\
    scale = 1.0e3,\
};

The kilowatt is a scaled SI unit of power. The corresponding unscaled SI
unit is the <a href="#WATT" class="ref">WATT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def KINEMATIC_VISCOSITY</span><span class="heading-extra">[\[permalink\]](#KINEMATIC_VISCOSITY)</span>

\
<span class="keyword">def</span> KINEMATIC_VISCOSITY = dimension {\
    length = 2,\
    time = -1,\
    ...\
};

The SI derived dimension of kinematic viscosity. Its SI unit is
<a href="#SQUARE_METRE_PER_SECOND"
class="ref">SQUARE_METRE_PER_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def LENGTH</span><span class="heading-extra">[\[permalink\]](#LENGTH)</span>

\
<span class="keyword">def</span> LENGTH = dimension {\
    length = 1,\
    ...\
};

The SI base dimension of length.

</div>

<div class="section member">

#### <span class="heading-body">def LITRE</span><span class="heading-extra">[\[permalink\]](#LITRE)</span>

\
<span class="keyword">def</span> LITRE = unit {\
    dim = VOLUME,\
    scale = 1.0e-3,\
};

The litre is a non-SI metric unit of volume in common general use. See
<a href="#CUBIC_METRE" class="ref">CUBIC_METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def LUMINOSITY</span><span class="heading-extra">[\[permalink\]](#LUMINOSITY)</span>

\
<span class="keyword">def</span> LUMINOSITY = dimension {\
    luminosity = 1,\
    ...\
};

The SI base dimension of luminous intensity.

</div>

<div class="section member">

#### <span class="heading-body">def LUMINOUS_EFFICACY_540_THZ</span><span class="heading-extra">[\[permalink\]](#LUMINOUS_EFFICACY_540_THZ)</span>

\
<span class="keyword">def</span> LUMINOUS_EFFICACY_540_THZ = quantity {\
    unit = LUMEN_PER_WATT,\
    value = 683.0,\
};

The luminous efficacy of monochromatic radiation at 540 THz, an exact
defining constant of the SI for
<a href="#LUMINOUS_EFFICACY" class="ref">LUMINOUS_EFFICACY</a>. Its SI
unit is <a href="#LUMEN_PER_WATT" class="ref">LUMEN_PER_WATT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def LUMINOUS_FLUX</span><span class="heading-extra">[\[permalink\]](#LUMINOUS_FLUX)</span>

\
<span class="keyword">def</span> LUMINOUS_FLUX = dimension {\
    luminosity = 1,\
    ...\
};

The SI derived dimension of luminous flux. Its SI unit is
<a href="#LUMEN" class="ref">LUMEN</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MAGNETIC_FLUX</span><span class="heading-extra">[\[permalink\]](#MAGNETIC_FLUX)</span>

\
<span class="keyword">def</span> MAGNETIC_FLUX = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    current = -1,\
    ...\
};

The SI derived dimension of magnetic flux. Its SI unit is
<a href="#WEBER" class="ref">WEBER</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MAGNETIC_FLUX_DENSITY</span><span class="heading-extra">[\[permalink\]](#MAGNETIC_FLUX_DENSITY)</span>

\
<span class="keyword">def</span> MAGNETIC_FLUX_DENSITY = dimension {\
    mass = 1,\
    time = -2,\
    current = -1,\
    ...\
};

The SI derived dimension of magnetic flux density. Its SI unit is
<a href="#TESLA" class="ref">TESLA</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MASS</span><span class="heading-extra">[\[permalink\]](#MASS)</span>

\
<span class="keyword">def</span> MASS = dimension {\
    mass = 1,\
    ...\
};

The SI base dimension of mass.

</div>

<div class="section member">

#### <span class="heading-body">def MAXWELL</span><span class="heading-extra">[\[permalink\]](#MAXWELL)</span>

\
<span class="keyword">def</span> MAXWELL = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-8,\
};

The maxwell is a CGS electromagnetic unit used to express magnetic flux.
The SI counterpart unit is the <a href="#WEBER" class="ref">WEBER</a>

</div>

<div class="section member">

#### <span class="heading-body">def MEGAHERTZ</span><span class="heading-extra">[\[permalink\]](#MEGAHERTZ)</span>

\
<span class="keyword">def</span> MEGAHERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0e6,\
};

The megahertz is a scaled SI unit of frequency. The corresponding
unscaled SI unit is the <a href="#HERTZ" class="ref">HERTZ</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MEGAJOULE</span><span class="heading-extra">[\[permalink\]](#MEGAJOULE)</span>

\
<span class="keyword">def</span> MEGAJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e6,\
};

The megajoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the <a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MEGANEWTON</span><span class="heading-extra">[\[permalink\]](#MEGANEWTON)</span>

\
<span class="keyword">def</span> MEGANEWTON = unit {\
    dim = FORCE,\
    scale = 1.0e6,\
};

The meganewton is a scaled SI unit of force. The corresponding unscaled
SI unit is the <a href="#NEWTON" class="ref">NEWTON</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MEGAOHM</span><span class="heading-extra">[\[permalink\]](#MEGAOHM)</span>

\
<span class="keyword">def</span> MEGAOHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0e6,\
};

The megaohm is a scaled SI unit of electrical resistance. The
corresponding unscaled SI unit is the
<a href="#OHM" class="ref">OHM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MEGAPASCAL</span><span class="heading-extra">[\[permalink\]](#MEGAPASCAL)</span>

\
<span class="keyword">def</span> MEGAPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e6,\
};

The megapascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the <a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MEGAWATT</span><span class="heading-extra">[\[permalink\]](#MEGAWATT)</span>

\
<span class="keyword">def</span> MEGAWATT = unit {\
    dim = POWER,\
    scale = 1.0e6,\
};

The megawatt is a scaled SI unit of power. The corresponding unscaled SI
unit is the <a href="#WATT" class="ref">WATT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROAMPERE</span><span class="heading-extra">[\[permalink\]](#MICROAMPERE)</span>

\
<span class="keyword">def</span> MICROAMPERE = unit {\
    dim = CURRENT,\
    scale = 1.0e-6,\
};

The microampere is a scaled SI unit of electric current. The
corresponding unscaled SI unit is the
<a href="#AMPERE" class="ref">AMPERE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROCOULOMB</span><span class="heading-extra">[\[permalink\]](#MICROCOULOMB)</span>

\
<span class="keyword">def</span> MICROCOULOMB = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-6,\
};

The microcoulomb is a scaled SI unit of electric charge. The
corresponding unscaled SI unit is the
<a href="#COULOMB" class="ref">COULOMB</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROFARAD</span><span class="heading-extra">[\[permalink\]](#MICROFARAD)</span>

\
<span class="keyword">def</span> MICROFARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-6,\
};

The microfarad is a scaled SI unit of capacitance. The corresponding
unscaled SI unit is the <a href="#FARAD" class="ref">FARAD</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROGRAM</span><span class="heading-extra">[\[permalink\]](#MICROGRAM)</span>

\
<span class="keyword">def</span> MICROGRAM = unit {\
    dim = MASS,\
    scale = 1.0e-9,\
};

The microgram is a scaled SI unit of mass. The corresponding unscaled SI
unit is the <a href="#KILOGRAM" class="ref">KILOGRAM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROMETRE</span><span class="heading-extra">[\[permalink\]](#MICROMETRE)</span>

\
<span class="keyword">def</span> MICROMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-6,\
};

The micrometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICRON</span><span class="heading-extra">[\[permalink\]](#MICRON)</span>

\
<span class="keyword">def</span> MICRON = MICROMETRE;

The micron is an alternative name for the
<a href="#MICROMETRE" class="ref">MICROMETRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROSECOND</span><span class="heading-extra">[\[permalink\]](#MICROSECOND)</span>

\
<span class="keyword">def</span> MICROSECOND = unit {\
    dim = TIME,\
    scale = 1.0e-6,\
};

The microsecond is a scaled SI unit of time. The corresponding unscaled
SI unit is the <a href="#SECOND" class="ref">SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MICROTESLA</span><span class="heading-extra">[\[permalink\]](#MICROTESLA)</span>

\
<span class="keyword">def</span> MICROTESLA = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-6,\
};

The microtesla is a scaled SI unit of magnetic flux density. The
corresponding unscaled SI unit is the
<a href="#TESLA" class="ref">TESLA</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIAMPERE</span><span class="heading-extra">[\[permalink\]](#MILLIAMPERE)</span>

\
<span class="keyword">def</span> MILLIAMPERE = unit {\
    dim = CURRENT,\
    scale = 1.0e-3,\
};

The milliampere is a scaled SI unit of electric current. The
corresponding unscaled SI unit is the
<a href="#AMPERE" class="ref">AMPERE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLICOULOMB</span><span class="heading-extra">[\[permalink\]](#MILLICOULOMB)</span>

\
<span class="keyword">def</span> MILLICOULOMB = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0e-3,\
};

The millicoulomb is a scaled SI unit of electric charge. The
corresponding unscaled SI unit is the
<a href="#COULOMB" class="ref">COULOMB</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIGRAM</span><span class="heading-extra">[\[permalink\]](#MILLIGRAM)</span>

\
<span class="keyword">def</span> MILLIGRAM = unit {\
    dim = MASS,\
    scale = 1.0e-6,\
};

The milligram is a scaled SI unit of mass. The corresponding unscaled SI
unit is the <a href="#KILOGRAM" class="ref">KILOGRAM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIJOULE</span><span class="heading-extra">[\[permalink\]](#MILLIJOULE)</span>

\
<span class="keyword">def</span> MILLIJOULE = unit {\
    dim = ENERGY,\
    scale = 1.0e-3,\
};

The millijoule is a scaled SI unit of energy. The corresponding unscaled
SI unit is the <a href="#JOULE" class="ref">JOULE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIMETRE</span><span class="heading-extra">[\[permalink\]](#MILLIMETRE)</span>

\
<span class="keyword">def</span> MILLIMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-3,\
};

The millimetre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIMETRES_OF_MERCURY</span><span class="heading-extra">[\[permalink\]](#MILLIMETRES_OF_MERCURY)</span>

\
<span class="keyword">def</span> MILLIMETRES_OF_MERCURY = unit {\
    dim = PRESSURE,\
    scale = 133.322,\
};

Millimetres of mercury are widely used in medicine and meteorology to
express pressure. The SI counterpart unit is the
<a href="#PASCAL" class="ref">PASCAL</a>

</div>

<div class="section member">

#### <span class="heading-body">def MILLINEWTON</span><span class="heading-extra">[\[permalink\]](#MILLINEWTON)</span>

\
<span class="keyword">def</span> MILLINEWTON = unit {\
    dim = FORCE,\
    scale = 1.0e-3,\
};

The millinewton is a scaled SI unit of force. The corresponding unscaled
SI unit is the <a href="#NEWTON" class="ref">NEWTON</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIOHM</span><span class="heading-extra">[\[permalink\]](#MILLIOHM)</span>

\
<span class="keyword">def</span> MILLIOHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0e-3,\
};

The milliohm is a scaled SI unit of electrical resistance. The
corresponding unscaled SI unit is the
<a href="#OHM" class="ref">OHM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIPASCAL</span><span class="heading-extra">[\[permalink\]](#MILLIPASCAL)</span>

\
<span class="keyword">def</span> MILLIPASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0e-3,\
};

The millipascal is a scaled SI unit of pressure. The corresponding
unscaled SI unit is the <a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIPASCAL_SECOND</span><span class="heading-extra">[\[permalink\]](#MILLIPASCAL_SECOND)</span>

\
<span class="keyword">def</span> MILLIPASCAL_SECOND = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0e-3,\
};

The millipascal-second is a scaled SI unit of dynamic viscosity. The
corresponding unscaled SI unit is the
<a href="#PASCAL_SECOND" class="ref">PASCAL_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLISECOND</span><span class="heading-extra">[\[permalink\]](#MILLISECOND)</span>

\
<span class="keyword">def</span> MILLISECOND = unit {\
    dim = TIME,\
    scale = 1.0e-3,\
};

The millisecond is a scaled SI unit of time. The corresponding unscaled
SI unit is the <a href="#SECOND" class="ref">SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLITESLA</span><span class="heading-extra">[\[permalink\]](#MILLITESLA)</span>

\
<span class="keyword">def</span> MILLITESLA = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0e-3,\
};

The millitesla is a scaled SI unit of magnetic flux density. The
corresponding unscaled SI unit is the
<a href="#TESLA" class="ref">TESLA</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIVOLT</span><span class="heading-extra">[\[permalink\]](#MILLIVOLT)</span>

\
<span class="keyword">def</span> MILLIVOLT = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0e-3,\
};

The millivolt is a scaled SI unit of electric potential. The
corresponding unscaled SI unit is the
<a href="#VOLT" class="ref">VOLT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIWATT</span><span class="heading-extra">[\[permalink\]](#MILLIWATT)</span>

\
<span class="keyword">def</span> MILLIWATT = unit {\
    dim = POWER,\
    scale = 1.0e-3,\
};

The milliwatt is a scaled SI unit of power. The corresponding unscaled
SI unit is the <a href="#WATT" class="ref">WATT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MILLIWEBER</span><span class="heading-extra">[\[permalink\]](#MILLIWEBER)</span>

\
<span class="keyword">def</span> MILLIWEBER = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0e-3,\
};

The milliweber is a scaled SI unit of magnetic flux. The corresponding
unscaled SI unit is the <a href="#WEBER" class="ref">WEBER</a>.

</div>

<div class="section member">

#### <span class="heading-body">def MINUTE</span><span class="heading-extra">[\[permalink\]](#MINUTE)</span>

\
<span class="keyword">def</span> MINUTE = unit {\
    dim = TIME,\
    scale = 60.0,\
};

The minute is non-SI unit of time. The SI counterpart unit is the
<a href="#SECOND" class="ref">SECOND</a>

</div>

<div class="section member">

#### <span class="heading-body">def NANOFARAD</span><span class="heading-extra">[\[permalink\]](#NANOFARAD)</span>

\
<span class="keyword">def</span> NANOFARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-9,\
};

The nanofarad is a scaled SI unit of capacitance. The corresponding
unscaled SI unit is the <a href="#FARAD" class="ref">FARAD</a>.

</div>

<div class="section member">

#### <span class="heading-body">def NANOMETRE</span><span class="heading-extra">[\[permalink\]](#NANOMETRE)</span>

\
<span class="keyword">def</span> NANOMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-9,\
};

The nanometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def NANOSECOND</span><span class="heading-extra">[\[permalink\]](#NANOSECOND)</span>

\
<span class="keyword">def</span> NANOSECOND = unit {\
    dim = TIME,\
    scale = 1.0e-9,\
};

The nanosecond is a scaled SI unit of time. The corresponding unscaled
SI unit is the <a href="#SECOND" class="ref">SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def NEPER</span><span class="heading-extra">[\[permalink\]](#NEPER)</span>

\
<span class="keyword">def</span> NEPER = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

The neper is a non-SI relative logarithmic unit used in acoustics,
telecommunications, and signal processing to express ratios of field
quantities. This unit is dimensionless and does not support conversion.
See also: <a href="#BEL" class="ref">BEL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def NEWTON_METRE</span><span class="heading-extra">[\[permalink\]](#NEWTON_METRE)</span>

\
<span class="keyword">def</span> NEWTON_METRE = unit {\
    dim = TORQUE,\
    scale = 1.0,\
};

The newton-metre is the coherent SI unit of
<a href="#TORQUE" class="ref">TORQUE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def NEWTON_PER_METRE</span><span class="heading-extra">[\[permalink\]](#NEWTON_PER_METRE)</span>

\
<span class="keyword">def</span> NEWTON_PER_METRE = unit {\
    dim = SURFACE_TENSION,\
    scale = 1.0,\
};

The newton per metre is the coherent SI unit of
<a href="#SURFACE_TENSION" class="ref">SURFACE_TENSION</a>.

</div>

<div class="section member">

#### <span class="heading-body">def OERSTED</span><span class="heading-extra">[\[permalink\]](#OERSTED)</span>

\
<span class="keyword">def</span> OERSTED = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 79.57747155,\
};

The oersted is a CGS electromagnetic unit used to express magnetic field
strength. The SI counterpart unit is the
<a href="#HENRY" class="ref">HENRY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def PASCAL_SECOND</span><span class="heading-extra">[\[permalink\]](#PASCAL_SECOND)</span>

\
<span class="keyword">def</span> PASCAL_SECOND = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 1.0,\
};

The pascal-second is the coherent SI unit of
<a href="#DYNAMIC_VISCOSITY" class="ref">DYNAMIC_VISCOSITY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def PICOFARAD</span><span class="heading-extra">[\[permalink\]](#PICOFARAD)</span>

\
<span class="keyword">def</span> PICOFARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0e-12,\
};

The picofarad is a scaled SI unit of capacitance. The corresponding
unscaled SI unit is the <a href="#FARAD" class="ref">FARAD</a>.

</div>

<div class="section member">

#### <span class="heading-body">def PICOMETRE</span><span class="heading-extra">[\[permalink\]](#PICOMETRE)</span>

\
<span class="keyword">def</span> PICOMETRE = unit {\
    dim = LENGTH,\
    scale = 1.0e-12,\
};

The picometre is a scaled SI unit of length. The corresponding unscaled
SI unit is the <a href="#METRE" class="ref">METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def PLANCK</span><span class="heading-extra">[\[permalink\]](#PLANCK)</span>

\
<span class="keyword">def</span> PLANCK = quantity {\
    unit = JOULE_SECOND,\
    value = 6.62607015e-34,\
};

The Planck constant, an exact defining constant of the SI relating the
energy of a photon to its frequency. Its SI unit is
<a href="#JOULE_SECOND" class="ref">JOULE_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def POISE</span><span class="heading-extra">[\[permalink\]](#POISE)</span>

\
<span class="keyword">def</span> POISE = unit {\
    dim = DYNAMIC_VISCOSITY,\
    scale = 0.1,\
};

The poise is a CGS unit commonly used in rheology and fluid mechanics to
express dynamic viscosity.

</div>

<div class="section member">

#### <span class="heading-body">def POWER</span><span class="heading-extra">[\[permalink\]](#POWER)</span>

\
<span class="keyword">def</span> POWER = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    ...\
};

The SI derived dimension of power. Its SI unit is
<a href="#WATT" class="ref">WATT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def PRESSURE</span><span class="heading-extra">[\[permalink\]](#PRESSURE)</span>

\
<span class="keyword">def</span> PRESSURE = dimension {\
    mass = 1,\
    length = -1,\
    time = -2,\
    ...\
};

The SI derived dimension of pressure. Its SI unit is
<a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def RAD</span><span class="heading-extra">[\[permalink\]](#RAD)</span>

\
<span class="keyword">def</span> RAD = unit {\
    dim = ABSORBED_DOSE,\
    scale = 0.01,\
};

The rad is a non-SI unit historically used in radiobiology and radiation
dosimetry to express absorbed dose. The SI counterpart unit is the
<a href="#GRAY" class="ref">GRAY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_CURRENT</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_CURRENT)</span>

\
<span class="keyword">def</span> RECIPROCAL_CURRENT = dimension {\
    current = -1,\
    ...\
};

The reciprocal of the SI base dimension of electric current.

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_LUMINOSITY</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_LUMINOSITY)</span>

\
<span class="keyword">def</span> RECIPROCAL_LUMINOSITY = dimension {\
    luminosity = -1,\
    ...\
};

The reciprocal of the SI base dimension of luminous intensity.

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_MASS</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_MASS)</span>

\
<span class="keyword">def</span> RECIPROCAL_MASS = dimension {\
    mass = -1,\
    ...\
};

The reciprocal of the SI base dimension of mass.

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_SUBSTANCE</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_SUBSTANCE)</span>

\
<span class="keyword">def</span> RECIPROCAL_SUBSTANCE = dimension {\
    substance = -1,\
    ...\
};

The reciprocal of the SI base dimension of amount of substance.

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_TEMPERATURE</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_TEMPERATURE)</span>

\
<span class="keyword">def</span> RECIPROCAL_TEMPERATURE = dimension {\
    temperature = -1,\
    ...\
};

The reciprocal of the SI base dimension of thermodynamic temperature.

</div>

<div class="section member">

#### <span class="heading-body">def REM</span><span class="heading-extra">[\[permalink\]](#REM)</span>

\
<span class="keyword">def</span> REM = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 0.01,\
};

The rem (or Roentgen equivalent man) is a non-SI unit historically used
in radiation protection to express equivalent dose. The SI counterpart
unit is the <a href="#SIEVERT" class="ref">SIEVERT</a>.

</div>

<div class="section member">

#### <span class="heading-body">def RESISTANCE</span><span class="heading-extra">[\[permalink\]](#RESISTANCE)</span>

\
<span class="keyword">def</span> RESISTANCE = dimension {\
    mass = 1,\
    length = 2,\
    time = -3,\
    current = -2,\
    ...\
};

The SI derived dimension of electrical resistance. Its SI unit is
<a href="#OHM" class="ref">OHM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def ROENTGEN</span><span class="heading-extra">[\[permalink\]](#ROENTGEN)</span>

\
<span class="keyword">def</span> ROENTGEN = unit {\
    dim = EXPOSURE,\
    scale = 2.58e-4,\
};

The roentgen is a non-SI unit historically used in radiology and
radiation protection to express
<a href="#EXPOSURE" class="ref">EXPOSURE</a>. The SI counterpart unit is
the
<a href="#COULOMB_PER_KILOGRAM" class="ref">COULOMB_PER_KILOGRAM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SPEED_OF_LIGHT</span><span class="heading-extra">[\[permalink\]](#SPEED_OF_LIGHT)</span>

\
<span class="keyword">def</span> SPEED_OF_LIGHT = quantity {\
    unit = METRE_PER_SECOND,\
    value = 299792458.0,\
};

The speed of light in vacuum, an exact defining constant of the SI. Its
SI unit is <a href="#METRE_PER_SECOND" class="ref">METRE_PER_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SQUARE_CENTIMETRE</span><span class="heading-extra">[\[permalink\]](#SQUARE_CENTIMETRE)</span>

\
<span class="keyword">def</span> SQUARE_CENTIMETRE = unit {\
    dim = AREA,\
    scale = 1.0e-4,\
};

The square centimetre is a scaled SI unit of area. The corresponding
unscaled SI unit is the
<a href="#SQUARE_METRE" class="ref">SQUARE_METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SQUARE_KILOMETRE</span><span class="heading-extra">[\[permalink\]](#SQUARE_KILOMETRE)</span>

\
<span class="keyword">def</span> SQUARE_KILOMETRE = unit {\
    dim = AREA,\
    scale = 1.0e6,\
};

The square kilometre is a scaled SI unit of area. The corresponding
unscaled SI unit is the
<a href="#SQUARE_METRE" class="ref">SQUARE_METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SQUARE_METRE_PER_SECOND</span><span class="heading-extra">[\[permalink\]](#SQUARE_METRE_PER_SECOND)</span>

\
<span class="keyword">def</span> SQUARE_METRE_PER_SECOND = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0,\
};

The square metre per second is the coherent SI unit of
<a href="#KINEMATIC_VISCOSITY" class="ref">KINEMATIC_VISCOSITY</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SQUARE_MILLIMETRE</span><span class="heading-extra">[\[permalink\]](#SQUARE_MILLIMETRE)</span>

\
<span class="keyword">def</span> SQUARE_MILLIMETRE = unit {\
    dim = AREA,\
    scale = 1.0e-6,\
};

The square millimetre is a scaled SI unit of area. The corresponding
unscaled SI unit is the
<a href="#SQUARE_METRE" class="ref">SQUARE_METRE</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SQUARE_MILLIMETRE_PER_SECOND</span><span class="heading-extra">[\[permalink\]](#SQUARE_MILLIMETRE_PER_SECOND)</span>

\
<span class="keyword">def</span> SQUARE_MILLIMETRE_PER_SECOND = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-6,\
};

The square millimetre per second is a scaled SI unit of kinematic
viscosity. The corresponding unscaled SI unit is the
<a href="#SQUARE_METRE_PER_SECOND"
class="ref">SQUARE_METRE_PER_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def STOKES</span><span class="heading-extra">[\[permalink\]](#STOKES)</span>

\
<span class="keyword">def</span> STOKES = unit {\
    dim = KINEMATIC_VISCOSITY,\
    scale = 1.0e-4,\
};

The stokes is a CGS unit commonly used in fluid mechanics to express
viscosity. The SI counterpart unit is the
<a href="#SQUARE_METRE_PER_SECOND"
class="ref">SQUARE_METRE_PER_SECOND</a>.

</div>

<div class="section member">

#### <span class="heading-body">def SUBSTANCE</span><span class="heading-extra">[\[permalink\]](#SUBSTANCE)</span>

\
<span class="keyword">def</span> SUBSTANCE = dimension {\
    substance = 1,\
    ...\
};

The SI base dimension of amount of substance.

</div>

<div class="section member">

#### <span class="heading-body">def TEMPERATURE</span><span class="heading-extra">[\[permalink\]](#TEMPERATURE)</span>

\
<span class="keyword">def</span> TEMPERATURE = dimension {\
    temperature = 1,\
    ...\
};

The SI base dimension of thermodynamic temperature.

</div>

<div class="section member">

#### <span class="heading-body">def TIME</span><span class="heading-extra">[\[permalink\]](#TIME)</span>

\
<span class="keyword">def</span> TIME = dimension {\
    time = 1,\
    ...\
};

The SI base dimension of time.

</div>

<div class="section member">

#### <span class="heading-body">def TONNE</span><span class="heading-extra">[\[permalink\]](#TONNE)</span>

\
<span class="keyword">def</span> TONNE = unit {\
    dim = MASS,\
    scale = 1.0e3,\
};

The tonne is a non-SI metric unit of mass still in common general use.
Not to be confused with the ton units used in Imperial or Customary
systems. See <a href="#KILOGRAM" class="ref">KILOGRAM</a>.

</div>

<div class="section member">

#### <span class="heading-body">def TORR</span><span class="heading-extra">[\[permalink\]](#TORR)</span>

\
<span class="keyword">def</span> TORR = unit {\
    dim = PRESSURE,\
    scale = 133.322368421,\
};

The torr is non-SI unit historically used in physics. The SI counterpart
unit is the <a href="#PASCAL" class="ref">PASCAL</a>.

</div>

<div class="section member">

#### <span class="heading-body">def WAVENUMBER</span><span class="heading-extra">[\[permalink\]](#WAVENUMBER)</span>

\
<span class="keyword">def</span> WAVENUMBER = dimension {\
    length = -1,\
    ...\
};

The SI derived dimension of spatial frequency, expressed as the
reciprocal of length.

</div>

<div class="section member">

#### <span class="heading-body">def ACCELERATION</span><span class="heading-extra">[\[permalink\]](#ACCELERATION)</span>

Show undocumented member

\
<span class="keyword">def</span> ACCELERATION = dimension {\
    length = 1,\
    time = -2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def ACTION</span><span class="heading-extra">[\[permalink\]](#ACTION)</span>

Show undocumented member

\
<span class="keyword">def</span> ACTION = dimension {\
    mass = 1,\
    length = 2,\
    time = -1,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def AMPERE</span><span class="heading-extra">[\[permalink\]](#AMPERE)</span>

Show undocumented member

\
<span class="keyword">def</span> AMPERE = unit {\
    dim = CURRENT,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def AMPERE_PER_METRE</span><span class="heading-extra">[\[permalink\]](#AMPERE_PER_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> AMPERE_PER_METRE = unit {\
    dim = MAGNETIC_FIELD_STRENGTH,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def AMPERE_PER_SQUARE_METRE</span><span class="heading-extra">[\[permalink\]](#AMPERE_PER_SQUARE_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> AMPERE_PER_SQUARE_METRE = unit {\
    dim = CURRENT_DENSITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def AREA</span><span class="heading-extra">[\[permalink\]](#AREA)</span>

Show undocumented member

\
<span class="keyword">def</span> AREA = dimension {\
    length = 2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def ATTO</span><span class="heading-extra">[\[permalink\]](#ATTO)</span>

Show undocumented member

\
<span class="keyword">def</span> ATTO: <span class="type">f64</span> = 1.0e-18;

</div>

<div class="section member">

#### <span class="heading-body">def BECQUEREL</span><span class="heading-extra">[\[permalink\]](#BECQUEREL)</span>

Show undocumented member

\
<span class="keyword">def</span> BECQUEREL = unit {\
    dim = ACTIVITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def CANDELA</span><span class="heading-extra">[\[permalink\]](#CANDELA)</span>

Show undocumented member

\
<span class="keyword">def</span> CANDELA = unit {\
    dim = LUMINOSITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def CANDELA_PER_SQUARE_METRE</span><span class="heading-extra">[\[permalink\]](#CANDELA_PER_SQUARE_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> CANDELA_PER_SQUARE_METRE = unit {\
    dim = LUMINANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def CENTI</span><span class="heading-extra">[\[permalink\]](#CENTI)</span>

Show undocumented member

\
<span class="keyword">def</span> CENTI: <span class="type">f64</span> = 0.01;

</div>

<div class="section member">

#### <span class="heading-body">def CONCENTRATION</span><span class="heading-extra">[\[permalink\]](#CONCENTRATION)</span>

Show undocumented member

\
<span class="keyword">def</span> CONCENTRATION = dimension {\
    substance = 1,\
    length = -3,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def COULOMB</span><span class="heading-extra">[\[permalink\]](#COULOMB)</span>

Show undocumented member

\
<span class="keyword">def</span> COULOMB = unit {\
    dim = ELECTRIC_CHARGE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def COULOMB_PER_KILOGRAM</span><span class="heading-extra">[\[permalink\]](#COULOMB_PER_KILOGRAM)</span>

Show undocumented member

\
<span class="keyword">def</span> COULOMB_PER_KILOGRAM = unit {\
    dim = EXPOSURE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def CUBIC_METRE</span><span class="heading-extra">[\[permalink\]](#CUBIC_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> CUBIC_METRE = unit {\
    dim = VOLUME,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def CUBIC_METRE_PER_KILOGRAM</span><span class="heading-extra">[\[permalink\]](#CUBIC_METRE_PER_KILOGRAM)</span>

Show undocumented member

\
<span class="keyword">def</span> CUBIC_METRE_PER_KILOGRAM = unit {\
    dim = SPECIFIC_VOLUME,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def CURRENT_DENSITY</span><span class="heading-extra">[\[permalink\]](#CURRENT_DENSITY)</span>

Show undocumented member

\
<span class="keyword">def</span> CURRENT_DENSITY = dimension {\
    current = 1,\
    length = -2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def DECA</span><span class="heading-extra">[\[permalink\]](#DECA)</span>

Show undocumented member

\
<span class="keyword">def</span> DECA: <span class="type">f64</span> = 10.0;

</div>

<div class="section member">

#### <span class="heading-body">def DECI</span><span class="heading-extra">[\[permalink\]](#DECI)</span>

Show undocumented member

\
<span class="keyword">def</span> DECI: <span class="type">f64</span> = 0.1;

</div>

<div class="section member">

#### <span class="heading-body">def DEGREE_CELSIUS</span><span class="heading-extra">[\[permalink\]](#DEGREE_CELSIUS)</span>

Show undocumented member

\
<span class="keyword">def</span> DEGREE_CELSIUS = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def DENSITY</span><span class="heading-extra">[\[permalink\]](#DENSITY)</span>

Show undocumented member

\
<span class="keyword">def</span> DENSITY = dimension {\
    mass = 1,\
    length = -3,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def DIMENSIONLESS_UNIT</span><span class="heading-extra">[\[permalink\]](#DIMENSIONLESS_UNIT)</span>

Show undocumented member

\
<span class="keyword">def</span> DIMENSIONLESS_UNIT = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def ENTROPY</span><span class="heading-extra">[\[permalink\]](#ENTROPY)</span>

Show undocumented member

\
<span class="keyword">def</span> ENTROPY = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    temperature = -1,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def EXA</span><span class="heading-extra">[\[permalink\]](#EXA)</span>

Show undocumented member

\
<span class="keyword">def</span> EXA: <span class="type">f64</span> = 1.0e18;

</div>

<div class="section member">

#### <span class="heading-body">def FARAD</span><span class="heading-extra">[\[permalink\]](#FARAD)</span>

Show undocumented member

\
<span class="keyword">def</span> FARAD = unit {\
    dim = CAPACITANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def FEMTO</span><span class="heading-extra">[\[permalink\]](#FEMTO)</span>

Show undocumented member

\
<span class="keyword">def</span> FEMTO: <span class="type">f64</span> = 1.0e-15;

</div>

<div class="section member">

#### <span class="heading-body">def GIGA</span><span class="heading-extra">[\[permalink\]](#GIGA)</span>

Show undocumented member

\
<span class="keyword">def</span> GIGA: <span class="type">f64</span> = 1.0e9;

</div>

<div class="section member">

#### <span class="heading-body">def GRAY</span><span class="heading-extra">[\[permalink\]](#GRAY)</span>

Show undocumented member

\
<span class="keyword">def</span> GRAY = unit {\
    dim = ABSORBED_DOSE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def HECTO</span><span class="heading-extra">[\[permalink\]](#HECTO)</span>

Show undocumented member

\
<span class="keyword">def</span> HECTO: <span class="type">f64</span> = 100.0;

</div>

<div class="section member">

#### <span class="heading-body">def HENRY</span><span class="heading-extra">[\[permalink\]](#HENRY)</span>

Show undocumented member

\
<span class="keyword">def</span> HENRY = unit {\
    dim = INDUCTANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def HERTZ</span><span class="heading-extra">[\[permalink\]](#HERTZ)</span>

Show undocumented member

\
<span class="keyword">def</span> HERTZ = unit {\
    dim = FREQUENCY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def JOULE</span><span class="heading-extra">[\[permalink\]](#JOULE)</span>

Show undocumented member

\
<span class="keyword">def</span> JOULE = unit {\
    dim = ENERGY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def KATAL</span><span class="heading-extra">[\[permalink\]](#KATAL)</span>

Show undocumented member

\
<span class="keyword">def</span> KATAL = unit {\
    dim = CATALYTIC_ACTIVITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def KELVIN</span><span class="heading-extra">[\[permalink\]](#KELVIN)</span>

Show undocumented member

\
<span class="keyword">def</span> KELVIN = unit {\
    dim = TEMPERATURE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def KILO</span><span class="heading-extra">[\[permalink\]](#KILO)</span>

Show undocumented member

\
<span class="keyword">def</span> KILO: <span class="type">f64</span> = 1.0e3;

</div>

<div class="section member">

#### <span class="heading-body">def KILOGRAM</span><span class="heading-extra">[\[permalink\]](#KILOGRAM)</span>

Show undocumented member

\
<span class="keyword">def</span> KILOGRAM = unit {\
    dim = MASS,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def KILOGRAM_PER_CUBIC_METRE</span><span class="heading-extra">[\[permalink\]](#KILOGRAM_PER_CUBIC_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> KILOGRAM_PER_CUBIC_METRE = unit {\
    dim = DENSITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def KILOGRAM_PER_SQUARE_METRE</span><span class="heading-extra">[\[permalink\]](#KILOGRAM_PER_SQUARE_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> KILOGRAM_PER_SQUARE_METRE = unit {\
    dim = SURFACE_DENSITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def LUMEN</span><span class="heading-extra">[\[permalink\]](#LUMEN)</span>

Show undocumented member

\
<span class="keyword">def</span> LUMEN = unit {\
    dim = LUMINOUS_FLUX,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def LUMEN_PER_WATT</span><span class="heading-extra">[\[permalink\]](#LUMEN_PER_WATT)</span>

Show undocumented member

\
<span class="keyword">def</span> LUMEN_PER_WATT = unit {\
    dim = LUMINOUS_EFFICACY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def LUMINANCE</span><span class="heading-extra">[\[permalink\]](#LUMINANCE)</span>

Show undocumented member

\
<span class="keyword">def</span> LUMINANCE = dimension {\
    luminosity = 1,\
    length = -2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def LUMINOUS_EFFICACY</span><span class="heading-extra">[\[permalink\]](#LUMINOUS_EFFICACY)</span>

Show undocumented member

\
<span class="keyword">def</span> LUMINOUS_EFFICACY = dimension {\
    mass = -1,\
    length = -2,\
    time = 3,\
    luminosity = 1,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def LUX</span><span class="heading-extra">[\[permalink\]](#LUX)</span>

Show undocumented member

\
<span class="keyword">def</span> LUX = unit {\
    dim = ILLUMINANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def MAGNETIC_FIELD_STRENGTH</span><span class="heading-extra">[\[permalink\]](#MAGNETIC_FIELD_STRENGTH)</span>

Show undocumented member

\
<span class="keyword">def</span> MAGNETIC_FIELD_STRENGTH = dimension {\
    current = 1,\
    length = -1,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def MEGA</span><span class="heading-extra">[\[permalink\]](#MEGA)</span>

Show undocumented member

\
<span class="keyword">def</span> MEGA: <span class="type">f64</span> = 1.0e6;

</div>

<div class="section member">

#### <span class="heading-body">def METRE</span><span class="heading-extra">[\[permalink\]](#METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> METRE = unit {\
    dim = LENGTH,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def METRE_PER_SECOND</span><span class="heading-extra">[\[permalink\]](#METRE_PER_SECOND)</span>

Show undocumented member

\
<span class="keyword">def</span> METRE_PER_SECOND = unit {\
    dim = VELOCITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def METRE_PER_SECOND_SQUARED</span><span class="heading-extra">[\[permalink\]](#METRE_PER_SECOND_SQUARED)</span>

Show undocumented member

\
<span class="keyword">def</span> METRE_PER_SECOND_SQUARED = unit {\
    dim = ACCELERATION,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def MICRO</span><span class="heading-extra">[\[permalink\]](#MICRO)</span>

Show undocumented member

\
<span class="keyword">def</span> MICRO: <span class="type">f64</span> = 1.0e-6;

</div>

<div class="section member">

#### <span class="heading-body">def MILLI</span><span class="heading-extra">[\[permalink\]](#MILLI)</span>

Show undocumented member

\
<span class="keyword">def</span> MILLI: <span class="type">f64</span> = 1.0e-3;

</div>

<div class="section member">

#### <span class="heading-body">def MOLE</span><span class="heading-extra">[\[permalink\]](#MOLE)</span>

Show undocumented member

\
<span class="keyword">def</span> MOLE = unit {\
    dim = SUBSTANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def MOLE_PER_CUBIC_METRE</span><span class="heading-extra">[\[permalink\]](#MOLE_PER_CUBIC_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> MOLE_PER_CUBIC_METRE = unit {\
    dim = CONCENTRATION,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def NANO</span><span class="heading-extra">[\[permalink\]](#NANO)</span>

Show undocumented member

\
<span class="keyword">def</span> NANO: <span class="type">f64</span> = 1.0e-9;

</div>

<div class="section member">

#### <span class="heading-body">def NEWTON</span><span class="heading-extra">[\[permalink\]](#NEWTON)</span>

Show undocumented member

\
<span class="keyword">def</span> NEWTON = unit {\
    dim = FORCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def NONE</span><span class="heading-extra">[\[permalink\]](#NONE)</span>

Show undocumented member

\
<span class="keyword">def</span> NONE: <span class="type">f64</span> = 1.0;

</div>

<div class="section member">

#### <span class="heading-body">def OHM</span><span class="heading-extra">[\[permalink\]](#OHM)</span>

Show undocumented member

\
<span class="keyword">def</span> OHM = unit {\
    dim = RESISTANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def PASCAL</span><span class="heading-extra">[\[permalink\]](#PASCAL)</span>

Show undocumented member

\
<span class="keyword">def</span> PASCAL = unit {\
    dim = PRESSURE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def PETA</span><span class="heading-extra">[\[permalink\]](#PETA)</span>

Show undocumented member

\
<span class="keyword">def</span> PETA: <span class="type">f64</span> = 1.0e15;

</div>

<div class="section member">

#### <span class="heading-body">def PICO</span><span class="heading-extra">[\[permalink\]](#PICO)</span>

Show undocumented member

\
<span class="keyword">def</span> PICO: <span class="type">f64</span> = 1.0e-12;

</div>

<div class="section member">

#### <span class="heading-body">def QUECTO</span><span class="heading-extra">[\[permalink\]](#QUECTO)</span>

Show undocumented member

\
<span class="keyword">def</span> QUECTO: <span class="type">f64</span> = 1.0e-30;

</div>

<div class="section member">

#### <span class="heading-body">def QUETTA</span><span class="heading-extra">[\[permalink\]](#QUETTA)</span>

Show undocumented member

\
<span class="keyword">def</span> QUETTA: <span class="type">f64</span> = 1.0e30;

</div>

<div class="section member">

#### <span class="heading-body">def RADIAN</span><span class="heading-extra">[\[permalink\]](#RADIAN)</span>

Show undocumented member

\
<span class="keyword">def</span> RADIAN = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_AMPERE</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_AMPERE)</span>

Show undocumented member

\
<span class="keyword">def</span> RECIPROCAL_AMPERE = unit {\
    dim = RECIPROCAL_CURRENT,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_CANDELA</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_CANDELA)</span>

Show undocumented member

\
<span class="keyword">def</span> RECIPROCAL_CANDELA = unit {\
    dim = RECIPROCAL_LUMINOSITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_KELVIN</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_KELVIN)</span>

Show undocumented member

\
<span class="keyword">def</span> RECIPROCAL_KELVIN = unit {\
    dim = RECIPROCAL_TEMPERATURE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_KILOGRAM</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_KILOGRAM)</span>

Show undocumented member

\
<span class="keyword">def</span> RECIPROCAL_KILOGRAM = unit {\
    dim = RECIPROCAL_MASS,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_METRE</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> RECIPROCAL_METRE = unit {\
    dim = WAVENUMBER,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RECIPROCAL_MOLE</span><span class="heading-extra">[\[permalink\]](#RECIPROCAL_MOLE)</span>

Show undocumented member

\
<span class="keyword">def</span> RECIPROCAL_MOLE = unit {\
    dim = RECIPROCAL_SUBSTANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def RONNA</span><span class="heading-extra">[\[permalink\]](#RONNA)</span>

Show undocumented member

\
<span class="keyword">def</span> RONNA: <span class="type">f64</span> = 1.0e27;

</div>

<div class="section member">

#### <span class="heading-body">def RONTO</span><span class="heading-extra">[\[permalink\]](#RONTO)</span>

Show undocumented member

\
<span class="keyword">def</span> RONTO: <span class="type">f64</span> = 1.0e-27;

</div>

<div class="section member">

#### <span class="heading-body">def SECOND</span><span class="heading-extra">[\[permalink\]](#SECOND)</span>

Show undocumented member

\
<span class="keyword">def</span> SECOND = unit {\
    dim = TIME,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def SIEMENS</span><span class="heading-extra">[\[permalink\]](#SIEMENS)</span>

Show undocumented member

\
<span class="keyword">def</span> SIEMENS = unit {\
    dim = CONDUCTANCE,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def SIEVERT</span><span class="heading-extra">[\[permalink\]](#SIEVERT)</span>

Show undocumented member

\
<span class="keyword">def</span> SIEVERT = unit {\
    dim = DOSE_EQUIVALENT,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def SPECIFIC_VOLUME</span><span class="heading-extra">[\[permalink\]](#SPECIFIC_VOLUME)</span>

Show undocumented member

\
<span class="keyword">def</span> SPECIFIC_VOLUME = dimension {\
    mass = -1,\
    length = 3,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def SQUARE_METRE</span><span class="heading-extra">[\[permalink\]](#SQUARE_METRE)</span>

Show undocumented member

\
<span class="keyword">def</span> SQUARE_METRE = unit {\
    dim = AREA,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def STERADIAN</span><span class="heading-extra">[\[permalink\]](#STERADIAN)</span>

Show undocumented member

\
<span class="keyword">def</span> STERADIAN = unit {\
    dim = DIMENSIONLESS,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def SURFACE_DENSITY</span><span class="heading-extra">[\[permalink\]](#SURFACE_DENSITY)</span>

Show undocumented member

\
<span class="keyword">def</span> SURFACE_DENSITY = dimension {\
    mass = 1,\
    length = -2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def SURFACE_TENSION</span><span class="heading-extra">[\[permalink\]](#SURFACE_TENSION)</span>

Show undocumented member

\
<span class="keyword">def</span> SURFACE_TENSION = dimension {\
    mass = 1,\
    length = 0,\
    time = -2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def TERA</span><span class="heading-extra">[\[permalink\]](#TERA)</span>

Show undocumented member

\
<span class="keyword">def</span> TERA: <span class="type">f64</span> = 1.0e12;

</div>

<div class="section member">

#### <span class="heading-body">def TESLA</span><span class="heading-extra">[\[permalink\]](#TESLA)</span>

Show undocumented member

\
<span class="keyword">def</span> TESLA = unit {\
    dim = MAGNETIC_FLUX_DENSITY,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def TORQUE</span><span class="heading-extra">[\[permalink\]](#TORQUE)</span>

Show undocumented member

\
<span class="keyword">def</span> TORQUE = dimension {\
    mass = 1,\
    length = 2,\
    time = -2,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def VELOCITY</span><span class="heading-extra">[\[permalink\]](#VELOCITY)</span>

Show undocumented member

\
<span class="keyword">def</span> VELOCITY = dimension {\
    length = 1,\
    time = -1,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def VOLT</span><span class="heading-extra">[\[permalink\]](#VOLT)</span>

Show undocumented member

\
<span class="keyword">def</span> VOLT = unit {\
    dim = ELECTRIC_POTENTIAL,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def VOLUME</span><span class="heading-extra">[\[permalink\]](#VOLUME)</span>

Show undocumented member

\
<span class="keyword">def</span> VOLUME = dimension {\
    length = 3,\
    ...\
};

</div>

<div class="section member">

#### <span class="heading-body">def WATT</span><span class="heading-extra">[\[permalink\]](#WATT)</span>

Show undocumented member

\
<span class="keyword">def</span> WATT = unit {\
    dim = POWER,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def WEBER</span><span class="heading-extra">[\[permalink\]](#WEBER)</span>

Show undocumented member

\
<span class="keyword">def</span> WEBER = unit {\
    dim = MAGNETIC_FLUX,\
    scale = 1.0,\
};

</div>

<div class="section member">

#### <span class="heading-body">def YOCTO</span><span class="heading-extra">[\[permalink\]](#YOCTO)</span>

Show undocumented member

\
<span class="keyword">def</span> YOCTO: <span class="type">f64</span> = 1.0e-24;

</div>

<div class="section member">

#### <span class="heading-body">def YOTTA</span><span class="heading-extra">[\[permalink\]](#YOTTA)</span>

Show undocumented member

\
<span class="keyword">def</span> YOTTA: <span class="type">f64</span> = 1.0e24;

</div>

<div class="section member">

#### <span class="heading-body">def ZEPTO</span><span class="heading-extra">[\[permalink\]](#ZEPTO)</span>

Show undocumented member

\
<span class="keyword">def</span> ZEPTO: <span class="type">f64</span> = 1.0e-21;

</div>

<div class="section member">

#### <span class="heading-body">def ZETTA</span><span class="heading-extra">[\[permalink\]](#ZETTA)</span>

Show undocumented member

\
<span class="keyword">def</span> ZETTA: <span class="type">f64</span> = 1.0e21;

</div>

### Globals

<div class="section member">

#### <span class="heading-body">let GIT_VERSION</span><span class="heading-extra">[\[permalink\]](#GIT_VERSION)</span>

\
<span class="keyword">const</span> GIT_VERSION: <span class="type">str</span>;

Git commit identifier of the current build. Appended with "-dirty" when
the working tree contains uncommitted changes.

</div>

<div class="section member">

#### <span class="heading-body">let SEM_VERSION</span><span class="heading-extra">[\[permalink\]](#SEM_VERSION)</span>

\
<span class="keyword">const</span> SEM_VERSION: <span class="type">str</span>;

Semantic version of the current release.

</div>

### Functions

<div class="section member">

#### <span class="heading-body">fn add</span><span class="heading-extra">[\[permalink\]](#add)</span>

\
<span class="keyword">fn</span> add(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span><span class="type">)</span>;

Returns the sum of quantities a and b, converting b to a's unit. If b is
an f64, it is treated as a value in a's unit.

</div>

<div class="section member">

#### <span class="heading-body">fn divd</span><span class="heading-extra">[\[permalink\]](#divd)</span>

\
<span class="keyword">fn</span> divd(a: <span class="type">dimension</span>, b: <span class="type">dimension</span>) <span class="type">dimension</span>;

Returns the quotient of units a and b.

</div>

<div class="section member">

#### <span class="heading-body">fn divq</span><span class="heading-extra">[\[permalink\]](#divq)</span>

\
<span class="keyword">fn</span> divq(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">quantity</span>;

Returns the quotient of quantities a and b, or scales a by 1/b if b is
an f64.

</div>

<div class="section member">

#### <span class="heading-body">fn divu</span><span class="heading-extra">[\[permalink\]](#divu)</span>

\
<span class="keyword">fn</span> divu(a: <span class="type">unit</span>, b: <span class="type">unit</span>) <span class="type">unit</span>;

Returns the quotient of units a and b.

</div>

<div class="section member">

#### <span class="heading-body">fn encodejson</span><span class="heading-extra">[\[permalink\]](#encodejson)</span>

\
<span class="keyword">fn</span> encodejson(h: <span class="type">io</span><span class="type">::</span><span class="type">handle</span>, obj: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Writes JSON encoded representation of a quantity or unit.

</div>

<div class="section member">

#### <span class="heading-body">fn equal</span><span class="heading-extra">[\[permalink\]](#equal)</span>

\
<span class="keyword">fn</span> equal(a: <span class="type">dimension</span>, b: <span class="type">dimension</span>) <span class="type">bool</span>;

Returns true if dimensions a and b are equal.

</div>

<div class="section member">

#### <span class="heading-body">fn fprint</span><span class="heading-extra">[\[permalink\]](#fprint)</span>

\
<span class="keyword">fn</span> fprint(out: <span class="type">io</span><span class="type">::</span><span class="type">handle</span>, x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Formats and prints x to handler h. Returns the number of bytes printed.
See also: <a href="#fprint" class="ref">fprint</a>,
<a href="#println" class="ref">println</a>.

</div>

<div class="section member">

#### <span class="heading-body">fn identify</span><span class="heading-extra">[\[permalink\]](#identify)</span>

\
<span class="keyword">fn</span> identify(in: <span class="type">str</span>) <span class="type">(</span><span class="type">prefix_kind</span><span class="type">,</span> <span class="type">unit_kind</span><span class="type">)</span>;

Returns the decimal prefix and unit symbol componants of the input
string. If the input string does not match any prefix or unit symbol,
the first componant of the tuple will be empty. Output is trimmed and
borrowed from input string.

</div>

<div class="section member">

#### <span class="heading-body">fn isclose</span><span class="heading-extra">[\[permalink\]](#isclose)</span>

\
<span class="keyword">fn</span> isclose(a: <span class="type">quantity</span>, b: <span class="type">quantity</span>, tol: <span class="type">f64</span> = math::STANDARD_TOL) <span class="type">(</span><span class="type">bool</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span><span class="type">)</span>;

Returns whether a and b are within tol of each other.

</div>

<div class="section member">

#### <span class="heading-body">fn isinf</span><span class="heading-extra">[\[permalink\]](#isinf)</span>

\
<span class="keyword">fn</span> isinf(q: <span class="type">quantity</span>) <span class="type">bool</span>;

Returns true if the value of the quantity or scale of its unit is
infinite.

</div>

<div class="section member">

#### <span class="heading-body">fn isnan</span><span class="heading-extra">[\[permalink\]](#isnan)</span>

\
<span class="keyword">fn</span> isnan(q: <span class="type">quantity</span>) <span class="type">bool</span>;

Returns true if the value of the quantity or scale of its unit is NaN.

</div>

<div class="section member">

#### <span class="heading-body">fn muld</span><span class="heading-extra">[\[permalink\]](#muld)</span>

\
<span class="keyword">fn</span> muld(a: <span class="type">dimension</span>, b: <span class="type">dimension</span>) <span class="type">dimension</span>;

Returns the product of units a and b.

</div>

<div class="section member">

#### <span class="heading-body">fn mulq</span><span class="heading-extra">[\[permalink\]](#mulq)</span>

\
<span class="keyword">fn</span> mulq(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">quantity</span>;

Returns the product of quantities a and b, or scales a by b if b is an
f64.

</div>

<div class="section member">

#### <span class="heading-body">fn mulu</span><span class="heading-extra">[\[permalink\]](#mulu)</span>

\
<span class="keyword">fn</span> mulu(a: <span class="type">unit</span>, b: <span class="type">unit</span>) <span class="type">unit</span>;

Returns the product of units a and b.

</div>

<div class="section member">

#### <span class="heading-body">fn powd</span><span class="heading-extra">[\[permalink\]](#powd)</span>

\
<span class="keyword">fn</span> powd(x: <span class="type">dimension</span>, p: <span class="type">int</span>) <span class="type">dimension</span>;

Returns the dimension x raised to the power of p

</div>

<div class="section member">

#### <span class="heading-body">fn powq</span><span class="heading-extra">[\[permalink\]](#powq)</span>

\
<span class="keyword">fn</span> powq(x: <span class="type">quantity</span>, p: <span class="type">int</span>) <span class="type">quantity</span>;

Returns quantity x raised to the integer power p.

</div>

<div class="section member">

#### <span class="heading-body">fn powu</span><span class="heading-extra">[\[permalink\]](#powu)</span>

\
<span class="keyword">fn</span> powu(x: <span class="type">unit</span>, p: <span class="type">int</span>) <span class="type">unit</span>;

Returns the quantity x raised to the integer power p.

</div>

<div class="section member">

#### <span class="heading-body">fn print</span><span class="heading-extra">[\[permalink\]](#print)</span>

\
<span class="keyword">fn</span> print(x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Formats and prints x to
<a href="../os#stdout" class="ref">os::stdout</a>. Returns the number of
bytes printed. See also: <a href="#fprint" class="ref">fprint</a>,
<a href="#println" class="ref">println</a>.

</div>

<div class="section member">

#### <span class="heading-body">fn println</span><span class="heading-extra">[\[permalink\]](#println)</span>

\
<span class="keyword">fn</span> println(x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">size</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Formats and prints x followed by a newline to h. Returns the number of
bytes printed. See also: <a href="#fprint" class="ref">fprint</a>,
<a href="#print" class="ref">print</a>.

</div>

<div class="section member">

#### <span class="heading-body">fn scale</span><span class="heading-extra">[\[permalink\]](#scale)</span>

\
<span class="keyword">fn</span> scale(u: <span class="type">unit</span>, fac: <span class="type">(</span><span class="type">prefix_kind</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">unit</span>;

Scales the unit by a f64 or metric prefix factor.

</div>

<div class="section member">

#### <span class="heading-body">fn strerror</span><span class="heading-extra">[\[permalink\]](#strerror)</span>

\
<span class="keyword">fn</span> strerror(err: <span class="type">error</span>) <span class="type">str</span>;

Returns a human-readable description of an error. Returned value should
NOT be freed by the caller.

</div>

<div class="section member">

#### <span class="heading-body">fn strf</span><span class="heading-extra">[\[permalink\]](#strf)</span>

\
<span class="keyword">fn</span> strf(x: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>, ustr: <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, prec: <span class="type">(</span><span class="type">uint</span> <span class="type">\|</span> <span class="type">void</span><span class="type">)</span> = <span class="keyword">void</span>, repr: <span class="type">notation</span> = notation::GENERAL, enc: <span class="type">encoding</span> = encoding::UTF8) <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Formats a quantity as a string using the specified unit format,
precision, notation, and character encoding. The result must be freed
after use.

</div>

<div class="section member">

#### <span class="heading-body">fn strp</span><span class="heading-extra">[\[permalink\]](#strp)</span>

\
<span class="keyword">fn</span> strp(s: <span class="type">str</span>) <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Parses a numeric quantity and unit expression. Accepts fixed-point and
scientific notation, with permissive unit syntax including alternative
multiplication operators (\*, ×, ·, ⋅), exponent notation (^, \*\*,
superscripts), exponent signs (+, −), grouping (( ), { }), ASCII or
UTF-8 encoded symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols.
Whitespace is permitted.

Valid examples:

strp("67 m");\
strp("1.21 GW");\
strp("9.80665 m/s^2");\
strp("32°C");\
strp("1.5 kΩ");\
strp("1.5 kohm");\
strp("6.022e23 mol\*\*-1");\
strp("20 m²");\

Returns the parsed <a href="#quantity" class="ref">quantity</a> on
success, or an <a href="#error" class="ref">error</a> if the input is
invalid.

- see also: <a href="#strpu" class="ref">strpu</a>

</div>

<div class="section member">

#### <span class="heading-body">fn strpu</span><span class="heading-extra">[\[permalink\]](#strpu)</span>

\
<span class="keyword">fn</span> strpu(s: <span class="type">str</span>) <span class="type">(</span><span class="type">unit</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Parses a unit expression. Accepts fixed-point and scientific notation,
with permissive unit syntax including alternative multiplication
operators (\*, ×, ·, ⋅), exponent notation (^, \*\*, superscripts),
exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded
symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is
permitted.

Valid examples:

strpu("m");\
strpu("m/s^2");\
strpu("°C");\
strpu("kΩ");\
strpu("kohm");\
strpu("mol\*\*-1");\
strpu("m²");\

Returns the parsed <a href="#unit" class="ref">unit</a> on success, or
an <a href="#error" class="ref">error</a> if the input is invalid.

- see also: <a href="#strp" class="ref">strp</a>

</div>

<div class="section member">

#### <span class="heading-body">fn sub</span><span class="heading-extra">[\[permalink\]](#sub)</span>

\
<span class="keyword">fn</span> sub(a: <span class="type">quantity</span>, b: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">f64</span><span class="type">)</span>) <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">dimension_mismatch</span><span class="type">)</span>;

Returns the difference of quantities a and b, converting b to a's unit.
If b is an f64, it is treated as a value in a's unit.

</div>

<div class="section member">

#### <span class="heading-body">fn tojson</span><span class="heading-extra">[\[permalink\]](#tojson)</span>

\
<span class="keyword">fn</span> tojson(obj: <span class="type">(</span><span class="type">quantity</span> <span class="type">\|</span> <span class="type">unit</span><span class="type">)</span>) <span class="type">(</span><span class="type">str</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

Returns JSON encoded string representation of a quantity or unit.

</div>

<div class="section member">

#### <span class="heading-body">fn split</span><span class="heading-extra">[\[permalink\]](#split)</span>

Show undocumented member

\
<span class="keyword">fn</span> split(input: <span class="type">str</span>) <span class="type">(</span><span class="type">(</span><span class="type">str</span><span class="type">,</span> <span class="type">str</span><span class="type">)</span> <span class="type">\|</span> <span class="type">error</span><span class="type">)</span>;

</div>
