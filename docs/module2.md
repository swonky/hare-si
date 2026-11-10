# haredoc

si: A module for parsing, converting, and formatting physical quantities expressed with the International System of Units.

- [Repository](https://codeberg.org/swonky/hare-si.git)

**Examples**

- Defining and performing arithmetic using [`quantity`](#quantity):

```hare
const distance = si::quantity {
	unit = si::METRE,
	value = 1500.0,
};
const duration = si::quantity {
	unit = si::SECOND,
	value = 120.0
};

const speed = si::divq(distance, duration);
assert(speed.value == 12.5);

```

- Defining custom [`dimension`](#dimension) and [`unit`](#unit) values:

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

- Parsing ([`strp`](#strp)) and formatting ([`strf`](#strf)) strings:

```hare
const a: si::quantity = si::strp("20 m/s^2")?;
const b: str = si::strf(qty, "km*s^-2")?;

assert(out == "0.02 km⋅s⁻²");

const c: str = si::strf(
	acceleration,
	"km/s^2",
	prec=3,
	notation=si::E,
	encoding=si::ASCII,
)?;

assert(c == "2.00e-02 km/s^2");
```

## Index

### Types

- [`dimension`](#dimension)
- [`encoding`](#encoding)
- [`notation`](#notation)
- [`prefix_kind`](#prefix_kind)
- [`quantity`](#quantity)
- [`symbol_kind`](#symbol_kind)
- [`unit`](#unit)

*Undocumented types*
- [`token`](#token)
- [`token_kind`](#token_kind)
- [`unit_kind`](#unit_kind)

### Errors

- [`dimension_mismatch`](#dimension_mismatch)
- [`error`](#error)
- [`invalid`](#invalid)
- [`invalid_exponent`](#invalid_exponent)
- [`invalid_numeric`](#invalid_numeric)
- [`invalid_symbol`](#invalid_symbol)
- [`not_implemented`](#not_implemented)

*Undocumented errors*
- [`unclosed_scope`](#unclosed_scope)
- [`unexpected_token`](#unexpected_token)

### Constants

- [`ABSORBED_DOSE`](#absorbed_dose)
- [`ACTIVITY`](#activity)
- [`ANGSTROM`](#angstrom)
- [`ASTRONOMICAL_UNIT`](#astronomical_unit)
- [`ATMOSPHERE`](#atmosphere)
- [`AVOGADRO`](#avogadro)
- [`BAR`](#bar)
- [`BARN`](#barn)
- [`BEL`](#bel)
- [`BOLTZMANN`](#boltzmann)
- [`CALORIE`](#calorie)
- [`CAPACITANCE`](#capacitance)
- [`CATALYTIC_ACTIVITY`](#catalytic_activity)
- [`CENTIMETRE`](#centimetre)
- [`CONDUCTANCE`](#conductance)
- [`CUBIC_CENTIMETRE`](#cubic_centimetre)
- [`CUBIC_MILLIMETRE`](#cubic_millimetre)
- [`CURIE`](#curie)
- [`CURRENT`](#current)
- [`DALTON`](#dalton)
- [`DAY`](#day)
- [`DECAMETRE`](#decametre)
- [`DECIMETRE`](#decimetre)
- [`DEGREE`](#degree)
- [`DIMENSIONLESS`](#dimensionless)
- [`DOSE_EQUIVALENT`](#dose_equivalent)
- [`DYNAMIC_VISCOSITY`](#dynamic_viscosity)
- [`DYNE`](#dyne)
- [`ELECTRIC_CHARGE`](#electric_charge)
- [`ELECTRIC_POTENTIAL`](#electric_potential)
- [`ELECTRONVOLT`](#electronvolt)
- [`ELEMENTARY_CHARGE`](#elementary_charge)
- [`ENERGY`](#energy)
- [`ERG`](#erg)
- [`EXPOSURE`](#exposure)
- [`FORCE`](#force)
- [`FREQUENCY`](#frequency)
- [`GAL`](#gal)
- [`GAUSS`](#gauss)
- [`GIGAHERTZ`](#gigahertz)
- [`GIGAJOULE`](#gigajoule)
- [`GIGAPASCAL`](#gigapascal)
- [`GIGAWATT`](#gigawatt)
- [`GRAM`](#gram)
- [`HECTARE`](#hectare)
- [`HECTOMETRE`](#hectometre)
- [`HECTOPASCAL`](#hectopascal)
- [`HOUR`](#hour)
- [`HYPERFINE_TRANSITION_CAESIUM_133`](#hyperfine_transition_caesium_133)
- [`ILLUMINANCE`](#illuminance)
- [`INDUCTANCE`](#inductance)
- [`JOULE_PER_KELVIN`](#joule_per_kelvin)
- [`JOULE_SECOND`](#joule_second)
- [`KILOGRAM_PER_CUBIC_METRE`](#kilogram_per_cubic_metre)
- [`KILOHERTZ`](#kilohertz)
- [`KILOJOULE`](#kilojoule)
- [`KILOMETRE`](#kilometre)
- [`KILONEWTON`](#kilonewton)
- [`KILOOHM`](#kiloohm)
- [`KILOPASCAL`](#kilopascal)
- [`KILOVOLT`](#kilovolt)
- [`KILOWATT`](#kilowatt)
- [`KINEMATIC_VISCOSITY`](#kinematic_viscosity)
- [`LENGTH`](#length)
- [`LITRE`](#litre)
- [`LUMINOSITY`](#luminosity)
- [`LUMINOUS_EFFICACY_540_THZ`](#luminous_efficacy_540_thz)
- [`LUMINOUS_FLUX`](#luminous_flux)
- [`MAGNETIC_FLUX`](#magnetic_flux)
- [`MAGNETIC_FLUX_DENSITY`](#magnetic_flux_density)
- [`MASS`](#mass)
- [`MAXWELL`](#maxwell)
- [`MEGAHERTZ`](#megahertz)
- [`MEGAJOULE`](#megajoule)
- [`MEGANEWTON`](#meganewton)
- [`MEGAOHM`](#megaohm)
- [`MEGAPASCAL`](#megapascal)
- [`MEGAWATT`](#megawatt)
- [`MICROAMPERE`](#microampere)
- [`MICROCOULOMB`](#microcoulomb)
- [`MICROFARAD`](#microfarad)
- [`MICROGRAM`](#microgram)
- [`MICROMETRE`](#micrometre)
- [`MICRON`](#micron)
- [`MICROSECOND`](#microsecond)
- [`MICROTESLA`](#microtesla)
- [`MILLIAMPERE`](#milliampere)
- [`MILLICOULOMB`](#millicoulomb)
- [`MILLIGRAM`](#milligram)
- [`MILLIJOULE`](#millijoule)
- [`MILLIMETRE`](#millimetre)
- [`MILLIMETRES_OF_MERCURY`](#millimetres_of_mercury)
- [`MILLINEWTON`](#millinewton)
- [`MILLIOHM`](#milliohm)
- [`MILLIPASCAL`](#millipascal)
- [`MILLIPASCAL_SECOND`](#millipascal_second)
- [`MILLISECOND`](#millisecond)
- [`MILLITESLA`](#millitesla)
- [`MILLIVOLT`](#millivolt)
- [`MILLIWATT`](#milliwatt)
- [`MILLIWEBER`](#milliweber)
- [`MINUTE`](#minute)
- [`NANOFARAD`](#nanofarad)
- [`NANOMETRE`](#nanometre)
- [`NANOSECOND`](#nanosecond)
- [`NEPER`](#neper)
- [`NEWTON_METRE`](#newton_metre)
- [`NEWTON_PER_METRE`](#newton_per_metre)
- [`OERSTED`](#oersted)
- [`PASCAL_SECOND`](#pascal_second)
- [`PICOFARAD`](#picofarad)
- [`PICOMETRE`](#picometre)
- [`PLANCK`](#planck)
- [`POISE`](#poise)
- [`POWER`](#power)
- [`PRESSURE`](#pressure)
- [`RAD`](#rad)
- [`RECIPROCAL_CUBIC_METRE`](#reciprocal_cubic_metre)
- [`RECIPROCAL_CURRENT`](#reciprocal_current)
- [`RECIPROCAL_LENGTH`](#reciprocal_length)
- [`RECIPROCAL_LUMINOSITY`](#reciprocal_luminosity)
- [`RECIPROCAL_MASS`](#reciprocal_mass)
- [`RECIPROCAL_SQUARE_METRE`](#reciprocal_square_metre)
- [`RECIPROCAL_SUBSTANCE`](#reciprocal_substance)
- [`RECIPROCAL_TEMPERATURE`](#reciprocal_temperature)
- [`REM`](#rem)
- [`RESISTANCE`](#resistance)
- [`ROENTGEN`](#roentgen)
- [`SPATIAL_FREQUENCY_1D`](#spatial_frequency_1d)
- [`SPATIAL_FREQUENCY_2D`](#spatial_frequency_2d)
- [`SPATIAL_FREQUENCY_3D`](#spatial_frequency_3d)
- [`SPEED_OF_LIGHT`](#speed_of_light)
- [`SQUARE_CENTIMETRE`](#square_centimetre)
- [`SQUARE_KILOMETRE`](#square_kilometre)
- [`SQUARE_METRE`](#square_metre)
- [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second)
- [`SQUARE_MILLIMETRE`](#square_millimetre)
- [`SQUARE_MILLIMETRE_PER_SECOND`](#square_millimetre_per_second)
- [`STOKES`](#stokes)
- [`SUBSTANCE`](#substance)
- [`TEMPERATURE`](#temperature)
- [`TIME`](#time)
- [`TONNE`](#tonne)
- [`TORR`](#torr)
- [`WAVENUMBER`](#wavenumber)

*Undocumented constants*
- [`ACCELERATION`](#acceleration)
- [`ACTION`](#action)
- [`AMPERE`](#ampere)
- [`AMPERE_PER_METRE`](#ampere_per_metre)
- [`AMPERE_PER_SQUARE_METRE`](#ampere_per_square_metre)
- [`AREA`](#area)
- [`ATTO`](#atto)
- [`BECQUEREL`](#becquerel)
- [`CANDELA`](#candela)
- [`CANDELA_PER_SQUARE_METRE`](#candela_per_square_metre)
- [`CENTI`](#centi)
- [`CONCENTRATION`](#concentration)
- [`COULOMB`](#coulomb)
- [`COULOMB_PER_CUBIC_METRE`](#coulomb_per_cubic_metre)
- [`COULOMB_PER_KILOGRAM`](#coulomb_per_kilogram)
- [`COULOMB_PER_METRE`](#coulomb_per_metre)
- [`COULOMB_PER_SQUARE_METRE`](#coulomb_per_square_metre)
- [`CUBIC_METRE`](#cubic_metre)
- [`CUBIC_METRE_PER_KILOGRAM`](#cubic_metre_per_kilogram)
- [`CURRENT_DENSITY`](#current_density)
- [`DECA`](#deca)
- [`DECI`](#deci)
- [`DEGREE_CELSIUS`](#degree_celsius)
- [`DENSITY`](#density)
- [`DIMENSIONLESS_UNIT`](#dimensionless_unit)
- [`ENTROPY`](#entropy)
- [`EXA`](#exa)
- [`FARAD`](#farad)
- [`FEMTO`](#femto)
- [`GIGA`](#giga)
- [`GRAY`](#gray)
- [`HECTO`](#hecto)
- [`HENRY`](#henry)
- [`HERTZ`](#hertz)
- [`JOULE`](#joule)
- [`KATAL`](#katal)
- [`KELVIN`](#kelvin)
- [`KILO`](#kilo)
- [`KILOGRAM`](#kilogram)
- [`KILOGRAM_PER_SQUARE_METRE`](#kilogram_per_square_metre)
- [`LINEAR_CHARGE_DENSITY`](#linear_charge_density)
- [`LUMEN`](#lumen)
- [`LUMEN_PER_WATT`](#lumen_per_watt)
- [`LUMINANCE`](#luminance)
- [`LUMINOUS_EFFICACY`](#luminous_efficacy)
- [`LUX`](#lux)
- [`MAGNETIC_FIELD_STRENGTH`](#magnetic_field_strength)
- [`MEGA`](#mega)
- [`METRE`](#metre)
- [`METRE_PER_SECOND`](#metre_per_second)
- [`METRE_PER_SECOND_SQUARED`](#metre_per_second_squared)
- [`MICRO`](#micro)
- [`MILLI`](#milli)
- [`MOLE`](#mole)
- [`MOLE_PER_CUBIC_METRE`](#mole_per_cubic_metre)
- [`NANO`](#nano)
- [`NEWTON`](#newton)
- [`NONE`](#none)
- [`OHM`](#ohm)
- [`PASCAL`](#pascal)
- [`PETA`](#peta)
- [`PICO`](#pico)
- [`QUECTO`](#quecto)
- [`QUETTA`](#quetta)
- [`RADIAN`](#radian)
- [`RECIPROCAL_AMPERE`](#reciprocal_ampere)
- [`RECIPROCAL_AREA`](#reciprocal_area)
- [`RECIPROCAL_CANDELA`](#reciprocal_candela)
- [`RECIPROCAL_KELVIN`](#reciprocal_kelvin)
- [`RECIPROCAL_KILOGRAM`](#reciprocal_kilogram)
- [`RECIPROCAL_METRE`](#reciprocal_metre)
- [`RECIPROCAL_MOLE`](#reciprocal_mole)
- [`RECIPROCAL_VOLUME`](#reciprocal_volume)
- [`RONNA`](#ronna)
- [`RONTO`](#ronto)
- [`SECOND`](#second)
- [`SIEMENS`](#siemens)
- [`SIEVERT`](#sievert)
- [`SPECIFIC_VOLUME`](#specific_volume)
- [`STERADIAN`](#steradian)
- [`SURFACE_CHARGE_DENSITY`](#surface_charge_density)
- [`SURFACE_DENSITY`](#surface_density)
- [`SURFACE_TENSION`](#surface_tension)
- [`TERA`](#tera)
- [`TESLA`](#tesla)
- [`TORQUE`](#torque)
- [`VELOCITY`](#velocity)
- [`VOLT`](#volt)
- [`VOLUME`](#volume)
- [`VOLUME_CHARGE_DENSITY`](#volume_charge_density)
- [`WATT`](#watt)
- [`WEBER`](#weber)
- [`YOCTO`](#yocto)
- [`YOTTA`](#yotta)
- [`ZEPTO`](#zepto)
- [`ZETTA`](#zetta)

### Functions

- [`add`](#add)
- [`divd`](#divd)
- [`divq`](#divq)
- [`divu`](#divu)
- [`encodejson`](#encodejson)
- [`equal`](#equal)
- [`fprint`](#fprint)
- [`identify`](#identify)
- [`isclose`](#isclose)
- [`isinf`](#isinf)
- [`isnan`](#isnan)
- [`muld`](#muld)
- [`mulq`](#mulq)
- [`mulu`](#mulu)
- [`powd`](#powd)
- [`powq`](#powq)
- [`powu`](#powu)
- [`print`](#print)
- [`println`](#println)
- [`scale`](#scale)
- [`strerror`](#strerror)
- [`strf`](#strf)
- [`strp`](#strp)
- [`strpu`](#strpu)
- [`sub`](#sub)
- [`tojson`](#tojson)

*Undocumented functions*
- [`split`](#split)
## Types

### `dimension`

Represents the dimensional exponents of the seven SI base dimensions.

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

### `encoding`

Specifies the character encoding options.

```hare
type encoding = enum u8 {
	ASCII,
	UTF8,
	JSON,
};
```

### `notation`

Specifies the notation used to format floating-point values.

```hare
type notation = enum u8 {
	GENERAL,
	FIXED,
	SCIENTIFIC,
	E_UPPER,
	E_LOWER,
};
```

### `prefix_kind`

Unit prefix decimal exponents

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

### `quantity`

Represents a physical quantity as a unit and numerical value.

```hare
type quantity = struct {
	unit: unit,
	value: f64,
};
```

### `symbol_kind`

Union of symbol enum types.

```hare
type symbol_kind = (prefix_kind | unit_kind);
```

### `unit`

Represents a unit of measurement by its physical [`dimension`](#dimension) and scale.

```hare
type unit = struct {
	dim: dimension,
	scale: f64,
};
```

## Errors

### `dimension_mismatch`

The dimensions of two units or quantities do not match.

```hare
type dimension_mismatch = !void;
```

### `error`

Represents any error that can occur in the si library

```hare
type error = !(invalid_symbol | invalid_exponent | invalid_numeric | unexpected_token |
	unclosed_scope | dimension_mismatch | not_implemented | invalid |
	io::error | strconv::invalid | strconv::overflow | utf8::invalid |
	nomem);
```

### `invalid`

The input is invalid.

```hare
type invalid = !void;
```

### `invalid_exponent`

An invalid exponent was encountered.

```hare
type invalid_exponent = !void;
```

### `invalid_numeric`

No matching unit or prefix was found.

```hare
type invalid_numeric = !str;
```

### `invalid_symbol`

No matching unit or prefix was found.

```hare
type invalid_symbol = !token;
```

### `not_implemented`

The requested operation is not implemented.

```hare
type not_implemented = !void;
```

## Constants

### `ABSORBED_DOSE`

The SI derived dimension of absorbed dose. Its SI unit is [`GRAY`](#gray).

```hare
def ABSORBED_DOSE = dimension {
	length = 2,
	time = -2,
	...
};
```

### `ACTIVITY`

The SI derived dimension of radioactive activity. Its SI unit is [`BECQUEREL`](#becquerel).

```hare
def ACTIVITY = dimension {
	time = -1,
	...
};
```

### `ANGSTROM`

The angstrom is a non-SI unit of length still widely used in the natural sciences and technology to express atomic-scale lengths. See [`METRE`](#metre).

```hare
def ANGSTROM = unit {
	dim = LENGTH,
	scale = 1.0e-10,
};
```

### `ASTRONOMICAL_UNIT`

The astronomical unit is a non-SI unit of length that approximately equates to the average distance between the Sun and the Earth. As of 2012, it is standardised to a fixed length in metres. See [`METRE`](#metre).

```hare
def ASTRONOMICAL_UNIT = unit {
	dim = LENGTH,
	scale = 149597870700.0,
};
```

### `ATMOSPHERE`

The standard atmosphere is widely used in chemistry, physics, and engineering as a reference pressure. See [`PASCAL`](#pascal).

```hare
def ATMOSPHERE = unit {
	dim = PRESSURE,
	scale = 101325.0,
};
```

### `AVOGADRO`

The Avogadro constant, an exact defining constant of the SI representing the number of elementary entities in one mole. Its SI unit is [`RECIPROCAL_MOLE`](#reciprocal_mole).

```hare
def AVOGADRO = quantity {
	unit = RECIPROCAL_MOLE,
	value = 6.02214076e23,
};
```

### `BAR`

The bar is a metric unit of pressure commonly used in meteorology and acoustics. Not to be confused with the CGS unit 'Barye'.

```hare
def BAR = unit {
	dim = PRESSURE,
	scale = 1.0e5,
};
```

### `BARN`

The barn is commonly used in nuclear and particle physics to express cross-sectional areas of atomic nuclei and subatomic interactions.

```hare
def BARN = unit {
	dim = AREA,
	scale = 1.0e-28,
};
```

### `BEL`

The bel is a non-SI relative logarithmic unit commonly used in acoustics, telecommunications, and signal processing to express ratios of power quantities. This unit is dimensionless and does not support conversion. See also: [`NEPER`](#neper).

```hare
def BEL = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

### `BOLTZMANN`

The Boltzmann constant, an exact defining constant of the SI relating thermal energy to thermodynamic temperature. Its SI unit is [`JOULE_PER_KELVIN`](#joule_per_kelvin).

```hare
def BOLTZMANN = quantity {
	unit = JOULE_PER_KELVIN,
	value = 1.380649e-23,
};
```

### `CALORIE`

The calorie is non-SI unit commonly used in thermodynamics, chemistry, and nutritional science to express energy. See [`JOULE`](#joule).

```hare
def CALORIE = unit {
	dim = ENERGY,
	scale = 4.184,
};
```

### `CAPACITANCE`

The SI derived dimension of capacitance. Its SI unit is [`FARAD`](#farad).

```hare
def CAPACITANCE = dimension {
	mass = -1,
	length = -2,
	time = 4,
	current = 2,
	...
};
```

### `CATALYTIC_ACTIVITY`

The SI derived dimension of catalytic activity. Its SI unit is [`KATAL`](#katal).

```hare
def CATALYTIC_ACTIVITY = dimension {
	time = -1,
	substance = 1,
	...
};
```

### `CENTIMETRE`

The centimetre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def CENTIMETRE = unit {
	dim = LENGTH,
	scale = 0.01,
};
```

### `CONDUCTANCE`

The SI derived dimension of electrical conductance. Its SI unit is [`SIEMENS`](#siemens).

```hare
def CONDUCTANCE = dimension {
	mass = -1,
	length = -2,
	time = 3,
	current = 2,
	...
};
```

### `CUBIC_CENTIMETRE`

The cubic centimetre is a scaled SI unit of volume. The corresponding unscaled SI unit is the [`CUBIC_METRE`](#cubic_metre).

```hare
def CUBIC_CENTIMETRE = unit {
	dim = VOLUME,
	scale = 1.0e-6,
};
```

### `CUBIC_MILLIMETRE`

The cubic millimetre is a scaled SI unit of volume. The corresponding unscaled SI unit is the [`CUBIC_METRE`](#cubic_metre).

```hare
def CUBIC_MILLIMETRE = unit {
	dim = VOLUME,
	scale = 1.0e-9,
};
```

### `CURIE`

The curie is a non-SI unit historically used in nuclear physics to express radioactivity. See [`BECQUEREL`](#becquerel).

```hare
def CURIE = unit {
	dim = ACTIVITY,
	scale = 3.7e10,
};
```

### `CURRENT`

The SI base dimension of electric current.

```hare
def CURRENT = dimension {
	current = 1,
	...
};
```

### `DALTON`

The dalton

```hare
def DALTON = unit {
	dim = MASS,
	scale = 1.66053906892e-27,
};
```

### `DAY`

The day is a non-SI unit of time. See [`SECOND`](#second).

```hare
def DAY = unit {
	dim = TIME,
	scale = 86400.0,
};
```

### `DECAMETRE`

The decametre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def DECAMETRE = unit {
	dim = LENGTH,
	scale = 10.0,
};
```

### `DECIMETRE`

The decimetre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def DECIMETRE = unit {
	dim = LENGTH,
	scale = 0.1,
};
```

### `DEGREE`

The degree

```hare
def DEGREE = unit {
	dim = DIMENSIONLESS,
	scale = 0.017453292519943295,
};
```

### `DIMENSIONLESS`

The dimensionless dimension, with all SI base dimension exponents equal to zero.

```hare
def DIMENSIONLESS = dimension {
	...
};
```

### `DOSE_EQUIVALENT`

The SI derived dimension of dose equivalent. Its SI unit is [`SIEVERT`](#sievert).

```hare
def DOSE_EQUIVALENT = dimension {
	length = 2,
	time = -2,
	...
};
```

### `DYNAMIC_VISCOSITY`

The SI derived dimension of dynamic viscosity. Its SI unit is [`PASCAL_SECOND`](#pascal_second).

```hare
def DYNAMIC_VISCOSITY = dimension {
	mass = 1,
	length = -1,
	time = -1,
	...
};
```

### `DYNE`

The dyne is a CGS unit used in mechanics and fluid dynamics to express force. See [`NEWTON`](#newton).

```hare
def DYNE = unit {
	dim = FORCE,
	scale = 1.0e-5,
};
```

### `ELECTRIC_CHARGE`

The SI derived dimension of electric charge. Its SI unit is [`COULOMB`](#coulomb).

```hare
def ELECTRIC_CHARGE = dimension {
	time = 1,
	current = 1,
	...
};
```

### `ELECTRIC_POTENTIAL`

The SI derived dimension of electric potential. Its SI unit is [`VOLT`](#volt).

```hare
def ELECTRIC_POTENTIAL = dimension {
	mass = 1,
	length = 2,
	time = -3,
	current = -1,
	...
};
```

### `ELECTRONVOLT`

The electronvolt

```hare
def ELECTRONVOLT = unit {
	dim = ENERGY,
	scale = 1.602176634e-19,
};
```

### `ELEMENTARY_CHARGE`

The elementary charge, an exact defining constant of the SI corresponding to the magnitude of the electric charge of a proton. Its SI unit is [`COULOMB`](#coulomb).

```hare
def ELEMENTARY_CHARGE = quantity {
	unit = COULOMB,
	value = 1.602176634e-19,
};
```

### `ENERGY`

The SI derived dimension of energy. Its SI unit is [`JOULE`](#joule).

```hare
def ENERGY = dimension {
	mass = 1,
	length = 2,
	time = -2,
	...
};
```

### `ERG`

The erg is a CGS unit commonly used in classical mechanics, astrophysics, and other areas of physics to express energy. The SI counterpart unit is the [`JOULE`](#joule).

```hare
def ERG = unit {
	dim = ENERGY,
	scale = 1.0e-7,
};
```

### `EXPOSURE`

The SI derived dimension of exposure to ionising radiation. Its SI unit is [`COULOMB_PER_KILOGRAM`](#coulomb_per_kilogram).

```hare
def EXPOSURE = dimension {
	mass = -1,
	time = 1,
	current = 1,
	...
};
```

### `FORCE`

The SI derived dimension of force. Its SI unit is [`NEWTON`](#newton).

```hare
def FORCE = dimension {
	mass = 1,
	length = 1,
	time = -2,
	...
};
```

### `FREQUENCY`

The SI derived dimension of frequency. Its SI unit is [`HERTZ`](#hertz).

```hare
def FREQUENCY = dimension {
	time = -1,
	...
};
```

### `GAL`

The gal is a CGS unit commonly used in geophysics and gravimetry to express acceleration. The SI counterpart unit is the [`METRE_PER_SECOND_SQUARED`](#metre_per_second_squared)

```hare
def GAL = unit {
	dim = ACCELERATION,
	scale = 0.01,
};
```

### `GAUSS`

The gauss is a CGS unit commonly used in physics and engineering to express magnetic flux density. The SI counterpart unit is the [`TESLA`](#tesla)

```hare
def GAUSS = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-4,
};
```

### `GIGAHERTZ`

The gigahertz is a scaled SI unit of frequency. The corresponding unscaled SI unit is the [`HERTZ`](#hertz).

```hare
def GIGAHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e9,
};
```

### `GIGAJOULE`

The gigajoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def GIGAJOULE = unit {
	dim = ENERGY,
	scale = 1.0e9,
};
```

### `GIGAPASCAL`

The gigapascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def GIGAPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e9,
};
```

### `GIGAWATT`

The gigawatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def GIGAWATT = unit {
	dim = POWER,
	scale = 1.0e9,
};
```

### `GRAM`

The gram is a scaled SI unit of mass. The corresponding unscaled SI unit is the [`KILOGRAM`](#kilogram).

```hare
def GRAM = unit {
	dim = MASS,
	scale = 1.0e-3,
};
```

### `HECTARE`

The hectare is non-SI metric unit commonly used to express areas of land. The SI counterpart unit is the [`SQUARE_METRE`](#square_metre)

```hare
def HECTARE = unit {
	dim = AREA,
	scale = 1.0e4,
};
```

### `HECTOMETRE`

The hectometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def HECTOMETRE = unit {
	dim = LENGTH,
	scale = 100.0,
};
```

### `HECTOPASCAL`

The hectopascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def HECTOPASCAL = unit {
	dim = PRESSURE,
	scale = 100.0,
};
```

### `HOUR`

The hour is non-SI unit of time. The SI counterpart unit is the [`SECOND`](#second)

```hare
def HOUR = unit {
	dim = TIME,
	scale = 3600.0,
};
```

### `HYPERFINE_TRANSITION_CAESIUM_133`

The caesium-133 hyperfine transition frequency, which defines the SI second. Its SI unit is [`HERTZ`](#hertz).

```hare
def HYPERFINE_TRANSITION_CAESIUM_133 = quantity {
	unit = HERTZ,
	value = 9192631770.0,
};
```

### `ILLUMINANCE`

The SI derived dimension of illuminance. Its SI unit is [`LUX`](#lux).

```hare
def ILLUMINANCE = dimension {
	length = -2,
	luminosity = 1,
	...
};
```

### `INDUCTANCE`

The SI derived dimension of inductance. Its SI unit is [`HENRY`](#henry).

```hare
def INDUCTANCE = dimension {
	mass = 1,
	length = 2,
	time = -2,
	current = -2,
	...
};
```

### `JOULE_PER_KELVIN`

The joule per kelvin is the coherent SI unit of [`ENTROPY`](#entropy).

```hare
def JOULE_PER_KELVIN = unit {
	dim = ENTROPY,
	scale = 1.0,
};
```

### `JOULE_SECOND`

The joule-second is the coherent SI unit of [`ACTION`](#action).

```hare
def JOULE_SECOND = unit {
	dim = ACTION,
	scale = 1.0,
};
```

### `KILOGRAM_PER_CUBIC_METRE`

The kilogram per cubic metre is the SI unit for [`DENSITY`](#density).

```hare
def KILOGRAM_PER_CUBIC_METRE = unit {
	dim = DENSITY,
	scale = 1.0,
};
```

### `KILOHERTZ`

The kilohertz is a scaled SI unit of frequency. The corresponding unscaled SI unit is the [`HERTZ`](#hertz).

```hare
def KILOHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e3,
};
```

### `KILOJOULE`

The kilojoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def KILOJOULE = unit {
	dim = ENERGY,
	scale = 1.0e3,
};
```

### `KILOMETRE`

The kilometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def KILOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e3,
};
```

### `KILONEWTON`

The kilonewton is a scaled SI unit of force. The corresponding unscaled SI unit is the [`NEWTON`](#newton).

```hare
def KILONEWTON = unit {
	dim = FORCE,
	scale = 1.0e3,
};
```

### `KILOOHM`

The kiloohm is a scaled SI unit of electrical resistance. The corresponding unscaled SI unit is the [`OHM`](#ohm).

```hare
def KILOOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e3,
};
```

### `KILOPASCAL`

The kilopascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def KILOPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e3,
};
```

### `KILOVOLT`

The kilovolt is a scaled SI unit of electric potential. The corresponding unscaled SI unit is the [`VOLT`](#volt).

```hare
def KILOVOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0e3,
};
```

### `KILOWATT`

The kilowatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def KILOWATT = unit {
	dim = POWER,
	scale = 1.0e3,
};
```

### `KINEMATIC_VISCOSITY`

The SI derived dimension of kinematic viscosity. Its SI unit is [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second).

```hare
def KINEMATIC_VISCOSITY = dimension {
	length = 2,
	time = -1,
	...
};
```

### `LENGTH`

The SI base dimension of length.

```hare
def LENGTH = dimension {
	length = 1,
	...
};
```

### `LITRE`

The litre is a non-SI metric unit of volume in common general use. See [`CUBIC_METRE`](#cubic_metre).

```hare
def LITRE = unit {
	dim = VOLUME,
	scale = 1.0e-3,
};
```

### `LUMINOSITY`

The SI base dimension of luminous intensity.

```hare
def LUMINOSITY = dimension {
	luminosity = 1,
	...
};
```

### `LUMINOUS_EFFICACY_540_THZ`

The luminous efficacy of monochromatic radiation at 540 THz, an exact defining constant of the SI for [`LUMINOUS_EFFICACY`](#luminous_efficacy). Its SI unit is [`LUMEN_PER_WATT`](#lumen_per_watt).

```hare
def LUMINOUS_EFFICACY_540_THZ = quantity {
	unit = LUMEN_PER_WATT,
	value = 683.0,
};
```

### `LUMINOUS_FLUX`

The SI derived dimension of luminous flux. Its SI unit is [`LUMEN`](#lumen).

```hare
def LUMINOUS_FLUX = dimension {
	luminosity = 1,
	...
};
```

### `MAGNETIC_FLUX`

The SI derived dimension of magnetic flux. Its SI unit is [`WEBER`](#weber).

```hare
def MAGNETIC_FLUX = dimension {
	mass = 1,
	length = 2,
	time = -2,
	current = -1,
	...
};
```

### `MAGNETIC_FLUX_DENSITY`

The SI derived dimension of magnetic flux density. Its SI unit is [`TESLA`](#tesla).

```hare
def MAGNETIC_FLUX_DENSITY = dimension {
	mass = 1,
	time = -2,
	current = -1,
	...
};
```

### `MASS`

The SI base dimension of mass.

```hare
def MASS = dimension {
	mass = 1,
	...
};
```

### `MAXWELL`

The maxwell is a CGS electromagnetic unit used to express magnetic flux. The SI counterpart unit is the [`WEBER`](#weber)

```hare
def MAXWELL = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0e-8,
};
```

### `MEGAHERTZ`

The megahertz is a scaled SI unit of frequency. The corresponding unscaled SI unit is the [`HERTZ`](#hertz).

```hare
def MEGAHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e6,
};
```

### `MEGAJOULE`

The megajoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def MEGAJOULE = unit {
	dim = ENERGY,
	scale = 1.0e6,
};
```

### `MEGANEWTON`

The meganewton is a scaled SI unit of force. The corresponding unscaled SI unit is the [`NEWTON`](#newton).

```hare
def MEGANEWTON = unit {
	dim = FORCE,
	scale = 1.0e6,
};
```

### `MEGAOHM`

The megaohm is a scaled SI unit of electrical resistance. The corresponding unscaled SI unit is the [`OHM`](#ohm).

```hare
def MEGAOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e6,
};
```

### `MEGAPASCAL`

The megapascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def MEGAPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e6,
};
```

### `MEGAWATT`

The megawatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def MEGAWATT = unit {
	dim = POWER,
	scale = 1.0e6,
};
```

### `MICROAMPERE`

The microampere is a scaled SI unit of electric current. The corresponding unscaled SI unit is the [`AMPERE`](#ampere).

```hare
def MICROAMPERE = unit {
	dim = CURRENT,
	scale = 1.0e-6,
};
```

### `MICROCOULOMB`

The microcoulomb is a scaled SI unit of electric charge. The corresponding unscaled SI unit is the [`COULOMB`](#coulomb).

```hare
def MICROCOULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0e-6,
};
```

### `MICROFARAD`

The microfarad is a scaled SI unit of capacitance. The corresponding unscaled SI unit is the [`FARAD`](#farad).

```hare
def MICROFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-6,
};
```

### `MICROGRAM`

The microgram is a scaled SI unit of mass. The corresponding unscaled SI unit is the [`KILOGRAM`](#kilogram).

```hare
def MICROGRAM = unit {
	dim = MASS,
	scale = 1.0e-9,
};
```

### `MICROMETRE`

The micrometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def MICROMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-6,
};
```

### `MICRON`

The micron is an alternative name for the [`MICROMETRE`](#micrometre).

```hare
def MICRON = MICROMETRE;
```

### `MICROSECOND`

The microsecond is a scaled SI unit of time. The corresponding unscaled SI unit is the [`SECOND`](#second).

```hare
def MICROSECOND = unit {
	dim = TIME,
	scale = 1.0e-6,
};
```

### `MICROTESLA`

The microtesla is a scaled SI unit of magnetic flux density. The corresponding unscaled SI unit is the [`TESLA`](#tesla).

```hare
def MICROTESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-6,
};
```

### `MILLIAMPERE`

The milliampere is a scaled SI unit of electric current. The corresponding unscaled SI unit is the [`AMPERE`](#ampere).

```hare
def MILLIAMPERE = unit {
	dim = CURRENT,
	scale = 1.0e-3,
};
```

### `MILLICOULOMB`

The millicoulomb is a scaled SI unit of electric charge. The corresponding unscaled SI unit is the [`COULOMB`](#coulomb).

```hare
def MILLICOULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0e-3,
};
```

### `MILLIGRAM`

The milligram is a scaled SI unit of mass. The corresponding unscaled SI unit is the [`KILOGRAM`](#kilogram).

```hare
def MILLIGRAM = unit {
	dim = MASS,
	scale = 1.0e-6,
};
```

### `MILLIJOULE`

The millijoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def MILLIJOULE = unit {
	dim = ENERGY,
	scale = 1.0e-3,
};
```

### `MILLIMETRE`

The millimetre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def MILLIMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-3,
};
```

### `MILLIMETRES_OF_MERCURY`

Millimetres of mercury are widely used in medicine and meteorology to express pressure. The SI counterpart unit is the [`PASCAL`](#pascal)

```hare
def MILLIMETRES_OF_MERCURY = unit {
	dim = PRESSURE,
	scale = 133.322,
};
```

### `MILLINEWTON`

The millinewton is a scaled SI unit of force. The corresponding unscaled SI unit is the [`NEWTON`](#newton).

```hare
def MILLINEWTON = unit {
	dim = FORCE,
	scale = 1.0e-3,
};
```

### `MILLIOHM`

The milliohm is a scaled SI unit of electrical resistance. The corresponding unscaled SI unit is the [`OHM`](#ohm).

```hare
def MILLIOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e-3,
};
```

### `MILLIPASCAL`

The millipascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def MILLIPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e-3,
};
```

### `MILLIPASCAL_SECOND`

The millipascal-second is a scaled SI unit of dynamic viscosity. The corresponding unscaled SI unit is the [`PASCAL_SECOND`](#pascal_second).

```hare
def MILLIPASCAL_SECOND = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 1.0e-3,
};
```

### `MILLISECOND`

The millisecond is a scaled SI unit of time. The corresponding unscaled SI unit is the [`SECOND`](#second).

```hare
def MILLISECOND = unit {
	dim = TIME,
	scale = 1.0e-3,
};
```

### `MILLITESLA`

The millitesla is a scaled SI unit of magnetic flux density. The corresponding unscaled SI unit is the [`TESLA`](#tesla).

```hare
def MILLITESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-3,
};
```

### `MILLIVOLT`

The millivolt is a scaled SI unit of electric potential. The corresponding unscaled SI unit is the [`VOLT`](#volt).

```hare
def MILLIVOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0e-3,
};
```

### `MILLIWATT`

The milliwatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def MILLIWATT = unit {
	dim = POWER,
	scale = 1.0e-3,
};
```

### `MILLIWEBER`

The milliweber is a scaled SI unit of magnetic flux. The corresponding unscaled SI unit is the [`WEBER`](#weber).

```hare
def MILLIWEBER = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0e-3,
};
```

### `MINUTE`

The minute is non-SI unit of time. The SI counterpart unit is the [`SECOND`](#second)

```hare
def MINUTE = unit {
	dim = TIME,
	scale = 60.0,
};
```

### `NANOFARAD`

The nanofarad is a scaled SI unit of capacitance. The corresponding unscaled SI unit is the [`FARAD`](#farad).

```hare
def NANOFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-9,
};
```

### `NANOMETRE`

The nanometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def NANOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-9,
};
```

### `NANOSECOND`

The nanosecond is a scaled SI unit of time. The corresponding unscaled SI unit is the [`SECOND`](#second).

```hare
def NANOSECOND = unit {
	dim = TIME,
	scale = 1.0e-9,
};
```

### `NEPER`

The neper is a non-SI relative logarithmic unit used in acoustics, telecommunications, and signal processing to express ratios of field quantities. This unit is dimensionless and does not support conversion. See also: [`BEL`](#bel).

```hare
def NEPER = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

### `NEWTON_METRE`

The newton-metre is the coherent SI unit of [`TORQUE`](#torque).

```hare
def NEWTON_METRE = unit {
	dim = TORQUE,
	scale = 1.0,
};
```

### `NEWTON_PER_METRE`

The newton per metre is the coherent SI unit of [`SURFACE_TENSION`](#surface_tension).

```hare
def NEWTON_PER_METRE = unit {
	dim = SURFACE_TENSION,
	scale = 1.0,
};
```

### `OERSTED`

The oersted is a CGS electromagnetic unit used to express magnetic field strength. The SI counterpart unit is the [`HENRY`](#henry).

```hare
def OERSTED = unit {
	dim = MAGNETIC_FIELD_STRENGTH,
	scale = 79.57747155,
};
```

### `PASCAL_SECOND`

The pascal-second is the coherent SI unit of [`DYNAMIC_VISCOSITY`](#dynamic_viscosity).

```hare
def PASCAL_SECOND = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 1.0,
};
```

### `PICOFARAD`

The picofarad is a scaled SI unit of capacitance. The corresponding unscaled SI unit is the [`FARAD`](#farad).

```hare
def PICOFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-12,
};
```

### `PICOMETRE`

The picometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def PICOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-12,
};
```

### `PLANCK`

The Planck constant, an exact defining constant of the SI relating the energy of a photon to its frequency. Its SI unit is [`JOULE_SECOND`](#joule_second).

```hare
def PLANCK = quantity {
	unit = JOULE_SECOND,
	value = 6.62607015e-34,
};
```

### `POISE`

The poise is a CGS unit commonly used in rheology and fluid mechanics to express dynamic viscosity.

```hare
def POISE = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 0.1,
};
```

### `POWER`

The SI derived dimension of power. Its SI unit is [`WATT`](#watt).

```hare
def POWER = dimension {
	mass = 1,
	length = 2,
	time = -3,
	...
};
```

### `PRESSURE`

The SI derived dimension of pressure. Its SI unit is [`PASCAL`](#pascal).

```hare
def PRESSURE = dimension {
	mass = 1,
	length = -1,
	time = -2,
	...
};
```

### `RAD`

The rad is a non-SI unit historically used in radiobiology and radiation dosimetry to express absorbed dose. The SI counterpart unit is the [`GRAY`](#gray).

```hare
def RAD = unit {
	dim = ABSORBED_DOSE,
	scale = 0.01,
};
```

### `RECIPROCAL_CUBIC_METRE`

The reciprocal cubic metre is the coherent SI unit of [`SPATIAL_FREQUENCY_3D`](#spatial_frequency_3d).

```hare
def RECIPROCAL_CUBIC_METRE = unit {
	dim = SPATIAL_FREQUENCY_3D,
	scale = 1.0,
};
```

### `RECIPROCAL_CURRENT`

The reciprocal of the SI base dimension of electric current.

```hare
def RECIPROCAL_CURRENT = dimension {
	current = -1,
	...
};
```

### `RECIPROCAL_LENGTH`

The reciprocal of the SI base dimension of mass.

```hare
def RECIPROCAL_LENGTH = dimension {
	length = -1,
	...
};
```

### `RECIPROCAL_LUMINOSITY`

The reciprocal of the SI base dimension of luminous intensity.

```hare
def RECIPROCAL_LUMINOSITY = dimension {
	luminosity = -1,
	...
};
```

### `RECIPROCAL_MASS`

The reciprocal of the SI base dimension of mass.

```hare
def RECIPROCAL_MASS = dimension {
	mass = -1,
	...
};
```

### `RECIPROCAL_SQUARE_METRE`

The reciprocal square metre is the coherent SI unit of [`SPATIAL_FREQUENCY_2D`](#spatial_frequency_2d).

```hare
def RECIPROCAL_SQUARE_METRE = unit {
	dim = SPATIAL_FREQUENCY_2D,
	scale = 1.0,
};
```

### `RECIPROCAL_SUBSTANCE`

The reciprocal of the SI base dimension of amount of substance.

```hare
def RECIPROCAL_SUBSTANCE = dimension {
	substance = -1,
	...
};
```

### `RECIPROCAL_TEMPERATURE`

The reciprocal of the SI base dimension of thermodynamic temperature.

```hare
def RECIPROCAL_TEMPERATURE = dimension {
	temperature = -1,
	...
};
```

### `REM`

The rem (or Roentgen equivalent man) is a non-SI unit historically used in radiation protection to express equivalent dose. The SI counterpart unit is the [`SIEVERT`](#sievert).

```hare
def REM = unit {
	dim = DOSE_EQUIVALENT,
	scale = 0.01,
};
```

### `RESISTANCE`

The SI derived dimension of electrical resistance. Its SI unit is [`OHM`](#ohm).

```hare
def RESISTANCE = dimension {
	mass = 1,
	length = 2,
	time = -3,
	current = -2,
	...
};
```

### `ROENTGEN`

The roentgen is a non-SI unit historically used in radiology and radiation protection to express [`EXPOSURE`](#exposure). The SI counterpart unit is the [`COULOMB_PER_KILOGRAM`](#coulomb_per_kilogram).

```hare
def ROENTGEN = unit {
	dim = EXPOSURE,
	scale = 2.58e-4,
};
```

### `SPATIAL_FREQUENCY_1D`

Alias for [`RECIPROCAL_LENGTH`](#reciprocal_length).

```hare
def SPATIAL_FREQUENCY_1D = RECIPROCAL_LENGTH;
```

### `SPATIAL_FREQUENCY_2D`

The SI derived dimension of two-dimensional spatial frequency. Its SI unit is [`RECIPROCAL_SQUARE_METRE`](#reciprocal_square_metre).

```hare
def SPATIAL_FREQUENCY_2D = dimension {
	length = -2,
	...
};
```

### `SPATIAL_FREQUENCY_3D`

The SI derived dimension of three-dimensional spatial frequency. Its SI unit is [`RECIPROCAL_CUBIC_METRE`](#reciprocal_cubic_metre).

```hare
def SPATIAL_FREQUENCY_3D = dimension {
	length = -3,
	...
};
```

### `SPEED_OF_LIGHT`

The speed of light in vacuum, an exact defining constant of the SI. Its SI unit is [`METRE_PER_SECOND`](#metre_per_second).

```hare
def SPEED_OF_LIGHT = quantity {
	unit = METRE_PER_SECOND,
	value = 299792458.0,
};
```

### `SQUARE_CENTIMETRE`

The square centimetre is a scaled SI unit of area. The corresponding unscaled SI unit is the [`SQUARE_METRE`](#square_metre).

```hare
def SQUARE_CENTIMETRE = unit {
	dim = AREA,
	scale = 1.0e-4,
};
```

### `SQUARE_KILOMETRE`

The square kilometre is a scaled SI unit of area. The corresponding unscaled SI unit is the [`SQUARE_METRE`](#square_metre).

```hare
def SQUARE_KILOMETRE = unit {
	dim = AREA,
	scale = 1.0e6,
};
```

### `SQUARE_METRE`

The reciprocal metre is the coherent SI unit of [`RECIPROCAL_LENGTH`](#reciprocal_length).

```hare
def SQUARE_METRE = unit {
	dim = AREA,
	scale = 1.0,
};
```

### `SQUARE_METRE_PER_SECOND`

The square metre per second is the coherent SI unit of [`KINEMATIC_VISCOSITY`](#kinematic_viscosity).

```hare
def SQUARE_METRE_PER_SECOND = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0,
};
```

### `SQUARE_MILLIMETRE`

The square millimetre is a scaled SI unit of area. The corresponding unscaled SI unit is the [`SQUARE_METRE`](#square_metre).

```hare
def SQUARE_MILLIMETRE = unit {
	dim = AREA,
	scale = 1.0e-6,
};
```

### `SQUARE_MILLIMETRE_PER_SECOND`

The square millimetre per second is a scaled SI unit of kinematic viscosity. The corresponding unscaled SI unit is the [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second).

```hare
def SQUARE_MILLIMETRE_PER_SECOND = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0e-6,
};
```

### `STOKES`

The stokes is a CGS unit commonly used in fluid mechanics to express viscosity. The SI counterpart unit is the [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second).

```hare
def STOKES = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0e-4,
};
```

### `SUBSTANCE`

The SI base dimension of amount of substance.

```hare
def SUBSTANCE = dimension {
	substance = 1,
	...
};
```

### `TEMPERATURE`

The SI base dimension of thermodynamic temperature.

```hare
def TEMPERATURE = dimension {
	temperature = 1,
	...
};
```

### `TIME`

The SI base dimension of time.

```hare
def TIME = dimension {
	time = 1,
	...
};
```

### `TONNE`

The tonne is a non-SI metric unit of mass still in common general use. Not to be confused with the ton units used in Imperial or Customary systems. See [`KILOGRAM`](#kilogram).

```hare
def TONNE = unit {
	dim = MASS,
	scale = 1.0e3,
};
```

### `TORR`

The torr is non-SI unit historically used in physics. The SI counterpart unit is the [`PASCAL`](#pascal).

```hare
def TORR = unit {
	dim = PRESSURE,
	scale = 133.322368421,
};
```

### `WAVENUMBER`

Alias for [`RECIPROCAL_LENGTH`](#reciprocal_length).

```hare
def WAVENUMBER = RECIPROCAL_LENGTH;
```

## Functions

### `add`

Returns the sum of quantities a and b, converting b to a's unit. If b is an f64, it is treated as a value in a's unit.

```hare
fn add(a: quantity, b: (quantity | f64)) (quantity | dimension_mismatch);
```

### `divd`

Returns the quotient of units a and b.

```hare
fn divd(a: dimension, b: dimension) dimension;
```

### `divq`

Returns the quotient of quantities a and b, or scales a by 1/b if b is an f64.

```hare
fn divq(a: quantity, b: (quantity | f64)) quantity;
```

### `divu`

Returns the quotient of units a and b.

```hare
fn divu(a: unit, b: unit) unit;
```

### `encodejson`

Writes JSON encoded representation of a quantity or unit.

```hare
fn encodejson(h: io::handle, obj: (quantity | unit)) (size | error);
```

### `equal`

Returns true if dimensions a and b are equal.

```hare
fn equal(a: dimension, b: dimension) bool;
```

### `fprint`

Formats and prints x to handler h. Returns the number of bytes printed. See also: [`fprint`](#fprint), [`println`](#println).

```hare
fn fprint(
	out: io::handle,
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
	strict: bool = false,
) (size | error);
```

### `identify`

Returns the decimal prefix and unit symbol components of the input string. If the input string does not match any prefix or unit symbol, the first component of the tuple will be empty. Output is trimmed and borrowed from input string.

```hare
fn identify(in: str) (prefix_kind, unit_kind);
```

### `isclose`

Returns whether a and b are within tol of each other.

```hare
fn isclose(
	a: quantity,
	b: quantity,
	tol: f64 = math::STANDARD_TOL,
) (bool | dimension_mismatch);
```

### `isinf`

Returns true if the value of the quantity or scale of its unit is infinite.

```hare
fn isinf(q: quantity) bool;
```

### `isnan`

Returns true if the value of the quantity or scale of its unit is NaN.

```hare
fn isnan(q: quantity) bool;
```

### `muld`

Returns the product of units a and b.

```hare
fn muld(a: dimension, b: dimension) dimension;
```

### `mulq`

Returns the product of quantities a and b, or scales a by b if b is an f64.

```hare
fn mulq(a: quantity, b: (quantity | f64)) quantity;
```

### `mulu`

Returns the product of units a and b.

```hare
fn mulu(a: unit, b: unit) unit;
```

### `powd`

Returns the dimension x raised to the power of p

```hare
fn powd(x: dimension, p: int) dimension;
```

### `powq`

Returns quantity x raised to the integer power p.

```hare
fn powq(x: quantity, p: int) quantity;
```

### `powu`

Returns the quantity x raised to the integer power p.

```hare
fn powu(x: unit, p: int) unit;
```

### `print`

Formats and prints x to `os::stdout`. Returns the number of bytes printed. See also: [`fprint`](#fprint), [`println`](#println).

```hare
fn print(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
	strict: bool = false,
) (size | error);
```

### `println`

Formats and prints x followed by a newline to h. Returns the number of bytes printed. See also: [`fprint`](#fprint), [`print`](#print).

```hare
fn println(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
	strict: bool = false,
) (size | error);
```

### `scale`

Scales the unit by a f64 or metric prefix factor.

```hare
fn scale(u: unit, fac: (prefix_kind | f64)) unit;
```

### `strerror`

Returns a human-readable description of an error. Output strings are statically allocated and are overwritten on subsequent calls.

```hare
fn strerror(err: error) str;
```

### `strf`

Formats a quantity as a string using the specified unit format, precision, notation, and character encoding. The result must be freed after use.

```hare
fn strf(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
	strict: bool = false,
) (str | error);
```

### `strp`

Parses a numeric quantity and unit expression. Accepts fixed-point and scientific notation, with permissive unit syntax including alternative multiplication operators (*, ×, ·, ⋅), exponent notation (^, **, superscripts), exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is permitted.

Valid examples:

```
strp("67 m");
strp("1.21 GW");
strp("9.80665 m/s^2");
strp("32°C");
strp("1.5 kΩ");
strp("1.5 kohm");
strp("6.022e23 mol**-1");
strp("20 m²");

```

Returns the parsed [`quantity`](#quantity) on success, or an [`error`](#error) if the input is invalid.

- see also: [`strpu`](#strpu)

```hare
fn strp(s: str, strict: bool = false) (quantity | error);
```

### `strpu`

Parses a unit expression. Accepts fixed-point and scientific notation, with permissive unit syntax including alternative multiplication operators (*, ×, ·, ⋅), exponent notation (^, **, superscripts), exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is permitted.

Valid examples:

```
strpu("m");
strpu("m/s^2");
strpu("°C");
strpu("kΩ");
strpu("kohm");
strpu("mol**-1");
strpu("m²");

```

Returns the parsed [`unit`](#unit) on success, or an [`error`](#error) if the input is invalid.

- see also: [`strp`](#strp)

```hare
fn strpu(s: str, strict: bool = false) (unit | error);
```

### `sub`

Returns the difference of quantities a and b, converting b to a's unit. If b is an f64, it is treated as a value in a's unit.

```hare
fn sub(a: quantity, b: (quantity | f64)) (quantity | dimension_mismatch);
```

### `tojson`

Returns JSON encoded string representation of a quantity or unit.

```hare
fn tojson(obj: (quantity | unit)) (str | error);
```

