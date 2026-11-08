si: A module for parsing, converting, and formatting physical quantities expressed 
with the International System of Units.

- Repository: https://codeberg.org/swonky/hare-si.git

## Examples

- Defining quantities using predefined constants:

```hare
const distance = si::quantity { 
    unit = si::METRE, 
    value = 1500.0,
};
const duration = si::quantity { 
    unit = si::SECOND, 
    value = 120.0 
};
```

- Performing arithmetic with quantities:

```hare
const speed = si::divq(distance, duration);
assert(speed.value == 12.5);
```

- Defining your own derived dimensions, units, and quantities:

```hare
const pressure  = dimension { 
    mass = 1,
    length = -1, 
    time = -2,
    ... 
}; 
const pascal = unit { 
    dim = pressure,
    scale = 1.0,
};
const atmospheric_pressure  = quantity { 
    unit = pascal,
    value = 101325.0,
};
```

- Parsing ([strp](#strp)) and formatting ([strf](#strf)) strings:

```hare
const acceleration = si::strp("20 m/s^2") as si::quantity;

const output = si::strf(acceleration, "km*s^-2") as str;
>> 0.02 km⋅s⁻²

const output = si::strf(
    acceleration,
    "km/s^2",
    prec=3,
    notation=si::E,
    encoding=si::ASCII,
) as str;
>> 2.00e-02 km/s^2
```

## Supported units

All symbols are case sensitive unless otherwise indicated.

Decimal prefix symbols [symbol=exponent]

- [QUETTA](#QUETTA) (Q) = 1e30
- [RONNA](#RONNA) (R) = 1e27
- [YOTTA](#YOTTA) (Y) = 1e24
- [ZETTA](#ZETTA) (Z) = 1e21
- [EXA](#EXA) (E) = 1e18
- [PETA](#PETA) (P) = 1e15
- [TERA](#TERA) (T) = 1e12
- [GIGA](#GIGA) (G) = 1e9
- [MEGA](#MEGA) (M) = 1e6
- [KILO](#KILO) (k) = 1e3
- [HECTO](#HECTO) (h) = 1e2
- [DECA](#DECA) (da) = 1e1
- [DECI](#DECI) (d) = 1e-1
- [CENTI](#CENTI) (c) = 1e-2
- [MILLI](#MILLI) (m) = 1e-3
- [MICRO](#MICRO) (µ) = 1e-6
- [NANO](#NANO) (n) = 1e-9
- [PICO](#PICO) (p) = 1e-12
- [FEMTO](#FEMTO) (f) = 1e-15
- [ATTO](#ATTO) (a) = 1e-18
- [ZEPTO](#ZEPTO) (z) = 1e-21
- [YOCTO](#YOCTO) (y) = 1e-24
- [RONTO](#RONTO) (r) = 1e-27
- [QUECTO](#QUECTO) (q) = 1e-30

Notes:
- Formatted ASCII output for [MICRO](#MICRO) uses LATIN SMALL LETTER U (U+0075)
- Formattted UTF-8 output for [MICRO](#MICRO) uses GREEK SMALL LETTER MU (U+03BC).
- The parser for [MICRO](#MICRO) also accepts MICRO SIGN (U+00B5).

SI unit symbols

- [AMPERE](#AMPERE)     (A)
- [BECQUEREL](#BECQUEREL)  (Bq)
- [CANDELA](#CANDELA)    (cd)
- [COULOMB](#COULOMB)    (C)
- [FARAD](#FARAD)      (F)
- [GRAM](#GRAM)       (g)
- [GRAY](#GRAY)       (Gy)
- [HENRY](#HENRY)      (H)
- [HERTZ](#HERTZ)      (Hz)
- [JOULE](#JOULE)      (J)
- [KATAL](#KATAL)      (kat)
- [KELVIN](#KELVIN)     (K)
- [LUMEN](#LUMEN)      (lm)
- [LUX](#LUX)        (lx)
- [METRE](#METRE)      (m)
- [MOLE](#MOLE)       (mol)
- [NEWTON](#NEWTON)     (N)
- [OHM](#OHM)        (ohm/Ω)
- [PASCAL](#PASCAL)     (Pa)
- [RADIAN](#RADIAN)     (rad)
- [SECOND](#SECOND)     (s)
- [SIEMENS](#SIEMENS)    (S)
- [SIEVERT](#SIEVERT)    (Sv)
- [STERADIAN](#STERADIAN)  (sr)
- [TESLA](#TESLA)      (T)
- [VOLT](#VOLT)       (V)
- [WATT](#WATT)       (W)
- [WEBER](#WEBER)      (Wb)

Notes:
- UTF-8 output for [OHM](#OHM) uses GREEK CAPITAL LETTER OMEGA (U+03A9).
- The parser for [OHM](#OHM) also accepts OHM SIGN (U+2126).

Non-SI unit symbols [name=symbol]

- [ASTRONOMICAL_UNIT](#ASTRONOMICAL_UNIT)  (au)
- [BEL](#BEL)                (B)
- [DALTON](#DALTON)             (Da)
- [DAY](#DAY)                (d)
- [DEGREE](#DEGREE)             (deg/°)
- [DEGREE_CELSIUS](#DEGREE_CELSIUS)     (degC/°C)
- [ELECTRONVOLT](#ELECTRONVOLT)       (eV)
- [HECTARE](#HECTARE)            (ha)
- [HOUR](#HOUR)               (h)
- [LITRE](#LITRE)              (L)
- [MINUTE](#MINUTE)             (min)
- [NEPER](#NEPER)              (Np)
- [TONNE](#TONNE)              (t)

Notes:
- Logarithmic units [BEL](#BEL) and [NEPER](#NEPER) do not currently support conversion.
- Temperature conversions are not currently supported. [DEGREE_CELSIUS](#DEGREE_CELSIUS) is treated as [KELVIN](#KELVIN).
- The formatted UTF-8 outputs for [DEGREE](#DEGREE) use DEGREE SIGN (U+00B0).
- The formatted output for [LITRE](#LITRE) uses LATIN CAPITAL LETTER L (U+004C).
- The parser for [LITRE](#LITRE) also accepts LATIN SMALL LETTER L (U+006C).

Represents the dimensional exponents of the seven SI base dimensions.

### dimension

```hare
type dimension = struct {
	// mass
	mass: int,
	// length
	length: int,
	// time
	time: int,
	// electric current
	current: int,
	// thermodynamic temperature
	temperature: int,
	// amount of substance
	substance: int,
	// luminous intensity
	luminosity: int,
};
```

Specifies the character encoding options.

### encoding

```hare
type encoding = enum u8 {
	ASCII,
	UTF8,
	JSON,
};
```

Specifies the notation used to format floating-point values.

### notation

```hare
type notation = enum u8 {
	GENERAL,
	FIXED,
	SCIENTIFIC,
	E_UPPER,
	E_LOWER,
};
```

Unit prefix decimal exponents

### prefix_kind

```hare
type prefix_kind = enum i8 {
	QUETTA,
	RONNA,
	YOTTA,
	ZETTA,
	EXA,
	PETA,
	TERA,
	GIGA,
	MEGA,
	KILO,
	HECTO,
	DECA,
	NONE,
	DECI,
	CENTI,
	MILLI,
	MICRO,
	NANO,
	PICO,
	FEMTO,
	ATTO,
	ZEPTO,
	YOCTO,
	RONTO,
	QUECTO,
};
```

Represents a physical quantity as a unit and numerical value.

### quantity

```hare
type quantity = struct {
	unit: unit,
	value: f64,
};
```

Union of symbol enum types.

### symbol_kind

```hare
type symbol_kind = (prefix_kind | unit_kind);
```

Represents a unit of measurement by its physical [dimension](#dimension) and scale.

### unit

```hare
type unit = struct {
	dim: dimension,
	scale: f64,
};
```

### token

```hare
type token = struct {
	kind: token_kind,
	text: str,
	pos: size,
};
```

### token_kind

```hare
type token_kind = enum u8 {
	UNSPECIFIED,
	IDENTIFIER,
	INTEGER,
	SUPER_INTEGER,
	MULTIPLY,
	POWER,
	SOLIDUS,
	PLUS,
	SUPER_PLUS,
	MINUS,
	SUPER_MINUS,
	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,
	EXPONENT,
	POINT,
	COMMA,
};
```

### unit_kind

```hare
type unit_kind = enum {
	NONE,
	AMPERE,
	ASTRONOMICAL_UNIT,
	BECQUEREL,
	BEL,
	CANDELA,
	COULOMB,
	DALTON,
	DAY,
	DEGREE,
	DEGREE_CELSIUS,
	ELECTRONVOLT,
	FARAD,
	GAUSS,
	GRAM,
	GRAY,
	HECTARE,
	HENRY,
	HERTZ,
	HOUR,
	JOULE,
	KATAL,
	KELVIN,
	LITRE,
	LUMEN,
	LUX,
	METRE,
	MINUTE,
	MOLE,
	NEPER,
	NEWTON,
	OHM,
	PASCAL,
	RADIAN,
	SECOND,
	SIEMENS,
	SIEVERT,
	STERADIAN,
	TESLA,
	TONNE,
	VOLT,
	WATT,
	WEBER,
};
```

The SI derived dimension of absorbed dose.
Its SI unit is [GRAY](#GRAY).

### ABSORBED_DOSE

```hare
def ABSORBED_DOSE = dimension {
	length = 2,
	time = -2,
	...
};
```

The SI derived dimension of radioactive activity.
Its SI unit is [BECQUEREL](#BECQUEREL).

### ACTIVITY

```hare
def ACTIVITY = dimension {
	time = -1,
	...
};
```

The angstrom is a non-SI unit of length still widely used in the natural
sciences and technology to express atomic-scale lengths. See [METRE](#METRE).

### ANGSTROM

```hare
def ANGSTROM = unit {
	dim = LENGTH,
	scale = 1.0e-10,
};
```

The astronomical unit is a non-SI unit of length that approximately equates
to the average distance between the Sun and the Earth. As of 2012, it is
standardised to a fixed length in metres. See [METRE](#METRE).

### ASTRONOMICAL_UNIT

```hare
def ASTRONOMICAL_UNIT = unit {
	dim = LENGTH,
	scale = 149597870700.0,
};
```

The standard atmosphere is widely used in chemistry, physics, and
engineering as a reference pressure. See [PASCAL](#PASCAL).

### ATMOSPHERE

```hare
def ATMOSPHERE = unit {
	dim = PRESSURE,
	scale = 101325.0,
};
```

The Avogadro constant, an exact defining constant of the SI representing the
number of elementary entities in one mole.
Its SI unit is [RECIPROCAL_MOLE](#RECIPROCAL_MOLE).

### AVOGADRO

```hare
def AVOGADRO = quantity {
	unit = RECIPROCAL_MOLE,
	value = 6.02214076e23,
};
```

The bar is a metric unit of pressure commonly used in meteorology and
acoustics. Not to be confused with the CGS unit 'Barye'.

### BAR

```hare
def BAR = unit {
	dim = PRESSURE,
	scale = 1.0e5,
};
```

The barn is commonly used in nuclear and particle physics to express 
cross-sectional areas of atomic nuclei and subatomic interactions.

### BARN

```hare
def BARN = unit {
	dim = AREA,
	scale = 1.0e-28,
};
```

The bel is a non-SI relative logarithmic unit commonly used in acoustics, 
telecommunications, and signal processing to express ratios of power quantities.
This unit is dimensionless and does not support conversion.
See also: [NEPER](#NEPER).

### BEL

```hare
def BEL = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

The Boltzmann constant, an exact defining constant of the SI relating
thermal energy to thermodynamic temperature.
Its SI unit is [JOULE_PER_KELVIN](#JOULE_PER_KELVIN).

### BOLTZMANN

```hare
def BOLTZMANN = quantity {
	unit = JOULE_PER_KELVIN,
	value = 1.380649e-23,
};
```

The calorie is non-SI unit commonly used in thermodynamics, chemistry, and
nutritional science to express energy. See [JOULE](#JOULE).

### CALORIE

```hare
def CALORIE = unit {
	dim = ENERGY,
	scale = 4.184,
};
```

The SI derived dimension of capacitance.
Its SI unit is [FARAD](#FARAD).

### CAPACITANCE

```hare
def CAPACITANCE = dimension {
	mass = -1,
	length = -2,
	time = 4,
	current = 2,
	...
};
```

The SI derived dimension of catalytic activity.
Its SI unit is [KATAL](#KATAL).

### CATALYTIC_ACTIVITY

```hare
def CATALYTIC_ACTIVITY = dimension {
	time = -1,
	substance = 1,
	...
};
```

The centimetre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### CENTIMETRE

```hare
def CENTIMETRE = unit {
	dim = LENGTH,
	scale = 0.01,
};
```

The SI derived dimension of electrical conductance.
Its SI unit is [SIEMENS](#SIEMENS).

### CONDUCTANCE

```hare
def CONDUCTANCE = dimension {
	mass = -1,
	length = -2,
	time = 3,
	current = 2,
	...
};
```

The cubic centimetre is a scaled SI unit of volume.
The corresponding unscaled SI unit is the [CUBIC_METRE](#CUBIC_METRE).

### CUBIC_CENTIMETRE

```hare
def CUBIC_CENTIMETRE = unit {
	dim = VOLUME,
	scale = 1.0e-6,
};
```

The cubic millimetre is a scaled SI unit of volume.
The corresponding unscaled SI unit is the [CUBIC_METRE](#CUBIC_METRE).

### CUBIC_MILLIMETRE

```hare
def CUBIC_MILLIMETRE = unit {
	dim = VOLUME,
	scale = 1.0e-9,
};
```

The curie is a non-SI unit historically used in nuclear physics to express
radioactivity. See [BECQUEREL](#BECQUEREL).

### CURIE

```hare
def CURIE = unit {
	dim = ACTIVITY,
	scale = 3.7e10,
};
```

The SI base dimension of electric current.

### CURRENT

```hare
def CURRENT = dimension {
	current = 1,
	...
};
```

The dalton

### DALTON

```hare
def DALTON = unit {
	dim = MASS,
	scale = 1.66053906892e-27,
};
```

The day is a non-SI unit of time. See [SECOND](#SECOND).

### DAY

```hare
def DAY = unit {
	dim = TIME,
	scale = 86400.0,
};
```

The decametre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### DECAMETRE

```hare
def DECAMETRE = unit {
	dim = LENGTH,
	scale = 10.0,
};
```

The decimetre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### DECIMETRE

```hare
def DECIMETRE = unit {
	dim = LENGTH,
	scale = 0.1,
};
```

The degree

### DEGREE

```hare
def DEGREE = unit {
	dim = DIMENSIONLESS,
	scale = 0.017453292519943295,
};
```

The dimensionless dimension, with all SI base dimension exponents equal to
zero.

### DIMENSIONLESS

```hare
def DIMENSIONLESS = dimension {
	...
};
```

The SI derived dimension of dose equivalent.
Its SI unit is [SIEVERT](#SIEVERT).

### DOSE_EQUIVALENT

```hare
def DOSE_EQUIVALENT = dimension {
	length = 2,
	time = -2,
	...
};
```

The SI derived dimension of dynamic viscosity. Its SI unit is [PASCAL_SECOND](#PASCAL_SECOND).

### DYNAMIC_VISCOSITY

```hare
def DYNAMIC_VISCOSITY = dimension {
	mass = 1,
	length = -1,
	time = -1,
	...
};
```

The dyne is a CGS unit used in mechanics and fluid dynamics to express force.
See [NEWTON](#NEWTON).

### DYNE

```hare
def DYNE = unit {
	dim = FORCE,
	scale = 1.0e-5,
};
```

The SI derived dimension of electric charge.
Its SI unit is [COULOMB](#COULOMB).

### ELECTRIC_CHARGE

```hare
def ELECTRIC_CHARGE = dimension {
	time = 1,
	current = 1,
	...
};
```

The SI derived dimension of electric potential.
Its SI unit is [VOLT](#VOLT).

### ELECTRIC_POTENTIAL

```hare
def ELECTRIC_POTENTIAL = dimension {
	mass = 1,
	length = 2,
	time = -3,
	current = -1,
	...
};
```

The electronvolt

### ELECTRONVOLT

```hare
def ELECTRONVOLT = unit {
	dim = ENERGY,
	scale = 1.602176634e-19,
};
```

The elementary charge, an exact defining constant of the SI corresponding
to the magnitude of the electric charge of a proton.
Its SI unit is [COULOMB](#COULOMB).

### ELEMENTARY_CHARGE

```hare
def ELEMENTARY_CHARGE = quantity {
	unit = COULOMB,
	value = 1.602176634e-19,
};
```

The SI derived dimension of energy.
Its SI unit is [JOULE](#JOULE).

### ENERGY

```hare
def ENERGY = dimension {
	mass = 1,
	length = 2,
	time = -2,
	...
};
```

The erg is a CGS unit commonly used in classical mechanics, astrophysics, and
other areas of physics to express energy.
The SI counterpart unit is the [JOULE](#JOULE).

### ERG

```hare
def ERG = unit {
	dim = ENERGY,
	scale = 1.0e-7,
};
```

The SI derived dimension of exposure to ionising radiation.
Its SI unit is [COULOMB_PER_KILOGRAM](#COULOMB_PER_KILOGRAM).

### EXPOSURE

```hare
def EXPOSURE = dimension {
	mass = -1,
	time = 1,
	current = 1,
	...
};
```

The SI derived dimension of force. 
Its SI unit is [NEWTON](#NEWTON).

### FORCE

```hare
def FORCE = dimension {
	mass = 1,
	length = 1,
	time = -2,
	...
};
```

The SI derived dimension of frequency.
Its SI unit is [HERTZ](#HERTZ).

### FREQUENCY

```hare
def FREQUENCY = dimension {
	time = -1,
	...
};
```

The gal is a CGS unit commonly used in geophysics and gravimetry to express
acceleration.
The SI counterpart unit is the [METRE_PER_SECOND_SQUARED](#METRE_PER_SECOND_SQUARED)

### GAL

```hare
def GAL = unit {
	dim = ACCELERATION,
	scale = 0.01,
};
```

The gauss is a CGS unit commonly used in physics and engineering to express
magnetic flux density.
The SI counterpart unit is the [TESLA](#TESLA)

### GAUSS

```hare
def GAUSS = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-4,
};
```

The gigahertz is a scaled SI unit of frequency.
The corresponding unscaled SI unit is the [HERTZ](#HERTZ).

### GIGAHERTZ

```hare
def GIGAHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e9,
};
```

The gigajoule is a scaled SI unit of energy.
The corresponding unscaled SI unit is the [JOULE](#JOULE).

### GIGAJOULE

```hare
def GIGAJOULE = unit {
	dim = ENERGY,
	scale = 1.0e9,
};
```

The gigapascal is a scaled SI unit of pressure.
The corresponding unscaled SI unit is the [PASCAL](#PASCAL).

### GIGAPASCAL

```hare
def GIGAPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e9,
};
```

The gigawatt is a scaled SI unit of power.
The corresponding unscaled SI unit is the [WATT](#WATT).

### GIGAWATT

```hare
def GIGAWATT = unit {
	dim = POWER,
	scale = 1.0e9,
};
```

The gram is a scaled SI unit of mass.
The corresponding unscaled SI unit is the [KILOGRAM](#KILOGRAM).

### GRAM

```hare
def GRAM = unit {
	dim = MASS,
	scale = 1.0e-3,
};
```

The hectare is non-SI metric unit commonly used to express areas of land.
The SI counterpart unit is the [SQUARE_METRE](#SQUARE_METRE)

### HECTARE

```hare
def HECTARE = unit {
	dim = AREA,
	scale = 1.0e4,
};
```

The hectometre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### HECTOMETRE

```hare
def HECTOMETRE = unit {
	dim = LENGTH,
	scale = 100.0,
};
```

The hectopascal is a scaled SI unit of pressure.
The corresponding unscaled SI unit is the [PASCAL](#PASCAL).

### HECTOPASCAL

```hare
def HECTOPASCAL = unit {
	dim = PRESSURE,
	scale = 100.0,
};
```

The hour is non-SI unit of time.
The SI counterpart unit is the [SECOND](#SECOND)

### HOUR

```hare
def HOUR = unit {
	dim = TIME,
	scale = 3600.0,
};
```

The caesium-133 hyperfine transition frequency, which defines the SI second.
Its SI unit is [HERTZ](#HERTZ).

### HYPERFINE_TRANSITION_CAESIUM_133

```hare
def HYPERFINE_TRANSITION_CAESIUM_133 = quantity {
	unit = HERTZ,
	value = 9192631770.0,
};
```

The SI derived dimension of illuminance.
Its SI unit is [LUX](#LUX).

### ILLUMINANCE

```hare
def ILLUMINANCE = dimension {
	length = -2,
	luminosity = 1,
	...
};
```

The SI derived dimension of inductance.
Its SI unit is [HENRY](#HENRY).

### INDUCTANCE

```hare
def INDUCTANCE = dimension {
	mass = 1,
	length = 2,
	time = -2,
	current = -2,
	...
};
```

The joule per kelvin is the coherent SI unit of [ENTROPY](#ENTROPY).

### JOULE_PER_KELVIN

```hare
def JOULE_PER_KELVIN = unit {
	dim = ENTROPY,
	scale = 1.0,
};
```

The joule-second is the coherent SI unit of [ACTION](#ACTION).

### JOULE_SECOND

```hare
def JOULE_SECOND = unit {
	dim = ACTION,
	scale = 1.0,
};
```

The kilohertz is a scaled SI unit of frequency.
The corresponding unscaled SI unit is the [HERTZ](#HERTZ).

### KILOHERTZ

```hare
def KILOHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e3,
};
```

The kilojoule is a scaled SI unit of energy.
The corresponding unscaled SI unit is the [JOULE](#JOULE).

### KILOJOULE

```hare
def KILOJOULE = unit {
	dim = ENERGY,
	scale = 1.0e3,
};
```

The kilometre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### KILOMETRE

```hare
def KILOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e3,
};
```

The kilonewton is a scaled SI unit of force.
The corresponding unscaled SI unit is the [NEWTON](#NEWTON).

### KILONEWTON

```hare
def KILONEWTON = unit {
	dim = FORCE,
	scale = 1.0e3,
};
```

The kiloohm is a scaled SI unit of electrical resistance.
The corresponding unscaled SI unit is the [OHM](#OHM).

### KILOOHM

```hare
def KILOOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e3,
};
```

The kilopascal is a scaled SI unit of pressure.
The corresponding unscaled SI unit is the [PASCAL](#PASCAL).

### KILOPASCAL

```hare
def KILOPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e3,
};
```

The kilovolt is a scaled SI unit of electric potential.
The corresponding unscaled SI unit is the [VOLT](#VOLT).

### KILOVOLT

```hare
def KILOVOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0e3,
};
```

The kilowatt is a scaled SI unit of power.
The corresponding unscaled SI unit is the [WATT](#WATT).

### KILOWATT

```hare
def KILOWATT = unit {
	dim = POWER,
	scale = 1.0e3,
};
```

The SI derived dimension of kinematic viscosity. Its SI unit is [SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND).

### KINEMATIC_VISCOSITY

```hare
def KINEMATIC_VISCOSITY = dimension {
	length = 2,
	time = -1,
	...
};
```

The SI base dimension of length.

### LENGTH

```hare
def LENGTH = dimension {
	length = 1,
	...
};
```

The litre is a non-SI metric unit of volume in common general use.
See [CUBIC_METRE](#CUBIC_METRE).

### LITRE

```hare
def LITRE = unit {
	dim = VOLUME,
	scale = 1.0e-3,
};
```

The SI base dimension of luminous intensity.

### LUMINOSITY

```hare
def LUMINOSITY = dimension {
	luminosity = 1,
	...
};
```

The luminous efficacy of monochromatic radiation at 540 THz, an exact
defining constant of the SI for [LUMINOUS_EFFICACY](#LUMINOUS_EFFICACY).
Its SI unit is [LUMEN_PER_WATT](#LUMEN_PER_WATT).

### LUMINOUS_EFFICACY_540_THZ

```hare
def LUMINOUS_EFFICACY_540_THZ = quantity {
	unit = LUMEN_PER_WATT,
	value = 683.0,
};
```

The SI derived dimension of luminous flux.
Its SI unit is [LUMEN](#LUMEN).

### LUMINOUS_FLUX

```hare
def LUMINOUS_FLUX = dimension {
	luminosity = 1,
	...
};
```

The SI derived dimension of magnetic flux.
Its SI unit is [WEBER](#WEBER).

### MAGNETIC_FLUX

```hare
def MAGNETIC_FLUX = dimension {
	mass = 1,
	length = 2,
	time = -2,
	current = -1,
	...
};
```

The SI derived dimension of magnetic flux density.
Its SI unit is [TESLA](#TESLA).

### MAGNETIC_FLUX_DENSITY

```hare
def MAGNETIC_FLUX_DENSITY = dimension {
	mass = 1,
	time = -2,
	current = -1,
	...
};
```

The SI base dimension of mass.

### MASS

```hare
def MASS = dimension {
	mass = 1,
	...
};
```

The maxwell is a CGS electromagnetic unit used to express magnetic flux.
The SI counterpart unit is the [WEBER](#WEBER)

### MAXWELL

```hare
def MAXWELL = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0e-8,
};
```

The megahertz is a scaled SI unit of frequency.
The corresponding unscaled SI unit is the [HERTZ](#HERTZ).

### MEGAHERTZ

```hare
def MEGAHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e6,
};
```

The megajoule is a scaled SI unit of energy.
The corresponding unscaled SI unit is the [JOULE](#JOULE).

### MEGAJOULE

```hare
def MEGAJOULE = unit {
	dim = ENERGY,
	scale = 1.0e6,
};
```

The meganewton is a scaled SI unit of force.
The corresponding unscaled SI unit is the [NEWTON](#NEWTON).

### MEGANEWTON

```hare
def MEGANEWTON = unit {
	dim = FORCE,
	scale = 1.0e6,
};
```

The megaohm is a scaled SI unit of electrical resistance.
The corresponding unscaled SI unit is the [OHM](#OHM).

### MEGAOHM

```hare
def MEGAOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e6,
};
```

The megapascal is a scaled SI unit of pressure.
The corresponding unscaled SI unit is the [PASCAL](#PASCAL).

### MEGAPASCAL

```hare
def MEGAPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e6,
};
```

The megawatt is a scaled SI unit of power.
The corresponding unscaled SI unit is the [WATT](#WATT).

### MEGAWATT

```hare
def MEGAWATT = unit {
	dim = POWER,
	scale = 1.0e6,
};
```

The microampere is a scaled SI unit of electric current.
The corresponding unscaled SI unit is the [AMPERE](#AMPERE).

### MICROAMPERE

```hare
def MICROAMPERE = unit {
	dim = CURRENT,
	scale = 1.0e-6,
};
```

The microcoulomb is a scaled SI unit of electric charge.
The corresponding unscaled SI unit is the [COULOMB](#COULOMB).

### MICROCOULOMB

```hare
def MICROCOULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0e-6,
};
```

The microfarad is a scaled SI unit of capacitance.
The corresponding unscaled SI unit is the [FARAD](#FARAD).

### MICROFARAD

```hare
def MICROFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-6,
};
```

The microgram is a scaled SI unit of mass.
The corresponding unscaled SI unit is the [KILOGRAM](#KILOGRAM).

### MICROGRAM

```hare
def MICROGRAM = unit {
	dim = MASS,
	scale = 1.0e-9,
};
```

The micrometre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### MICROMETRE

```hare
def MICROMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-6,
};
```

The micron is an alternative name for the [MICROMETRE](#MICROMETRE).

### MICRON

```hare
def MICRON = MICROMETRE;
```

The microsecond is a scaled SI unit of time.
The corresponding unscaled SI unit is the [SECOND](#SECOND).

### MICROSECOND

```hare
def MICROSECOND = unit {
	dim = TIME,
	scale = 1.0e-6,
};
```

The microtesla is a scaled SI unit of magnetic flux density.
The corresponding unscaled SI unit is the [TESLA](#TESLA).

### MICROTESLA

```hare
def MICROTESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-6,
};
```

The milliampere is a scaled SI unit of electric current.
The corresponding unscaled SI unit is the [AMPERE](#AMPERE).

### MILLIAMPERE

```hare
def MILLIAMPERE = unit {
	dim = CURRENT,
	scale = 1.0e-3,
};
```

The millicoulomb is a scaled SI unit of electric charge.
The corresponding unscaled SI unit is the [COULOMB](#COULOMB).

### MILLICOULOMB

```hare
def MILLICOULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0e-3,
};
```

The milligram is a scaled SI unit of mass.
The corresponding unscaled SI unit is the [KILOGRAM](#KILOGRAM).

### MILLIGRAM

```hare
def MILLIGRAM = unit {
	dim = MASS,
	scale = 1.0e-6,
};
```

The millijoule is a scaled SI unit of energy.
The corresponding unscaled SI unit is the [JOULE](#JOULE).

### MILLIJOULE

```hare
def MILLIJOULE = unit {
	dim = ENERGY,
	scale = 1.0e-3,
};
```

The millimetre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### MILLIMETRE

```hare
def MILLIMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-3,
};
```

Millimetres of mercury are widely used in medicine and meteorology to express
pressure.
The SI counterpart unit is the [PASCAL](#PASCAL)

### MILLIMETRES_OF_MERCURY

```hare
def MILLIMETRES_OF_MERCURY = unit {
	dim = PRESSURE,
	scale = 133.322,
};
```

The millinewton is a scaled SI unit of force.
The corresponding unscaled SI unit is the [NEWTON](#NEWTON).

### MILLINEWTON

```hare
def MILLINEWTON = unit {
	dim = FORCE,
	scale = 1.0e-3,
};
```

The milliohm is a scaled SI unit of electrical resistance.
The corresponding unscaled SI unit is the [OHM](#OHM).

### MILLIOHM

```hare
def MILLIOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e-3,
};
```

The millipascal is a scaled SI unit of pressure.
The corresponding unscaled SI unit is the [PASCAL](#PASCAL).

### MILLIPASCAL

```hare
def MILLIPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e-3,
};
```

The millipascal-second is a scaled SI unit of dynamic viscosity.
The corresponding unscaled SI unit is the [PASCAL_SECOND](#PASCAL_SECOND).

### MILLIPASCAL_SECOND

```hare
def MILLIPASCAL_SECOND = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 1.0e-3,
};
```

The millisecond is a scaled SI unit of time.
The corresponding unscaled SI unit is the [SECOND](#SECOND).

### MILLISECOND

```hare
def MILLISECOND = unit {
	dim = TIME,
	scale = 1.0e-3,
};
```

The millitesla is a scaled SI unit of magnetic flux density.
The corresponding unscaled SI unit is the [TESLA](#TESLA).

### MILLITESLA

```hare
def MILLITESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-3,
};
```

The millivolt is a scaled SI unit of electric potential.
The corresponding unscaled SI unit is the [VOLT](#VOLT).

### MILLIVOLT

```hare
def MILLIVOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0e-3,
};
```

The milliwatt is a scaled SI unit of power.
The corresponding unscaled SI unit is the [WATT](#WATT).

### MILLIWATT

```hare
def MILLIWATT = unit {
	dim = POWER,
	scale = 1.0e-3,
};
```

The milliweber is a scaled SI unit of magnetic flux.
The corresponding unscaled SI unit is the [WEBER](#WEBER).

### MILLIWEBER

```hare
def MILLIWEBER = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0e-3,
};
```

The minute is non-SI unit of time.
The SI counterpart unit is the [SECOND](#SECOND)

### MINUTE

```hare
def MINUTE = unit {
	dim = TIME,
	scale = 60.0,
};
```

The nanofarad is a scaled SI unit of capacitance.
The corresponding unscaled SI unit is the [FARAD](#FARAD).

### NANOFARAD

```hare
def NANOFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-9,
};
```

The nanometre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### NANOMETRE

```hare
def NANOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-9,
};
```

The nanosecond is a scaled SI unit of time.
The corresponding unscaled SI unit is the [SECOND](#SECOND).

### NANOSECOND

```hare
def NANOSECOND = unit {
	dim = TIME,
	scale = 1.0e-9,
};
```

The neper is a non-SI relative logarithmic unit used in acoustics,
telecommunications, and signal processing to express ratios of field
quantities.
This unit is dimensionless and does not support conversion.
See also: [BEL](#BEL).

### NEPER

```hare
def NEPER = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

The newton-metre is the coherent SI unit of [TORQUE](#TORQUE).

### NEWTON_METRE

```hare
def NEWTON_METRE = unit {
	dim = TORQUE,
	scale = 1.0,
};
```

The newton per metre is the coherent SI unit of [SURFACE_TENSION](#SURFACE_TENSION).

### NEWTON_PER_METRE

```hare
def NEWTON_PER_METRE = unit {
	dim = SURFACE_TENSION,
	scale = 1.0,
};
```

The oersted is a CGS electromagnetic unit used to express magnetic field
strength.
The SI counterpart unit is the [HENRY](#HENRY).

### OERSTED

```hare
def OERSTED = unit {
	dim = MAGNETIC_FIELD_STRENGTH,
	scale = 79.57747155,
};
```

The pascal-second is the coherent SI unit of [DYNAMIC_VISCOSITY](#DYNAMIC_VISCOSITY).

### PASCAL_SECOND

```hare
def PASCAL_SECOND = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 1.0,
};
```

The picofarad is a scaled SI unit of capacitance.
The corresponding unscaled SI unit is the [FARAD](#FARAD).

### PICOFARAD

```hare
def PICOFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-12,
};
```

The picometre is a scaled SI unit of length.
The corresponding unscaled SI unit is the [METRE](#METRE).

### PICOMETRE

```hare
def PICOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-12,
};
```

The Planck constant, an exact defining constant of the SI relating the
energy of a photon to its frequency.
Its SI unit is [JOULE_SECOND](#JOULE_SECOND).

### PLANCK

```hare
def PLANCK = quantity {
	unit = JOULE_SECOND,
	value = 6.62607015e-34,
};
```

The poise is a CGS unit commonly used in rheology and fluid mechanics to
express dynamic viscosity.

### POISE

```hare
def POISE = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 0.1,
};
```

The SI derived dimension of power.
Its SI unit is [WATT](#WATT).

### POWER

```hare
def POWER = dimension {
	mass = 1,
	length = 2,
	time = -3,
	...
};
```

The SI derived dimension of pressure.
Its SI unit is [PASCAL](#PASCAL).

### PRESSURE

```hare
def PRESSURE = dimension {
	mass = 1,
	length = -1,
	time = -2,
	...
};
```

The rad is a non-SI unit historically used in radiobiology and radiation
dosimetry to express absorbed dose.
The SI counterpart unit is the [GRAY](#GRAY).

### RAD

```hare
def RAD = unit {
	dim = ABSORBED_DOSE,
	scale = 0.01,
};
```

The reciprocal of the SI base dimension of electric current.

### RECIPROCAL_CURRENT

```hare
def RECIPROCAL_CURRENT = dimension {
	current = -1,
	...
};
```

The reciprocal of the SI base dimension of luminous intensity.

### RECIPROCAL_LUMINOSITY

```hare
def RECIPROCAL_LUMINOSITY = dimension {
	luminosity = -1,
	...
};
```

The reciprocal of the SI base dimension of mass.

### RECIPROCAL_MASS

```hare
def RECIPROCAL_MASS = dimension {
	mass = -1,
	...
};
```

The reciprocal of the SI base dimension of amount of substance.

### RECIPROCAL_SUBSTANCE

```hare
def RECIPROCAL_SUBSTANCE = dimension {
	substance = -1,
	...
};
```

The reciprocal of the SI base dimension of thermodynamic temperature.

### RECIPROCAL_TEMPERATURE

```hare
def RECIPROCAL_TEMPERATURE = dimension {
	temperature = -1,
	...
};
```

The rem (or Roentgen equivalent man) is a non-SI unit historically used in
radiation protection to express equivalent dose.
The SI counterpart unit is the [SIEVERT](#SIEVERT).

### REM

```hare
def REM = unit {
	dim = DOSE_EQUIVALENT,
	scale = 0.01,
};
```

The SI derived dimension of electrical resistance.
Its SI unit is [OHM](#OHM).

### RESISTANCE

```hare
def RESISTANCE = dimension {
	mass = 1,
	length = 2,
	time = -3,
	current = -2,
	...
};
```

The roentgen is a non-SI unit historically used in radiology and radiation
protection to express [EXPOSURE](#EXPOSURE).
The SI counterpart unit is the [COULOMB_PER_KILOGRAM](#COULOMB_PER_KILOGRAM).

### ROENTGEN

```hare
def ROENTGEN = unit {
	dim = EXPOSURE,
	scale = 2.58e-4,
};
```

The speed of light in vacuum, an exact defining constant of the SI. 
Its SI unit is [METRE_PER_SECOND](#METRE_PER_SECOND).

### SPEED_OF_LIGHT

```hare
def SPEED_OF_LIGHT = quantity {
	unit = METRE_PER_SECOND,
	value = 299792458.0,
};
```

The square centimetre is a scaled SI unit of area.
The corresponding unscaled SI unit is the [SQUARE_METRE](#SQUARE_METRE).

### SQUARE_CENTIMETRE

```hare
def SQUARE_CENTIMETRE = unit {
	dim = AREA,
	scale = 1.0e-4,
};
```

The square kilometre is a scaled SI unit of area.
The corresponding unscaled SI unit is the [SQUARE_METRE](#SQUARE_METRE).

### SQUARE_KILOMETRE

```hare
def SQUARE_KILOMETRE = unit {
	dim = AREA,
	scale = 1.0e6,
};
```

The square metre per second is the coherent SI unit of [KINEMATIC_VISCOSITY](#KINEMATIC_VISCOSITY).

### SQUARE_METRE_PER_SECOND

```hare
def SQUARE_METRE_PER_SECOND = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0,
};
```

The square millimetre is a scaled SI unit of area.
The corresponding unscaled SI unit is the [SQUARE_METRE](#SQUARE_METRE).

### SQUARE_MILLIMETRE

```hare
def SQUARE_MILLIMETRE = unit {
	dim = AREA,
	scale = 1.0e-6,
};
```

The square millimetre per second is a scaled SI unit of kinematic viscosity.
The corresponding unscaled SI unit is the [SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND).

### SQUARE_MILLIMETRE_PER_SECOND

```hare
def SQUARE_MILLIMETRE_PER_SECOND = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0e-6,
};
```

The stokes is a CGS unit commonly used in fluid mechanics to express
viscosity.
The SI counterpart unit is the [SQUARE_METRE_PER_SECOND](#SQUARE_METRE_PER_SECOND).

### STOKES

```hare
def STOKES = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0e-4,
};
```

The SI base dimension of amount of substance.

### SUBSTANCE

```hare
def SUBSTANCE = dimension {
	substance = 1,
	...
};
```

The SI base dimension of thermodynamic temperature.

### TEMPERATURE

```hare
def TEMPERATURE = dimension {
	temperature = 1,
	...
};
```

The SI base dimension of time.

### TIME

```hare
def TIME = dimension {
	time = 1,
	...
};
```

The tonne is a non-SI metric unit of mass still in common general use.
Not to be confused with the ton units used in Imperial or Customary systems. 
See [KILOGRAM](#KILOGRAM).

### TONNE

```hare
def TONNE = unit {
	dim = MASS,
	scale = 1.0e3,
};
```

The torr is non-SI unit historically used in physics.
The SI counterpart unit is the [PASCAL](#PASCAL).

### TORR

```hare
def TORR = unit {
	dim = PRESSURE,
	scale = 133.322368421,
};
```

The SI derived dimension of spatial frequency, expressed as the reciprocal
of length.

### WAVENUMBER

```hare
def WAVENUMBER = dimension {
	length = -1,
	...
};
```

### ACCELERATION

```hare
def ACCELERATION = dimension {
	length = 1,
	time = -2,
	...
};
```

### ACTION

```hare
def ACTION = dimension {
	mass = 1,
	length = 2,
	time = -1,
	...
};
```

### AMPERE

```hare
def AMPERE = unit {
	dim = CURRENT,
	scale = 1.0,
};
```

### AMPERE_PER_METRE

```hare
def AMPERE_PER_METRE = unit {
	dim = MAGNETIC_FIELD_STRENGTH,
	scale = 1.0,
};
```

### AMPERE_PER_SQUARE_METRE

```hare
def AMPERE_PER_SQUARE_METRE = unit {
	dim = CURRENT_DENSITY,
	scale = 1.0,
};
```

### AREA

```hare
def AREA = dimension {
	length = 2,
	...
};
```

### ATTO

```hare
def ATTO: f64 = 1.0e-18;
```

### BECQUEREL

```hare
def BECQUEREL = unit {
	dim = ACTIVITY,
	scale = 1.0,
};
```

### CANDELA

```hare
def CANDELA = unit {
	dim = LUMINOSITY,
	scale = 1.0,
};
```

### CANDELA_PER_SQUARE_METRE

```hare
def CANDELA_PER_SQUARE_METRE = unit {
	dim = LUMINANCE,
	scale = 1.0,
};
```

### CENTI

```hare
def CENTI: f64 = 0.01;
```

### CONCENTRATION

```hare
def CONCENTRATION = dimension {
	substance = 1,
	length = -3,
	...
};
```

### COULOMB

```hare
def COULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0,
};
```

### COULOMB_PER_KILOGRAM

```hare
def COULOMB_PER_KILOGRAM = unit {
	dim = EXPOSURE,
	scale = 1.0,
};
```

### CUBIC_METRE

```hare
def CUBIC_METRE = unit {
	dim = VOLUME,
	scale = 1.0,
};
```

### CUBIC_METRE_PER_KILOGRAM

```hare
def CUBIC_METRE_PER_KILOGRAM = unit {
	dim = SPECIFIC_VOLUME,
	scale = 1.0,
};
```

### CURRENT_DENSITY

```hare
def CURRENT_DENSITY = dimension {
	current = 1,
	length = -2,
	...
};
```

### DECA

```hare
def DECA: f64 = 10.0;
```

### DECI

```hare
def DECI: f64 = 0.1;
```

### DEGREE_CELSIUS

```hare
def DEGREE_CELSIUS = unit {
	dim = TEMPERATURE,
	scale = 1.0,
};
```

### DENSITY

```hare
def DENSITY = dimension {
	mass = 1,
	length = -3,
	...
};
```

### DIMENSIONLESS_UNIT

```hare
def DIMENSIONLESS_UNIT = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

### ENTROPY

```hare
def ENTROPY = dimension {
	mass = 1,
	length = 2,
	time = -2,
	temperature = -1,
	...
};
```

### EXA

```hare
def EXA: f64 = 1.0e18;
```

### FARAD

```hare
def FARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0,
};
```

### FEMTO

```hare
def FEMTO: f64 = 1.0e-15;
```

### GIGA

```hare
def GIGA: f64 = 1.0e9;
```

### GRAY

```hare
def GRAY = unit {
	dim = ABSORBED_DOSE,
	scale = 1.0,
};
```

### HECTO

```hare
def HECTO: f64 = 100.0;
```

### HENRY

```hare
def HENRY = unit {
	dim = INDUCTANCE,
	scale = 1.0,
};
```

### HERTZ

```hare
def HERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0,
};
```

### JOULE

```hare
def JOULE = unit {
	dim = ENERGY,
	scale = 1.0,
};
```

### KATAL

```hare
def KATAL = unit {
	dim = CATALYTIC_ACTIVITY,
	scale = 1.0,
};
```

### KELVIN

```hare
def KELVIN = unit {
	dim = TEMPERATURE,
	scale = 1.0,
};
```

### KILO

```hare
def KILO: f64 = 1.0e3;
```

### KILOGRAM

```hare
def KILOGRAM = unit {
	dim = MASS,
	scale = 1.0,
};
```

### KILOGRAM_PER_CUBIC_METRE

```hare
def KILOGRAM_PER_CUBIC_METRE = unit {
	dim = DENSITY,
	scale = 1.0,
};
```

### KILOGRAM_PER_SQUARE_METRE

```hare
def KILOGRAM_PER_SQUARE_METRE = unit {
	dim = SURFACE_DENSITY,
	scale = 1.0,
};
```

### LUMEN

```hare
def LUMEN = unit {
	dim = LUMINOUS_FLUX,
	scale = 1.0,
};
```

### LUMEN_PER_WATT

```hare
def LUMEN_PER_WATT = unit {
	dim = LUMINOUS_EFFICACY,
	scale = 1.0,
};
```

### LUMINANCE

```hare
def LUMINANCE = dimension {
	luminosity = 1,
	length = -2,
	...
};
```

### LUMINOUS_EFFICACY

```hare
def LUMINOUS_EFFICACY = dimension {
	mass = -1,
	length = -2,
	time = 3,
	luminosity = 1,
	...
};
```

### LUX

```hare
def LUX = unit {
	dim = ILLUMINANCE,
	scale = 1.0,
};
```

### MAGNETIC_FIELD_STRENGTH

```hare
def MAGNETIC_FIELD_STRENGTH = dimension {
	current = 1,
	length = -1,
	...
};
```

### MEGA

```hare
def MEGA: f64 = 1.0e6;
```

### METRE

```hare
def METRE = unit {
	dim = LENGTH,
	scale = 1.0,
};
```

### METRE_PER_SECOND

```hare
def METRE_PER_SECOND = unit {
	dim = VELOCITY,
	scale = 1.0,
};
```

### METRE_PER_SECOND_SQUARED

```hare
def METRE_PER_SECOND_SQUARED = unit {
	dim = ACCELERATION,
	scale = 1.0,
};
```

### MICRO

```hare
def MICRO: f64 = 1.0e-6;
```

### MILLI

```hare
def MILLI: f64 = 1.0e-3;
```

### MOLE

```hare
def MOLE = unit {
	dim = SUBSTANCE,
	scale = 1.0,
};
```

### MOLE_PER_CUBIC_METRE

```hare
def MOLE_PER_CUBIC_METRE = unit {
	dim = CONCENTRATION,
	scale = 1.0,
};
```

### NANO

```hare
def NANO: f64 = 1.0e-9;
```

### NEWTON

```hare
def NEWTON = unit {
	dim = FORCE,
	scale = 1.0,
};
```

### NONE

```hare
def NONE: f64 = 1.0;
```

### OHM

```hare
def OHM = unit {
	dim = RESISTANCE,
	scale = 1.0,
};
```

### PASCAL

```hare
def PASCAL = unit {
	dim = PRESSURE,
	scale = 1.0,
};
```

### PETA

```hare
def PETA: f64 = 1.0e15;
```

### PICO

```hare
def PICO: f64 = 1.0e-12;
```

### QUECTO

```hare
def QUECTO: f64 = 1.0e-30;
```

### QUETTA

```hare
def QUETTA: f64 = 1.0e30;
```

### RADIAN

```hare
def RADIAN = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

### RECIPROCAL_AMPERE

```hare
def RECIPROCAL_AMPERE = unit {
	dim = RECIPROCAL_CURRENT,
	scale = 1.0,
};
```

### RECIPROCAL_CANDELA

```hare
def RECIPROCAL_CANDELA = unit {
	dim = RECIPROCAL_LUMINOSITY,
	scale = 1.0,
};
```

### RECIPROCAL_KELVIN

```hare
def RECIPROCAL_KELVIN = unit {
	dim = RECIPROCAL_TEMPERATURE,
	scale = 1.0,
};
```

### RECIPROCAL_KILOGRAM

```hare
def RECIPROCAL_KILOGRAM = unit {
	dim = RECIPROCAL_MASS,
	scale = 1.0,
};
```

### RECIPROCAL_METRE

```hare
def RECIPROCAL_METRE = unit {
	dim = WAVENUMBER,
	scale = 1.0,
};
```

### RECIPROCAL_MOLE

```hare
def RECIPROCAL_MOLE = unit {
	dim = RECIPROCAL_SUBSTANCE,
	scale = 1.0,
};
```

### RONNA

```hare
def RONNA: f64 = 1.0e27;
```

### RONTO

```hare
def RONTO: f64 = 1.0e-27;
```

### SECOND

```hare
def SECOND = unit {
	dim = TIME,
	scale = 1.0,
};
```

### SIEMENS

```hare
def SIEMENS = unit {
	dim = CONDUCTANCE,
	scale = 1.0,
};
```

### SIEVERT

```hare
def SIEVERT = unit {
	dim = DOSE_EQUIVALENT,
	scale = 1.0,
};
```

### SPECIFIC_VOLUME

```hare
def SPECIFIC_VOLUME = dimension {
	mass = -1,
	length = 3,
	...
};
```

### SQUARE_METRE

```hare
def SQUARE_METRE = unit {
	dim = AREA,
	scale = 1.0,
};
```

### STERADIAN

```hare
def STERADIAN = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

### SURFACE_DENSITY

```hare
def SURFACE_DENSITY = dimension {
	mass = 1,
	length = -2,
	...
};
```

### SURFACE_TENSION

```hare
def SURFACE_TENSION = dimension {
	mass = 1,
	length = 0,
	time = -2,
	...
};
```

### TERA

```hare
def TERA: f64 = 1.0e12;
```

### TESLA

```hare
def TESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0,
};
```

### TORQUE

```hare
def TORQUE = dimension {
	mass = 1,
	length = 2,
	time = -2,
	...
};
```

### VELOCITY

```hare
def VELOCITY = dimension {
	length = 1,
	time = -1,
	...
};
```

### VOLT

```hare
def VOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0,
};
```

### VOLUME

```hare
def VOLUME = dimension {
	length = 3,
	...
};
```

### WATT

```hare
def WATT = unit {
	dim = POWER,
	scale = 1.0,
};
```

### WEBER

```hare
def WEBER = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0,
};
```

### YOCTO

```hare
def YOCTO: f64 = 1.0e-24;
```

### YOTTA

```hare
def YOTTA: f64 = 1.0e24;
```

### ZEPTO

```hare
def ZEPTO: f64 = 1.0e-21;
```

### ZETTA

```hare
def ZETTA: f64 = 1.0e21;
```

The dimensions of two units or quantities do not match.

### dimension_mismatch

```hare
type dimension_mismatch = !void;
```

Represents any error that can occur in the si library

### error

```hare
type error = !(no_match | invalid_exponent | unexpected_token | unclosed_scope |
	invalid_token | dimension_mismatch | not_implemented | invalid | io::error |
	strconv::invalid | strconv::overflow | utf8::invalid | nomem);
```

The input is invalid.

### invalid

```hare
type invalid = !void;
```

An invalid exponent was encountered.

### invalid_exponent

```hare
type invalid_exponent = !void;
```

No matching unit or prefix was found.

### no_match

```hare
type no_match = !str;
```

The requested operation is not implemented.

### not_implemented

```hare
type not_implemented = !void;
```

### invalid_token

```hare
type invalid_token = !token;
```

### unclosed_scope

```hare
type unclosed_scope = !void;
```

### unexpected_token

```hare
type unexpected_token = !token;
```

Git commit identifier of the current build.
Appended with "-dirty" when the working tree contains uncommitted changes.

### GIT_VERSION

```hare
const GIT_VERSION: str;
```

Semantic version of the current release.

### SEM_VERSION

```hare
const SEM_VERSION: str;
```

Returns the sum of quantities a and b, converting b to a's unit.
If b is an f64, it is treated as a value in a's unit.

### add

```hare
fn add(a: quantity, b: (quantity | f64)) (quantity | dimension_mismatch);
```

Returns the quotient of units a and b.

### divd

```hare
fn divd(a: dimension, b: dimension) dimension;
```

Returns the quotient of quantities a and b, or scales a by 1/b if b is an f64.

### divq

```hare
fn divq(a: quantity, b: (quantity | f64)) quantity;
```

Returns the quotient of units a and b.

### divu

```hare
fn divu(a: unit, b: unit) unit;
```

Writes JSON encoded representation of a quantity or unit.

### encodejson

```hare
fn encodejson(h: io::handle, obj: (quantity | unit)) (size | error);
```

Returns true if dimensions a and b are equal.

### equal

```hare
fn equal(a: dimension, b: dimension) bool;
```

Formats and prints x to handler h.
Returns the number of bytes printed.
See also: [fprint](#fprint), [println](#println).

### fprint

```hare
fn fprint(
	out: io::handle,
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error);
```

Returns the decimal prefix and unit symbol componants of the input string.
If the input string does not match any prefix or unit symbol, the first 
componant of the tuple will be empty.
Output is trimmed and borrowed from input string.

### identify

```hare
fn identify(in: str) (prefix_kind, unit_kind);
```

Returns whether a and b are within tol of each other.

### isclose

```hare
fn isclose(
	a: quantity,
	b: quantity,
	tol: f64 = math::STANDARD_TOL,
) (bool | dimension_mismatch);
```

Returns true if the value of the quantity or scale of its unit is infinite.

### isinf

```hare
fn isinf(q: quantity) bool;
```

Returns true if the value of the quantity or scale of its unit is NaN.

### isnan

```hare
fn isnan(q: quantity) bool;
```

Returns the product of units a and b.

### muld

```hare
fn muld(a: dimension, b: dimension) dimension;
```

Returns the product of quantities a and b, or scales a by b if b is an f64.

### mulq

```hare
fn mulq(a: quantity, b: (quantity | f64)) quantity;
```

Returns the product of units a and b.

### mulu

```hare
fn mulu(a: unit, b: unit) unit;
```

Returns the dimension x raised to the power of p

### powd

```hare
fn powd(x: dimension, p: int) dimension;
```

Returns quantity x raised to the integer power p.

### powq

```hare
fn powq(x: quantity, p: int) quantity;
```

Returns the quantity x raised to the integer power p.

### powu

```hare
fn powu(x: unit, p: int) unit;
```

Formats and prints x to [[os::stdout]].
Returns the number of bytes printed.
See also: [fprint](#fprint), [println](#println).

### print

```hare
fn print(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error);
```

Formats and prints x followed by a newline to h.
Returns the number of bytes printed.
See also: [fprint](#fprint), [print](#print).

### println

```hare
fn println(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error);
```

Scales the unit by a f64 or metric prefix factor.

### scale

```hare
fn scale(u: unit, fac: (prefix_kind | f64)) unit;
```

Returns a human-readable description of an error.
Returned value should NOT be freed by the caller.

### strerror

```hare
fn strerror(err: error) str;
```

Formats a quantity as a string using the specified unit format, precision,
notation, and character encoding.
The result must be freed after use.

### strf

```hare
fn strf(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (str | error);
```

Parses a numeric quantity and unit expression. Accepts fixed-point and
scientific notation, with permissive unit syntax including alternative
multiplication operators (*, ×, ·, ⋅), exponent notation (^, **, superscripts),
exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded symbols, 
alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is permitted.

Valid examples:
```hare
strp("67 m");
strp("1.21 GW");
strp("9.80665 m/s^2");
strp("32°C");
strp("1.5 kΩ");
strp("1.5 kohm");
strp("6.022e23 mol**-1");
strp("20 m²");
```

Returns the parsed [quantity](#quantity) on success, or an [error](#error) if the input is invalid.

- see also: [strpu](#strpu)

### strp

```hare
fn strp(s: str) (quantity | error);
```

Parses a unit expression. Accepts fixed-point and scientific notation, with 
permissive unit syntax including alternative multiplication operators 
(*, ×, ·, ⋅), exponent notation (^, **, superscripts), exponent signs (+, −),
grouping (( ), { }), ASCII or UTF-8 encoded symbols, alternative micro (µ, μ) 
and ohm (Ω, Ω) symbols. Whitespace is permitted.

Valid examples:
```hare
strpu("m");
strpu("m/s^2");
strpu("°C");
strpu("kΩ");
strpu("kohm");
strpu("mol**-1");
strpu("m²");
```

Returns the parsed [unit](#unit) on success, or an [error](#error) if the input is invalid.

- see also: [strp](#strp)

### strpu

```hare
fn strpu(s: str) (unit | error);
```

Returns the difference of quantities a and b, converting b to a's unit.
If b is an f64, it is treated as a value in a's unit.

### sub

```hare
fn sub(a: quantity, b: (quantity | f64)) (quantity | dimension_mismatch);
```

Returns JSON encoded string representation of a quantity or unit.

### tojson

```hare
fn tojson(obj: (quantity | unit)) (str | error);
```

### split

```hare
fn split(input: str) ((str, str) | error);
```
