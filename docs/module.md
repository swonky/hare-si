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
const qty: si::quantity = si::strp("20 m/s^2")?;
let text: str = si::strf(qty, "km*s^-2")?;

assert(text == "0.02 km⋅s⁻²");

const text = si::strf(
	acceleration,
	"km/s^2",
	prec=3,
	notation=si::E,
	encoding=si::ASCII,
)?;

assert(c == "2.00E-02 km/s^2");
```

## Index
1. [Types](#types)
2. [Errors](#errors)
3. [Functions](#functions)
4. [Constants](#constants)



---

## Types

[↲ index](#index)

### List of symbols
> \* asterisk indicates symbol is undocumented


- [`dimension`](#dimension)
- [`encoding`](#encoding)
- [`notation`](#notation)
- [`prefix_kind`](#prefix_kind)
- [`quantity`](#quantity)
- [`symbol_kind`](#symbol_kind)
- [`unit`](#unit)
- [`token`](#token)*
- [`token_kind`](#token_kind)*
- [`unit_kind`](#unit_kind)*


---

### `dimension`

[`⌕ ../si/types.ha:5`](../si/types.ha#L5)

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

[↲ types](#types)

---

### `encoding`

[`⌕ ../si/types.ha:37`](../si/types.ha#L37)

Specifies the character encoding options.

```hare
type encoding = enum u8 {
	ASCII,
	UTF8,
	JSON,
};
```

[↲ types](#types)

---

### `notation`

[`⌕ ../si/types.ha:28`](../si/types.ha#L28)

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

[↲ types](#types)

---

### `prefix_kind`

[`⌕ ../si/prefix.ha:82`](../si/prefix.ha#L82)

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

[↲ types](#types)

---

### `quantity`

[`⌕ ../si/types.ha:22`](../si/types.ha#L22)

Represents a physical quantity as a unit and numerical value.

```hare
type quantity = struct {
	unit: unit,
	value: f64,
};
```

[↲ types](#types)

---

### `symbol_kind`

[`⌕ ../si/types.ha:44`](../si/types.ha#L44)

Union of symbol enum types.

```hare
type symbol_kind = (prefix_kind | unit_kind);
```

[↲ types](#types)

---

### `unit`

[`⌕ ../si/types.ha:16`](../si/types.ha#L16)

Represents a unit of measurement by its physical [`dimension`](#dimension) and scale.

```hare
type unit = struct {
	dim: dimension,
	scale: f64,
};
```

[↲ types](#types)

---

### `token`

[`⌕ ../si/lexer.ha:37`](../si/lexer.ha#L37)

```hare
type token = struct {
	kind: token_kind,
	text: str,
	pos: size,
};
```

[↲ types](#types)

---

### `token_kind`

[`⌕ ../si/lexer.ha:15`](../si/lexer.ha#L15)

```hare
type token_kind = enum u8 {
	UNSPECIFIED,
	IDENTIFIER,
	INTEGER,
	SUPER_INTEGER,
	MULTIPLY, // operators
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

[↲ types](#types)

---

### `unit_kind`

[`⌕ ../si/units.ha:29`](../si/units.ha#L29)

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

[↲ types](#types)

---



---

## Errors

[↲ index](#index)

### List of symbols
> \* asterisk indicates symbol is undocumented


- [`dimension_mismatch`](#dimension_mismatch)
- [`error`](#error)
- [`invalid`](#invalid)
- [`invalid_exponent`](#invalid_exponent)
- [`invalid_numeric`](#invalid_numeric)
- [`invalid_symbol`](#invalid_symbol)
- [`not_implemented`](#not_implemented)
- [`unclosed_scope`](#unclosed_scope)*
- [`unexpected_token`](#unexpected_token)*


---

### `dimension_mismatch`

[`⌕ ../si/errors.ha:26`](../si/errors.ha#L26)

The dimensions of two units or quantities do not match.

```hare
type dimension_mismatch = !void;
```

[↲ errors](#errors)

---

### `error`

[`⌕ ../si/errors.ha:38`](../si/errors.ha#L38)

Represents any error that can occur in the si library

```hare
type error = !(invalid_symbol | invalid_exponent | invalid_numeric | unexpected_token |
	unclosed_scope | dimension_mismatch | not_implemented | invalid |
	io::error | strconv::invalid | strconv::overflow | utf8::invalid |
	nomem);
```

[↲ errors](#errors)

---

### `invalid`

[`⌕ ../si/errors.ha:32`](../si/errors.ha#L32)

The input is invalid.

```hare
type invalid = !void;
```

[↲ errors](#errors)

---

### `invalid_exponent`

[`⌕ ../si/errors.ha:35`](../si/errors.ha#L35)

An invalid exponent was encountered.

```hare
type invalid_exponent = !void;
```

[↲ errors](#errors)

---

### `invalid_numeric`

[`⌕ ../si/errors.ha:23`](../si/errors.ha#L23)

No matching unit or prefix was found.

```hare
type invalid_numeric = !str;
```

[↲ errors](#errors)

---

### `invalid_symbol`

[`⌕ ../si/errors.ha:20`](../si/errors.ha#L20)

No matching unit or prefix was found.

```hare
type invalid_symbol = !token;
```

[↲ errors](#errors)

---

### `not_implemented`

[`⌕ ../si/errors.ha:29`](../si/errors.ha#L29)

The requested operation is not implemented.

```hare
type not_implemented = !void;
```

[↲ errors](#errors)

---

### `unclosed_scope`

[`⌕ ../si/errors.ha:16`](../si/errors.ha#L16)

```hare
type unclosed_scope = !token_kind;
```

[↲ errors](#errors)

---

### `unexpected_token`

[`⌕ ../si/errors.ha:17`](../si/errors.ha#L17)

```hare
type unexpected_token = !token;
```

[↲ errors](#errors)

---



---

## Functions

[↲ index](#index)

### List of symbols
> \* asterisk indicates symbol is undocumented


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
- [`split`](#split)*


---

### `add`

[`⌕ ../si/math.ha:114`](../si/math.ha#L114)

Returns the sum of quantities a and b, converting b to a's unit. If b is an f64, it is treated as a value in a's unit.

```hare
fn add(a: quantity, b: (quantity | f64)) (quantity | dimension_mismatch);
```

[↲ functions](#functions)

---

### `divd`

[`⌕ ../si/math.ha:60`](../si/math.ha#L60)

Returns the quotient of units a and b.

```hare
fn divd(a: dimension, b: dimension) dimension;
```

[↲ functions](#functions)

---

### `divq`

[`⌕ ../si/math.ha:163`](../si/math.ha#L163)

Returns the quotient of quantities a and b, or scales a by 1/b if b is an f64.

```hare
fn divq(a: quantity, b: (quantity | f64)) quantity;
```

[↲ functions](#functions)

---

### `divu`

[`⌕ ../si/math.ha:97`](../si/math.ha#L97)

Returns the quotient of units a and b.

```hare
fn divu(a: unit, b: unit) unit;
```

[↲ functions](#functions)

---

### `encodejson`

[`⌕ ../si/encode.ha:37`](../si/encode.ha#L37)

Writes JSON encoded representation of a quantity or unit.

```hare
fn encodejson(h: io::handle, obj: (quantity | unit)) (size | error);
```

[↲ functions](#functions)

---

### `equal`

[`⌕ ../si/math.ha:11`](../si/math.ha#L11)

Returns true if dimensions a and b are equal.

```hare
fn equal(a: dimension, b: dimension) bool;
```

[↲ functions](#functions)

---

### `fprint`

[`⌕ ../si/format.ha:495`](../si/format.ha#L495)

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

[↲ functions](#functions)

---

### `identify`

[`⌕ ../si/parser.ha:506`](../si/parser.ha#L506)

Returns the decimal prefix and unit symbol components of the input string. If the input string does not match any prefix or unit symbol, the first component of the tuple will be empty. Output is trimmed and borrowed from input string.

```hare
fn identify(in: str) (prefix_kind, unit_kind);
```

[↲ functions](#functions)

---

### `isclose`

[`⌕ ../si/math.ha:22`](../si/math.ha#L22)

Returns whether a and b are within tol of each other.

```hare
fn isclose(
	a: quantity,
	b: quantity,
	tol: f64 = math::STANDARD_TOL,
) (bool | dimension_mismatch);
```

[↲ functions](#functions)

---

### `isinf`

[`⌕ ../si/math.ha:177`](../si/math.ha#L177)

Returns true if the value of the quantity or scale of its unit is infinite.

```hare
fn isinf(q: quantity) bool;
```

[↲ functions](#functions)

---

### `isnan`

[`⌕ ../si/math.ha:182`](../si/math.ha#L182)

Returns true if the value of the quantity or scale of its unit is NaN.

```hare
fn isnan(q: quantity) bool;
```

[↲ functions](#functions)

---

### `muld`

[`⌕ ../si/math.ha:49`](../si/math.ha#L49)

Returns the product of units a and b.

```hare
fn muld(a: dimension, b: dimension) dimension;
```

[↲ functions](#functions)

---

### `mulq`

[`⌕ ../si/math.ha:149`](../si/math.ha#L149)

Returns the product of quantities a and b, or scales a by b if b is an f64.

```hare
fn mulq(a: quantity, b: (quantity | f64)) quantity;
```

[↲ functions](#functions)

---

### `mulu`

[`⌕ ../si/math.ha:89`](../si/math.ha#L89)

Returns the product of units a and b.

```hare
fn mulu(a: unit, b: unit) unit;
```

[↲ functions](#functions)

---

### `powd`

[`⌕ ../si/math.ha:71`](../si/math.ha#L71)

Returns the dimension x raised to the power of p

```hare
fn powd(x: dimension, p: int) dimension;
```

[↲ functions](#functions)

---

### `powq`

[`⌕ ../si/math.ha:187`](../si/math.ha#L187)

Returns quantity x raised to the integer power p.

```hare
fn powq(x: quantity, p: int) quantity;
```

[↲ functions](#functions)

---

### `powu`

[`⌕ ../si/math.ha:105`](../si/math.ha#L105)

Returns the quantity x raised to the integer power p.

```hare
fn powu(x: unit, p: int) unit;
```

[↲ functions](#functions)

---

### `print`

[`⌕ ../si/format.ha:515`](../si/format.ha#L515)

Formats and prints x to . Returns the number of bytes printed. See also: [`fprint`](#fprint), [`println`](#println).

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

[↲ functions](#functions)

---

### `println`

[`⌕ ../si/format.ha:527`](../si/format.ha#L527)

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

[↲ functions](#functions)

---

### `scale`

[`⌕ ../si/math.ha:37`](../si/math.ha#L37)

Scales the unit by a f64 or metric prefix factor.

```hare
fn scale(u: unit, fac: (prefix_kind | f64)) unit;
```

[↲ functions](#functions)

---

### `strerror`

[`⌕ ../si/errors.ha:46`](../si/errors.ha#L46)

Returns a human-readable description of an error. Output strings are statically allocated and are overwritten on subsequent calls.

```hare
fn strerror(err: error) str;
```

[↲ functions](#functions)

---

### `strf`

[`⌕ ../si/format.ha:543`](../si/format.ha#L543)

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

[↲ functions](#functions)

---

### `strp`

[`⌕ ../si/parser.ha:606`](../si/parser.ha#L606)

Parses a numeric quantity and unit expression. Accepts fixed-point and scientific notation, with permissive unit syntax including alternative multiplication operators (*, ×, ·, ⋅), exponent notation (^, **, superscripts), exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is permitted.

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

Returns the parsed [`quantity`](#quantity) on success, or an [`error`](#error) if the input is invalid.

- see also: [`strpu`](#strpu)

```hare
fn strp(s: str, strict: bool = false) (quantity | error);
```

[↲ functions](#functions)

---

### `strpu`

[`⌕ ../si/parser.ha:569`](../si/parser.ha#L569)

Parses a unit expression. Accepts fixed-point and scientific notation, with permissive unit syntax including alternative multiplication operators (*, ×, ·, ⋅), exponent notation (^, **, superscripts), exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded symbols, alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is permitted.

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

Returns the parsed [`unit`](#unit) on success, or an [`error`](#error) if the input is invalid.

- see also: [`strp`](#strp)

```hare
fn strpu(s: str, strict: bool = false) (unit | error);
```

[↲ functions](#functions)

---

### `sub`

[`⌕ ../si/math.ha:132`](../si/math.ha#L132)

Returns the difference of quantities a and b, converting b to a's unit. If b is an f64, it is treated as a value in a's unit.

```hare
fn sub(a: quantity, b: (quantity | f64)) (quantity | dimension_mismatch);
```

[↲ functions](#functions)

---

### `tojson`

[`⌕ ../si/encode.ha:45`](../si/encode.ha#L45)

Returns JSON encoded string representation of a quantity or unit.

```hare
fn tojson(obj: (quantity | unit)) (str | error);
```

[↲ functions](#functions)

---

### `split`

[`⌕ ../si/parser.ha:475`](../si/parser.ha#L475)

```hare
fn split(input: str, strict: bool = false) ((str, str) | error);
```

[↲ functions](#functions)

---



---

## Constants

[↲ index](#index)

### List of symbols
> \* asterisk indicates symbol is undocumented


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
- [`ACCELERATION`](#acceleration)*
- [`ACTION`](#action)*
- [`AMPERE`](#ampere)*
- [`AMPERE_PER_METRE`](#ampere_per_metre)*
- [`AMPERE_PER_SQUARE_METRE`](#ampere_per_square_metre)*
- [`AREA`](#area)*
- [`ATTO`](#atto)*
- [`BECQUEREL`](#becquerel)*
- [`CANDELA`](#candela)*
- [`CANDELA_PER_SQUARE_METRE`](#candela_per_square_metre)*
- [`CENTI`](#centi)*
- [`CONCENTRATION`](#concentration)*
- [`COULOMB`](#coulomb)*
- [`COULOMB_PER_CUBIC_METRE`](#coulomb_per_cubic_metre)*
- [`COULOMB_PER_KILOGRAM`](#coulomb_per_kilogram)*
- [`COULOMB_PER_METRE`](#coulomb_per_metre)*
- [`COULOMB_PER_SQUARE_METRE`](#coulomb_per_square_metre)*
- [`CUBIC_METRE`](#cubic_metre)*
- [`CUBIC_METRE_PER_KILOGRAM`](#cubic_metre_per_kilogram)*
- [`CURRENT_DENSITY`](#current_density)*
- [`DECA`](#deca)*
- [`DECI`](#deci)*
- [`DEGREE_CELSIUS`](#degree_celsius)*
- [`DENSITY`](#density)*
- [`DIMENSIONLESS_UNIT`](#dimensionless_unit)*
- [`ENTROPY`](#entropy)*
- [`EXA`](#exa)*
- [`FARAD`](#farad)*
- [`FEMTO`](#femto)*
- [`GIGA`](#giga)*
- [`GRAY`](#gray)*
- [`HECTO`](#hecto)*
- [`HENRY`](#henry)*
- [`HERTZ`](#hertz)*
- [`JOULE`](#joule)*
- [`KATAL`](#katal)*
- [`KELVIN`](#kelvin)*
- [`KILO`](#kilo)*
- [`KILOGRAM`](#kilogram)*
- [`KILOGRAM_PER_SQUARE_METRE`](#kilogram_per_square_metre)*
- [`LINEAR_CHARGE_DENSITY`](#linear_charge_density)*
- [`LUMEN`](#lumen)*
- [`LUMEN_PER_WATT`](#lumen_per_watt)*
- [`LUMINANCE`](#luminance)*
- [`LUMINOUS_EFFICACY`](#luminous_efficacy)*
- [`LUX`](#lux)*
- [`MAGNETIC_FIELD_STRENGTH`](#magnetic_field_strength)*
- [`MEGA`](#mega)*
- [`METRE`](#metre)*
- [`METRE_PER_SECOND`](#metre_per_second)*
- [`METRE_PER_SECOND_SQUARED`](#metre_per_second_squared)*
- [`MICRO`](#micro)*
- [`MILLI`](#milli)*
- [`MOLE`](#mole)*
- [`MOLE_PER_CUBIC_METRE`](#mole_per_cubic_metre)*
- [`NANO`](#nano)*
- [`NEWTON`](#newton)*
- [`NONE`](#none)*
- [`OHM`](#ohm)*
- [`PASCAL`](#pascal)*
- [`PETA`](#peta)*
- [`PICO`](#pico)*
- [`QUECTO`](#quecto)*
- [`QUETTA`](#quetta)*
- [`RADIAN`](#radian)*
- [`RECIPROCAL_AMPERE`](#reciprocal_ampere)*
- [`RECIPROCAL_AREA`](#reciprocal_area)*
- [`RECIPROCAL_CANDELA`](#reciprocal_candela)*
- [`RECIPROCAL_KELVIN`](#reciprocal_kelvin)*
- [`RECIPROCAL_KILOGRAM`](#reciprocal_kilogram)*
- [`RECIPROCAL_METRE`](#reciprocal_metre)*
- [`RECIPROCAL_MOLE`](#reciprocal_mole)*
- [`RECIPROCAL_VOLUME`](#reciprocal_volume)*
- [`RONNA`](#ronna)*
- [`RONTO`](#ronto)*
- [`SECOND`](#second)*
- [`SIEMENS`](#siemens)*
- [`SIEVERT`](#sievert)*
- [`SPECIFIC_VOLUME`](#specific_volume)*
- [`STERADIAN`](#steradian)*
- [`SURFACE_CHARGE_DENSITY`](#surface_charge_density)*
- [`SURFACE_DENSITY`](#surface_density)*
- [`SURFACE_TENSION`](#surface_tension)*
- [`TERA`](#tera)*
- [`TESLA`](#tesla)*
- [`TORQUE`](#torque)*
- [`VELOCITY`](#velocity)*
- [`VOLT`](#volt)*
- [`VOLUME`](#volume)*
- [`VOLUME_CHARGE_DENSITY`](#volume_charge_density)*
- [`WATT`](#watt)*
- [`WEBER`](#weber)*
- [`YOCTO`](#yocto)*
- [`YOTTA`](#yotta)*
- [`ZEPTO`](#zepto)*
- [`ZETTA`](#zetta)*


---

### `ABSORBED_DOSE`

[`⌕ ../si/dimensions.ha:56`](../si/dimensions.ha#L56)

The SI derived dimension of absorbed dose. Its SI unit is [`GRAY`](#gray).

```hare
def ABSORBED_DOSE = dimension {
	length = 2,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `ACTIVITY`

[`⌕ ../si/dimensions.ha:60`](../si/dimensions.ha#L60)

The SI derived dimension of radioactive activity. Its SI unit is [`BECQUEREL`](#becquerel).

```hare
def ACTIVITY = dimension {
	time = -1,
	...
};
```

[↲ constants](#constants)

---

### `ANGSTROM`

[`⌕ ../si/units.ha:462`](../si/units.ha#L462)

The angstrom is a non-SI unit of length still widely used in the natural sciences and technology to express atomic-scale lengths. See [`METRE`](#metre).

```hare
def ANGSTROM = unit {
	dim = LENGTH,
	scale = 1.0e-10,
};
```

[↲ constants](#constants)

---

### `ASTRONOMICAL_UNIT`

[`⌕ ../si/units.ha:427`](../si/units.ha#L427)

The astronomical unit is a non-SI unit of length that approximately equates to the average distance between the Sun and the Earth. As of 2012, it is standardised to a fixed length in metres. See [`METRE`](#metre).

```hare
def ASTRONOMICAL_UNIT = unit {
	dim = LENGTH,
	scale = 149597870700.0,
};
```

[↲ constants](#constants)

---

### `ATMOSPHERE`

[`⌕ ../si/units.ha:466`](../si/units.ha#L466)

The standard atmosphere is widely used in chemistry, physics, and engineering as a reference pressure. See [`PASCAL`](#pascal).

```hare
def ATMOSPHERE = unit {
	dim = PRESSURE,
	scale = 101325.0,
};
```

[↲ constants](#constants)

---

### `AVOGADRO`

[`⌕ ../si/constants.ha:36`](../si/constants.ha#L36)

The Avogadro constant, an exact defining constant of the SI representing the number of elementary entities in one mole. Its SI unit is [`RECIPROCAL_MOLE`](#reciprocal_mole).

```hare
def AVOGADRO = quantity {
	unit = RECIPROCAL_MOLE,
	value = 6.02214076e23,
};
```

[↲ constants](#constants)

---

### `BAR`

[`⌕ ../si/units.ha:470`](../si/units.ha#L470)

The bar is a metric unit of pressure commonly used in meteorology and acoustics. Not to be confused with the CGS unit 'Barye'.

```hare
def BAR = unit {
	dim = PRESSURE,
	scale = 1.0e5,
};
```

[↲ constants](#constants)

---

### `BARN`

[`⌕ ../si/units.ha:474`](../si/units.ha#L474)

The barn is commonly used in nuclear and particle physics to express cross-sectional areas of atomic nuclei and subatomic interactions.

```hare
def BARN = unit {
	dim = AREA,
	scale = 1.0e-28,
};
```

[↲ constants](#constants)

---

### `BEL`

[`⌕ ../si/units.ha:433`](../si/units.ha#L433)

The bel is a non-SI relative logarithmic unit commonly used in acoustics, telecommunications, and signal processing to express ratios of power quantities. This unit is dimensionless and does not support conversion. See also: [`NEPER`](#neper).

```hare
def BEL = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `BOLTZMANN`

[`⌕ ../si/constants.ha:15`](../si/constants.ha#L15)

The Boltzmann constant, an exact defining constant of the SI relating thermal energy to thermodynamic temperature. Its SI unit is [`JOULE_PER_KELVIN`](#joule_per_kelvin).

```hare
def BOLTZMANN = quantity {
	unit = JOULE_PER_KELVIN,
	value = 1.380649e-23,
};
```

[↲ constants](#constants)

---

### `CALORIE`

[`⌕ ../si/units.ha:478`](../si/units.ha#L478)

The calorie is non-SI unit commonly used in thermodynamics, chemistry, and nutritional science to express energy. See [`JOULE`](#joule).

```hare
def CALORIE = unit {
	dim = ENERGY,
	scale = 4.184,
};
```

[↲ constants](#constants)

---

### `CAPACITANCE`

[`⌕ ../si/dimensions.ha:64`](../si/dimensions.ha#L64)

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

[↲ constants](#constants)

---

### `CATALYTIC_ACTIVITY`

[`⌕ ../si/dimensions.ha:74`](../si/dimensions.ha#L74)

The SI derived dimension of catalytic activity. Its SI unit is [`KATAL`](#katal).

```hare
def CATALYTIC_ACTIVITY = dimension {
	time = -1,
	substance = 1,
	...
};
```

[↲ constants](#constants)

---

### `CENTIMETRE`

[`⌕ ../si/units.ha:573`](../si/units.ha#L573)

The centimetre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def CENTIMETRE = unit {
	dim = LENGTH,
	scale = 0.01,
};
```

[↲ constants](#constants)

---

### `CONDUCTANCE`

[`⌕ ../si/dimensions.ha:78`](../si/dimensions.ha#L78)

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

[↲ constants](#constants)

---

### `CUBIC_CENTIMETRE`

[`⌕ ../si/units.ha:649`](../si/units.ha#L649)

The cubic centimetre is a scaled SI unit of volume. The corresponding unscaled SI unit is the [`CUBIC_METRE`](#cubic_metre).

```hare
def CUBIC_CENTIMETRE = unit {
	dim = VOLUME,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `CUBIC_MILLIMETRE`

[`⌕ ../si/units.ha:653`](../si/units.ha#L653)

The cubic millimetre is a scaled SI unit of volume. The corresponding unscaled SI unit is the [`CUBIC_METRE`](#cubic_metre).

```hare
def CUBIC_MILLIMETRE = unit {
	dim = VOLUME,
	scale = 1.0e-9,
};
```

[↲ constants](#constants)

---

### `CURIE`

[`⌕ ../si/units.ha:482`](../si/units.ha#L482)

The curie is a non-SI unit historically used in nuclear physics to express radioactivity. See [`BECQUEREL`](#becquerel).

```hare
def CURIE = unit {
	dim = ACTIVITY,
	scale = 3.7e10,
};
```

[↲ constants](#constants)

---

### `CURRENT`

[`⌕ ../si/dimensions.ha:20`](../si/dimensions.ha#L20)

The SI base dimension of electric current.

```hare
def CURRENT = dimension {
	current = 1,
	...
};
```

[↲ constants](#constants)

---

### `DALTON`

[`⌕ ../si/units.ha:436`](../si/units.ha#L436)

The dalton

```hare
def DALTON = unit {
	dim = MASS,
	scale = 1.66053906892e-27,
};
```

[↲ constants](#constants)

---

### `DAY`

[`⌕ ../si/units.ha:485`](../si/units.ha#L485)

The day is a non-SI unit of time. See [`SECOND`](#second).

```hare
def DAY = unit {
	dim = TIME,
	scale = 86400.0,
};
```

[↲ constants](#constants)

---

### `DECAMETRE`

[`⌕ ../si/units.ha:629`](../si/units.ha#L629)

The decametre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def DECAMETRE = unit {
	dim = LENGTH,
	scale = 10.0,
};
```

[↲ constants](#constants)

---

### `DECIMETRE`

[`⌕ ../si/units.ha:625`](../si/units.ha#L625)

The decimetre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def DECIMETRE = unit {
	dim = LENGTH,
	scale = 0.1,
};
```

[↲ constants](#constants)

---

### `DEGREE`

[`⌕ ../si/units.ha:439`](../si/units.ha#L439)

The degree

```hare
def DEGREE = unit {
	dim = DIMENSIONLESS,
	scale = 0.017453292519943295,
};
```

[↲ constants](#constants)

---

### `DIMENSIONLESS`

[`⌕ ../si/dimensions.ha:8`](../si/dimensions.ha#L8)

The dimensionless dimension, with all SI base dimension exponents equal to zero.

```hare
def DIMENSIONLESS = dimension {
	...
};
```

[↲ constants](#constants)

---

### `DOSE_EQUIVALENT`

[`⌕ ../si/dimensions.ha:88`](../si/dimensions.ha#L88)

The SI derived dimension of dose equivalent. Its SI unit is [`SIEVERT`](#sievert).

```hare
def DOSE_EQUIVALENT = dimension {
	length = 2,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `DYNAMIC_VISCOSITY`

[`⌕ ../si/dimensions.ha:231`](../si/dimensions.ha#L231)

The SI derived dimension of dynamic viscosity. Its SI unit is [`PASCAL_SECOND`](#pascal_second).

```hare
def DYNAMIC_VISCOSITY = dimension {
	mass = 1,
	length = -1,
	time = -1,
	...
};
```

[↲ constants](#constants)

---

### `DYNE`

[`⌕ ../si/units.ha:489`](../si/units.ha#L489)

The dyne is a CGS unit used in mechanics and fluid dynamics to express force. See [`NEWTON`](#newton).

```hare
def DYNE = unit {
	dim = FORCE,
	scale = 1.0e-5,
};
```

[↲ constants](#constants)

---

### `ELECTRIC_CHARGE`

[`⌕ ../si/dimensions.ha:92`](../si/dimensions.ha#L92)

The SI derived dimension of electric charge. Its SI unit is [`COULOMB`](#coulomb).

```hare
def ELECTRIC_CHARGE = dimension {
	time = 1,
	current = 1,
	...
};
```

[↲ constants](#constants)

---

### `ELECTRIC_POTENTIAL`

[`⌕ ../si/dimensions.ha:96`](../si/dimensions.ha#L96)

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

[↲ constants](#constants)

---

### `ELECTRONVOLT`

[`⌕ ../si/units.ha:442`](../si/units.ha#L442)

The electronvolt

```hare
def ELECTRONVOLT = unit {
	dim = ENERGY,
	scale = 1.602176634e-19,
};
```

[↲ constants](#constants)

---

### `ELEMENTARY_CHARGE`

[`⌕ ../si/constants.ha:29`](../si/constants.ha#L29)

The elementary charge, an exact defining constant of the SI corresponding to the magnitude of the electric charge of a proton. Its SI unit is [`COULOMB`](#coulomb).

```hare
def ELEMENTARY_CHARGE = quantity {
	unit = COULOMB,
	value = 1.602176634e-19,
};
```

[↲ constants](#constants)

---

### `ENERGY`

[`⌕ ../si/dimensions.ha:106`](../si/dimensions.ha#L106)

The SI derived dimension of energy. Its SI unit is [`JOULE`](#joule).

```hare
def ENERGY = dimension {
	mass = 1,
	length = 2,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `ERG`

[`⌕ ../si/units.ha:494`](../si/units.ha#L494)

The erg is a CGS unit commonly used in classical mechanics, astrophysics, and other areas of physics to express energy. The SI counterpart unit is the [`JOULE`](#joule).

```hare
def ERG = unit {
	dim = ENERGY,
	scale = 1.0e-7,
};
```

[↲ constants](#constants)

---

### `EXPOSURE`

[`⌕ ../si/dimensions.ha:110`](../si/dimensions.ha#L110)

The SI derived dimension of exposure to ionising radiation. Its SI unit is [`COULOMB_PER_KILOGRAM`](#coulomb_per_kilogram).

```hare
def EXPOSURE = dimension {
	mass = -1,
	time = 1,
	current = 1,
	...
};
```

[↲ constants](#constants)

---

### `FORCE`

[`⌕ ../si/dimensions.ha:114`](../si/dimensions.ha#L114)

The SI derived dimension of force. Its SI unit is [`NEWTON`](#newton).

```hare
def FORCE = dimension {
	mass = 1,
	length = 1,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `FREQUENCY`

[`⌕ ../si/dimensions.ha:40`](../si/dimensions.ha#L40)

The SI derived dimension of frequency. Its SI unit is [`HERTZ`](#hertz).

```hare
def FREQUENCY = dimension {
	time = -1,
	...
};
```

[↲ constants](#constants)

---

### `GAL`

[`⌕ ../si/units.ha:499`](../si/units.ha#L499)

The gal is a CGS unit commonly used in geophysics and gravimetry to express acceleration. The SI counterpart unit is the [`METRE_PER_SECOND_SQUARED`](#metre_per_second_squared)

```hare
def GAL = unit {
	dim = ACCELERATION,
	scale = 0.01,
};
```

[↲ constants](#constants)

---

### `GAUSS`

[`⌕ ../si/units.ha:504`](../si/units.ha#L504)

The gauss is a CGS unit commonly used in physics and engineering to express magnetic flux density. The SI counterpart unit is the [`TESLA`](#tesla)

```hare
def GAUSS = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-4,
};
```

[↲ constants](#constants)

---

### `GIGAHERTZ`

[`⌕ ../si/units.ha:729`](../si/units.ha#L729)

The gigahertz is a scaled SI unit of frequency. The corresponding unscaled SI unit is the [`HERTZ`](#hertz).

```hare
def GIGAHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e9,
};
```

[↲ constants](#constants)

---

### `GIGAJOULE`

[`⌕ ../si/units.ha:697`](../si/units.ha#L697)

The gigajoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def GIGAJOULE = unit {
	dim = ENERGY,
	scale = 1.0e9,
};
```

[↲ constants](#constants)

---

### `GIGAPASCAL`

[`⌕ ../si/units.ha:665`](../si/units.ha#L665)

The gigapascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def GIGAPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e9,
};
```

[↲ constants](#constants)

---

### `GIGAWATT`

[`⌕ ../si/units.ha:717`](../si/units.ha#L717)

The gigawatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def GIGAWATT = unit {
	dim = POWER,
	scale = 1.0e9,
};
```

[↲ constants](#constants)

---

### `GRAM`

[`⌕ ../si/units.ha:565`](../si/units.ha#L565)

The gram is a scaled SI unit of mass. The corresponding unscaled SI unit is the [`KILOGRAM`](#kilogram).

```hare
def GRAM = unit {
	dim = MASS,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `HECTARE`

[`⌕ ../si/units.ha:508`](../si/units.ha#L508)

The hectare is non-SI metric unit commonly used to express areas of land. The SI counterpart unit is the [`SQUARE_METRE`](#square_metre)

```hare
def HECTARE = unit {
	dim = AREA,
	scale = 1.0e4,
};
```

[↲ constants](#constants)

---

### `HECTOMETRE`

[`⌕ ../si/units.ha:633`](../si/units.ha#L633)

The hectometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def HECTOMETRE = unit {
	dim = LENGTH,
	scale = 100.0,
};
```

[↲ constants](#constants)

---

### `HECTOPASCAL`

[`⌕ ../si/units.ha:669`](../si/units.ha#L669)

The hectopascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def HECTOPASCAL = unit {
	dim = PRESSURE,
	scale = 100.0,
};
```

[↲ constants](#constants)

---

### `HOUR`

[`⌕ ../si/units.ha:512`](../si/units.ha#L512)

The hour is non-SI unit of time. The SI counterpart unit is the [`SECOND`](#second)

```hare
def HOUR = unit {
	dim = TIME,
	scale = 3600.0,
};
```

[↲ constants](#constants)

---

### `HYPERFINE_TRANSITION_CAESIUM_133`

[`⌕ ../si/constants.ha:42`](../si/constants.ha#L42)

The caesium-133 hyperfine transition frequency, which defines the SI second. Its SI unit is [`HERTZ`](#hertz).

```hare
def HYPERFINE_TRANSITION_CAESIUM_133 = quantity {
	unit = HERTZ,
	value = 9192631770.0,
};
```

[↲ constants](#constants)

---

### `ILLUMINANCE`

[`⌕ ../si/dimensions.ha:118`](../si/dimensions.ha#L118)

The SI derived dimension of illuminance. Its SI unit is [`LUX`](#lux).

```hare
def ILLUMINANCE = dimension {
	length = -2,
	luminosity = 1,
	...
};
```

[↲ constants](#constants)

---

### `INDUCTANCE`

[`⌕ ../si/dimensions.ha:136`](../si/dimensions.ha#L136)

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

[↲ constants](#constants)

---

### `JOULE_PER_KELVIN`

[`⌕ ../si/units.ha:855`](../si/units.ha#L855)

The joule per kelvin is the coherent SI unit of [`ENTROPY`](#entropy).

```hare
def JOULE_PER_KELVIN = unit {
	dim = ENTROPY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `JOULE_SECOND`

[`⌕ ../si/units.ha:858`](../si/units.ha#L858)

The joule-second is the coherent SI unit of [`ACTION`](#action).

```hare
def JOULE_SECOND = unit {
	dim = ACTION,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `KILOGRAM_PER_CUBIC_METRE`

[`⌕ ../si/units.ha:801`](../si/units.ha#L801)

The kilogram per cubic metre is the SI unit for [`DENSITY`](#density).

```hare
def KILOGRAM_PER_CUBIC_METRE = unit {
	dim = DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `KILOHERTZ`

[`⌕ ../si/units.ha:721`](../si/units.ha#L721)

The kilohertz is a scaled SI unit of frequency. The corresponding unscaled SI unit is the [`HERTZ`](#hertz).

```hare
def KILOHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILOJOULE`

[`⌕ ../si/units.ha:689`](../si/units.ha#L689)

The kilojoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def KILOJOULE = unit {
	dim = ENERGY,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILOMETRE`

[`⌕ ../si/units.ha:569`](../si/units.ha#L569)

The kilometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def KILOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILONEWTON`

[`⌕ ../si/units.ha:677`](../si/units.ha#L677)

The kilonewton is a scaled SI unit of force. The corresponding unscaled SI unit is the [`NEWTON`](#newton).

```hare
def KILONEWTON = unit {
	dim = FORCE,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILOOHM`

[`⌕ ../si/units.ha:749`](../si/units.ha#L749)

The kiloohm is a scaled SI unit of electrical resistance. The corresponding unscaled SI unit is the [`OHM`](#ohm).

```hare
def KILOOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILOPASCAL`

[`⌕ ../si/units.ha:657`](../si/units.ha#L657)

The kilopascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def KILOPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILOVOLT`

[`⌕ ../si/units.ha:745`](../si/units.ha#L745)

The kilovolt is a scaled SI unit of electric potential. The corresponding unscaled SI unit is the [`VOLT`](#volt).

```hare
def KILOVOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KILOWATT`

[`⌕ ../si/units.ha:709`](../si/units.ha#L709)

The kilowatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def KILOWATT = unit {
	dim = POWER,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `KINEMATIC_VISCOSITY`

[`⌕ ../si/dimensions.ha:236`](../si/dimensions.ha#L236)

The SI derived dimension of kinematic viscosity. Its SI unit is [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second).

```hare
def KINEMATIC_VISCOSITY = dimension {
	length = 2,
	time = -1,
	...
};
```

[↲ constants](#constants)

---

### `LENGTH`

[`⌕ ../si/dimensions.ha:14`](../si/dimensions.ha#L14)

The SI base dimension of length.

```hare
def LENGTH = dimension {
	length = 1,
	...
};
```

[↲ constants](#constants)

---

### `LITRE`

[`⌕ ../si/units.ha:446`](../si/units.ha#L446)

The litre is a non-SI metric unit of volume in common general use. See [`CUBIC_METRE`](#cubic_metre).

```hare
def LITRE = unit {
	dim = VOLUME,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `LUMINOSITY`

[`⌕ ../si/dimensions.ha:29`](../si/dimensions.ha#L29)

The SI base dimension of luminous intensity.

```hare
def LUMINOSITY = dimension {
	luminosity = 1,
	...
};
```

[↲ constants](#constants)

---

### `LUMINOUS_EFFICACY_540_THZ`

[`⌕ ../si/constants.ha:49`](../si/constants.ha#L49)

The luminous efficacy of monochromatic radiation at 540 THz, an exact defining constant of the SI for [`LUMINOUS_EFFICACY`](#luminous_efficacy). Its SI unit is [`LUMEN_PER_WATT`](#lumen_per_watt).

```hare
def LUMINOUS_EFFICACY_540_THZ = quantity {
	unit = LUMEN_PER_WATT,
	value = 683.0,
};
```

[↲ constants](#constants)

---

### `LUMINOUS_FLUX`

[`⌕ ../si/dimensions.ha:146`](../si/dimensions.ha#L146)

The SI derived dimension of luminous flux. Its SI unit is [`LUMEN`](#lumen).

```hare
def LUMINOUS_FLUX = dimension {
	luminosity = 1,
	...
};
```

[↲ constants](#constants)

---

### `MAGNETIC_FLUX`

[`⌕ ../si/dimensions.ha:150`](../si/dimensions.ha#L150)

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

[↲ constants](#constants)

---

### `MAGNETIC_FLUX_DENSITY`

[`⌕ ../si/dimensions.ha:160`](../si/dimensions.ha#L160)

The SI derived dimension of magnetic flux density. Its SI unit is [`TESLA`](#tesla).

```hare
def MAGNETIC_FLUX_DENSITY = dimension {
	mass = 1,
	time = -2,
	current = -1,
	...
};
```

[↲ constants](#constants)

---

### `MASS`

[`⌕ ../si/dimensions.ha:11`](../si/dimensions.ha#L11)

The SI base dimension of mass.

```hare
def MASS = dimension {
	mass = 1,
	...
};
```

[↲ constants](#constants)

---

### `MAXWELL`

[`⌕ ../si/units.ha:516`](../si/units.ha#L516)

The maxwell is a CGS electromagnetic unit used to express magnetic flux. The SI counterpart unit is the [`WEBER`](#weber)

```hare
def MAXWELL = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0e-8,
};
```

[↲ constants](#constants)

---

### `MEGAHERTZ`

[`⌕ ../si/units.ha:725`](../si/units.ha#L725)

The megahertz is a scaled SI unit of frequency. The corresponding unscaled SI unit is the [`HERTZ`](#hertz).

```hare
def MEGAHERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `MEGAJOULE`

[`⌕ ../si/units.ha:693`](../si/units.ha#L693)

The megajoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def MEGAJOULE = unit {
	dim = ENERGY,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `MEGANEWTON`

[`⌕ ../si/units.ha:681`](../si/units.ha#L681)

The meganewton is a scaled SI unit of force. The corresponding unscaled SI unit is the [`NEWTON`](#newton).

```hare
def MEGANEWTON = unit {
	dim = FORCE,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `MEGAOHM`

[`⌕ ../si/units.ha:753`](../si/units.ha#L753)

The megaohm is a scaled SI unit of electrical resistance. The corresponding unscaled SI unit is the [`OHM`](#ohm).

```hare
def MEGAOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `MEGAPASCAL`

[`⌕ ../si/units.ha:661`](../si/units.ha#L661)

The megapascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def MEGAPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `MEGAWATT`

[`⌕ ../si/units.ha:713`](../si/units.ha#L713)

The megawatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def MEGAWATT = unit {
	dim = POWER,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `MICROAMPERE`

[`⌕ ../si/units.ha:600`](../si/units.ha#L600)

The microampere is a scaled SI unit of electric current. The corresponding unscaled SI unit is the [`AMPERE`](#ampere).

```hare
def MICROAMPERE = unit {
	dim = CURRENT,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MICROCOULOMB`

[`⌕ ../si/units.ha:737`](../si/units.ha#L737)

The microcoulomb is a scaled SI unit of electric charge. The corresponding unscaled SI unit is the [`COULOMB`](#coulomb).

```hare
def MICROCOULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MICROFARAD`

[`⌕ ../si/units.ha:761`](../si/units.ha#L761)

The microfarad is a scaled SI unit of capacitance. The corresponding unscaled SI unit is the [`FARAD`](#farad).

```hare
def MICROFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MICROGRAM`

[`⌕ ../si/units.ha:621`](../si/units.ha#L621)

The microgram is a scaled SI unit of mass. The corresponding unscaled SI unit is the [`KILOGRAM`](#kilogram).

```hare
def MICROGRAM = unit {
	dim = MASS,
	scale = 1.0e-9,
};
```

[↲ constants](#constants)

---

### `MICROMETRE`

[`⌕ ../si/units.ha:581`](../si/units.ha#L581)

The micrometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def MICROMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MICRON`

[`⌕ ../si/units.ha:584`](../si/units.ha#L584)

The micron is an alternative name for the [`MICROMETRE`](#micrometre).

```hare
def MICRON = MICROMETRE;
```

[↲ constants](#constants)

---

### `MICROSECOND`

[`⌕ ../si/units.ha:608`](../si/units.ha#L608)

The microsecond is a scaled SI unit of time. The corresponding unscaled SI unit is the [`SECOND`](#second).

```hare
def MICROSECOND = unit {
	dim = TIME,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MICROTESLA`

[`⌕ ../si/units.ha:777`](../si/units.ha#L777)

The microtesla is a scaled SI unit of magnetic flux density. The corresponding unscaled SI unit is the [`TESLA`](#tesla).

```hare
def MICROTESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MILLIAMPERE`

[`⌕ ../si/units.ha:596`](../si/units.ha#L596)

The milliampere is a scaled SI unit of electric current. The corresponding unscaled SI unit is the [`AMPERE`](#ampere).

```hare
def MILLIAMPERE = unit {
	dim = CURRENT,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLICOULOMB`

[`⌕ ../si/units.ha:733`](../si/units.ha#L733)

The millicoulomb is a scaled SI unit of electric charge. The corresponding unscaled SI unit is the [`COULOMB`](#coulomb).

```hare
def MILLICOULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIGRAM`

[`⌕ ../si/units.ha:617`](../si/units.ha#L617)

The milligram is a scaled SI unit of mass. The corresponding unscaled SI unit is the [`KILOGRAM`](#kilogram).

```hare
def MILLIGRAM = unit {
	dim = MASS,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `MILLIJOULE`

[`⌕ ../si/units.ha:701`](../si/units.ha#L701)

The millijoule is a scaled SI unit of energy. The corresponding unscaled SI unit is the [`JOULE`](#joule).

```hare
def MILLIJOULE = unit {
	dim = ENERGY,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIMETRE`

[`⌕ ../si/units.ha:577`](../si/units.ha#L577)

The millimetre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def MILLIMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIMETRES_OF_MERCURY`

[`⌕ ../si/units.ha:525`](../si/units.ha#L525)

Millimetres of mercury are widely used in medicine and meteorology to express pressure. The SI counterpart unit is the [`PASCAL`](#pascal)

```hare
def MILLIMETRES_OF_MERCURY = unit {
	dim = PRESSURE,
	scale = 133.322,
};
```

[↲ constants](#constants)

---

### `MILLINEWTON`

[`⌕ ../si/units.ha:685`](../si/units.ha#L685)

The millinewton is a scaled SI unit of force. The corresponding unscaled SI unit is the [`NEWTON`](#newton).

```hare
def MILLINEWTON = unit {
	dim = FORCE,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIOHM`

[`⌕ ../si/units.ha:757`](../si/units.ha#L757)

The milliohm is a scaled SI unit of electrical resistance. The corresponding unscaled SI unit is the [`OHM`](#ohm).

```hare
def MILLIOHM = unit {
	dim = RESISTANCE,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIPASCAL`

[`⌕ ../si/units.ha:673`](../si/units.ha#L673)

The millipascal is a scaled SI unit of pressure. The corresponding unscaled SI unit is the [`PASCAL`](#pascal).

```hare
def MILLIPASCAL = unit {
	dim = PRESSURE,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIPASCAL_SECOND`

[`⌕ ../si/units.ha:785`](../si/units.ha#L785)

The millipascal-second is a scaled SI unit of dynamic viscosity. The corresponding unscaled SI unit is the [`PASCAL_SECOND`](#pascal_second).

```hare
def MILLIPASCAL_SECOND = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLISECOND`

[`⌕ ../si/units.ha:604`](../si/units.ha#L604)

The millisecond is a scaled SI unit of time. The corresponding unscaled SI unit is the [`SECOND`](#second).

```hare
def MILLISECOND = unit {
	dim = TIME,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLITESLA`

[`⌕ ../si/units.ha:773`](../si/units.ha#L773)

The millitesla is a scaled SI unit of magnetic flux density. The corresponding unscaled SI unit is the [`TESLA`](#tesla).

```hare
def MILLITESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIVOLT`

[`⌕ ../si/units.ha:741`](../si/units.ha#L741)

The millivolt is a scaled SI unit of electric potential. The corresponding unscaled SI unit is the [`VOLT`](#volt).

```hare
def MILLIVOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIWATT`

[`⌕ ../si/units.ha:705`](../si/units.ha#L705)

The milliwatt is a scaled SI unit of power. The corresponding unscaled SI unit is the [`WATT`](#watt).

```hare
def MILLIWATT = unit {
	dim = POWER,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MILLIWEBER`

[`⌕ ../si/units.ha:781`](../si/units.ha#L781)

The milliweber is a scaled SI unit of magnetic flux. The corresponding unscaled SI unit is the [`WEBER`](#weber).

```hare
def MILLIWEBER = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0e-3,
};
```

[↲ constants](#constants)

---

### `MINUTE`

[`⌕ ../si/units.ha:520`](../si/units.ha#L520)

The minute is non-SI unit of time. The SI counterpart unit is the [`SECOND`](#second)

```hare
def MINUTE = unit {
	dim = TIME,
	scale = 60.0,
};
```

[↲ constants](#constants)

---

### `NANOFARAD`

[`⌕ ../si/units.ha:765`](../si/units.ha#L765)

The nanofarad is a scaled SI unit of capacitance. The corresponding unscaled SI unit is the [`FARAD`](#farad).

```hare
def NANOFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-9,
};
```

[↲ constants](#constants)

---

### `NANOMETRE`

[`⌕ ../si/units.ha:588`](../si/units.ha#L588)

The nanometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def NANOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-9,
};
```

[↲ constants](#constants)

---

### `NANOSECOND`

[`⌕ ../si/units.ha:612`](../si/units.ha#L612)

The nanosecond is a scaled SI unit of time. The corresponding unscaled SI unit is the [`SECOND`](#second).

```hare
def NANOSECOND = unit {
	dim = TIME,
	scale = 1.0e-9,
};
```

[↲ constants](#constants)

---

### `NEPER`

[`⌕ ../si/units.ha:453`](../si/units.ha#L453)

The neper is a non-SI relative logarithmic unit used in acoustics, telecommunications, and signal processing to express ratios of field quantities. This unit is dimensionless and does not support conversion. See also: [`BEL`](#bel).

```hare
def NEPER = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `NEWTON_METRE`

[`⌕ ../si/units.ha:846`](../si/units.ha#L846)

The newton-metre is the coherent SI unit of [`TORQUE`](#torque).

```hare
def NEWTON_METRE = unit {
	dim = TORQUE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `NEWTON_PER_METRE`

[`⌕ ../si/units.ha:849`](../si/units.ha#L849)

The newton per metre is the coherent SI unit of [`SURFACE_TENSION`](#surface_tension).

```hare
def NEWTON_PER_METRE = unit {
	dim = SURFACE_TENSION,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `OERSTED`

[`⌕ ../si/units.ha:530`](../si/units.ha#L530)

The oersted is a CGS electromagnetic unit used to express magnetic field strength. The SI counterpart unit is the [`HENRY`](#henry).

```hare
def OERSTED = unit {
	dim = MAGNETIC_FIELD_STRENGTH,
	scale = 79.57747155,
};
```

[↲ constants](#constants)

---

### `PASCAL_SECOND`

[`⌕ ../si/units.ha:843`](../si/units.ha#L843)

The pascal-second is the coherent SI unit of [`DYNAMIC_VISCOSITY`](#dynamic_viscosity).

```hare
def PASCAL_SECOND = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `PICOFARAD`

[`⌕ ../si/units.ha:769`](../si/units.ha#L769)

The picofarad is a scaled SI unit of capacitance. The corresponding unscaled SI unit is the [`FARAD`](#farad).

```hare
def PICOFARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0e-12,
};
```

[↲ constants](#constants)

---

### `PICOMETRE`

[`⌕ ../si/units.ha:592`](../si/units.ha#L592)

The picometre is a scaled SI unit of length. The corresponding unscaled SI unit is the [`METRE`](#metre).

```hare
def PICOMETRE = unit {
	dim = LENGTH,
	scale = 1.0e-12,
};
```

[↲ constants](#constants)

---

### `PLANCK`

[`⌕ ../si/constants.ha:22`](../si/constants.ha#L22)

The Planck constant, an exact defining constant of the SI relating the energy of a photon to its frequency. Its SI unit is [`JOULE_SECOND`](#joule_second).

```hare
def PLANCK = quantity {
	unit = JOULE_SECOND,
	value = 6.62607015e-34,
};
```

[↲ constants](#constants)

---

### `POISE`

[`⌕ ../si/units.ha:536`](../si/units.ha#L536)

The poise is a CGS unit commonly used in rheology and fluid mechanics to express dynamic viscosity.

```hare
def POISE = unit {
	dim = DYNAMIC_VISCOSITY,
	scale = 0.1,
};
```

[↲ constants](#constants)

---

### `POWER`

[`⌕ ../si/dimensions.ha:169`](../si/dimensions.ha#L169)

The SI derived dimension of power. Its SI unit is [`WATT`](#watt).

```hare
def POWER = dimension {
	mass = 1,
	length = 2,
	time = -3,
	...
};
```

[↲ constants](#constants)

---

### `PRESSURE`

[`⌕ ../si/dimensions.ha:173`](../si/dimensions.ha#L173)

The SI derived dimension of pressure. Its SI unit is [`PASCAL`](#pascal).

```hare
def PRESSURE = dimension {
	mass = 1,
	length = -1,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `RAD`

[`⌕ ../si/units.ha:546`](../si/units.ha#L546)

The rad is a non-SI unit historically used in radiobiology and radiation dosimetry to express absorbed dose. The SI counterpart unit is the [`GRAY`](#gray).

```hare
def RAD = unit {
	dim = ABSORBED_DOSE,
	scale = 0.01,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_CUBIC_METRE`

[`⌕ ../si/units.ha:820`](../si/units.ha#L820)

The reciprocal cubic metre is the coherent SI unit of [`SPATIAL_FREQUENCY_3D`](#spatial_frequency_3d).

```hare
def RECIPROCAL_CUBIC_METRE = unit {
	dim = SPATIAL_FREQUENCY_3D,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_CURRENT`

[`⌕ ../si/dimensions.ha:43`](../si/dimensions.ha#L43)

The reciprocal of the SI base dimension of electric current.

```hare
def RECIPROCAL_CURRENT = dimension {
	current = -1,
	...
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_LENGTH`

[`⌕ ../si/dimensions.ha:35`](../si/dimensions.ha#L35)

The reciprocal of the SI base dimension of mass.

```hare
def RECIPROCAL_LENGTH = dimension {
	length = -1,
	...
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_LUMINOSITY`

[`⌕ ../si/dimensions.ha:52`](../si/dimensions.ha#L52)

The reciprocal of the SI base dimension of luminous intensity.

```hare
def RECIPROCAL_LUMINOSITY = dimension {
	luminosity = -1,
	...
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_MASS`

[`⌕ ../si/dimensions.ha:32`](../si/dimensions.ha#L32)

The reciprocal of the SI base dimension of mass.

```hare
def RECIPROCAL_MASS = dimension {
	mass = -1,
	...
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_SQUARE_METRE`

[`⌕ ../si/units.ha:813`](../si/units.ha#L813)

The reciprocal square metre is the coherent SI unit of [`SPATIAL_FREQUENCY_2D`](#spatial_frequency_2d).

```hare
def RECIPROCAL_SQUARE_METRE = unit {
	dim = SPATIAL_FREQUENCY_2D,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_SUBSTANCE`

[`⌕ ../si/dimensions.ha:49`](../si/dimensions.ha#L49)

The reciprocal of the SI base dimension of amount of substance.

```hare
def RECIPROCAL_SUBSTANCE = dimension {
	substance = -1,
	...
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_TEMPERATURE`

[`⌕ ../si/dimensions.ha:46`](../si/dimensions.ha#L46)

The reciprocal of the SI base dimension of thermodynamic temperature.

```hare
def RECIPROCAL_TEMPERATURE = dimension {
	temperature = -1,
	...
};
```

[↲ constants](#constants)

---

### `REM`

[`⌕ ../si/units.ha:551`](../si/units.ha#L551)

The rem (or Roentgen equivalent man) is a non-SI unit historically used in radiation protection to express equivalent dose. The SI counterpart unit is the [`SIEVERT`](#sievert).

```hare
def REM = unit {
	dim = DOSE_EQUIVALENT,
	scale = 0.01,
};
```

[↲ constants](#constants)

---

### `RESISTANCE`

[`⌕ ../si/dimensions.ha:177`](../si/dimensions.ha#L177)

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

[↲ constants](#constants)

---

### `ROENTGEN`

[`⌕ ../si/units.ha:541`](../si/units.ha#L541)

The roentgen is a non-SI unit historically used in radiology and radiation protection to express [`EXPOSURE`](#exposure). The SI counterpart unit is the [`COULOMB_PER_KILOGRAM`](#coulomb_per_kilogram).

```hare
def ROENTGEN = unit {
	dim = EXPOSURE,
	scale = 2.58e-4,
};
```

[↲ constants](#constants)

---

### `SPATIAL_FREQUENCY_1D`

[`⌕ ../si/dimensions.ha:124`](../si/dimensions.ha#L124)

Alias for [`RECIPROCAL_LENGTH`](#reciprocal_length).

```hare
def SPATIAL_FREQUENCY_1D = RECIPROCAL_LENGTH;
```

[↲ constants](#constants)

---

### `SPATIAL_FREQUENCY_2D`

[`⌕ ../si/dimensions.ha:128`](../si/dimensions.ha#L128)

The SI derived dimension of two-dimensional spatial frequency. Its SI unit is [`RECIPROCAL_SQUARE_METRE`](#reciprocal_square_metre).

```hare
def SPATIAL_FREQUENCY_2D = dimension {
	length = -2,
	...
};
```

[↲ constants](#constants)

---

### `SPATIAL_FREQUENCY_3D`

[`⌕ ../si/dimensions.ha:132`](../si/dimensions.ha#L132)

The SI derived dimension of three-dimensional spatial frequency. Its SI unit is [`RECIPROCAL_CUBIC_METRE`](#reciprocal_cubic_metre).

```hare
def SPATIAL_FREQUENCY_3D = dimension {
	length = -3,
	...
};
```

[↲ constants](#constants)

---

### `SPEED_OF_LIGHT`

[`⌕ ../si/constants.ha:8`](../si/constants.ha#L8)

The speed of light in vacuum, an exact defining constant of the SI. Its SI unit is [`METRE_PER_SECOND`](#metre_per_second).

```hare
def SPEED_OF_LIGHT = quantity {
	unit = METRE_PER_SECOND,
	value = 299792458.0,
};
```

[↲ constants](#constants)

---

### `SQUARE_CENTIMETRE`

[`⌕ ../si/units.ha:641`](../si/units.ha#L641)

The square centimetre is a scaled SI unit of area. The corresponding unscaled SI unit is the [`SQUARE_METRE`](#square_metre).

```hare
def SQUARE_CENTIMETRE = unit {
	dim = AREA,
	scale = 1.0e-4,
};
```

[↲ constants](#constants)

---

### `SQUARE_KILOMETRE`

[`⌕ ../si/units.ha:637`](../si/units.ha#L637)

The square kilometre is a scaled SI unit of area. The corresponding unscaled SI unit is the [`SQUARE_METRE`](#square_metre).

```hare
def SQUARE_KILOMETRE = unit {
	dim = AREA,
	scale = 1.0e6,
};
```

[↲ constants](#constants)

---

### `SQUARE_METRE`

[`⌕ ../si/units.ha:809`](../si/units.ha#L809)

The reciprocal metre is the coherent SI unit of [`RECIPROCAL_LENGTH`](#reciprocal_length).

```hare
def SQUARE_METRE = unit {
	dim = AREA,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `SQUARE_METRE_PER_SECOND`

[`⌕ ../si/units.ha:852`](../si/units.ha#L852)

The square metre per second is the coherent SI unit of [`KINEMATIC_VISCOSITY`](#kinematic_viscosity).

```hare
def SQUARE_METRE_PER_SECOND = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `SQUARE_MILLIMETRE`

[`⌕ ../si/units.ha:645`](../si/units.ha#L645)

The square millimetre is a scaled SI unit of area. The corresponding unscaled SI unit is the [`SQUARE_METRE`](#square_metre).

```hare
def SQUARE_MILLIMETRE = unit {
	dim = AREA,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `SQUARE_MILLIMETRE_PER_SECOND`

[`⌕ ../si/units.ha:789`](../si/units.ha#L789)

The square millimetre per second is a scaled SI unit of kinematic viscosity. The corresponding unscaled SI unit is the [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second).

```hare
def SQUARE_MILLIMETRE_PER_SECOND = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0e-6,
};
```

[↲ constants](#constants)

---

### `STOKES`

[`⌕ ../si/units.ha:556`](../si/units.ha#L556)

The stokes is a CGS unit commonly used in fluid mechanics to express viscosity. The SI counterpart unit is the [`SQUARE_METRE_PER_SECOND`](#square_metre_per_second).

```hare
def STOKES = unit {
	dim = KINEMATIC_VISCOSITY,
	scale = 1.0e-4,
};
```

[↲ constants](#constants)

---

### `SUBSTANCE`

[`⌕ ../si/dimensions.ha:26`](../si/dimensions.ha#L26)

The SI base dimension of amount of substance.

```hare
def SUBSTANCE = dimension {
	substance = 1,
	...
};
```

[↲ constants](#constants)

---

### `TEMPERATURE`

[`⌕ ../si/dimensions.ha:23`](../si/dimensions.ha#L23)

The SI base dimension of thermodynamic temperature.

```hare
def TEMPERATURE = dimension {
	temperature = 1,
	...
};
```

[↲ constants](#constants)

---

### `TIME`

[`⌕ ../si/dimensions.ha:17`](../si/dimensions.ha#L17)

The SI base dimension of time.

```hare
def TIME = dimension {
	time = 1,
	...
};
```

[↲ constants](#constants)

---

### `TONNE`

[`⌕ ../si/units.ha:458`](../si/units.ha#L458)

The tonne is a non-SI metric unit of mass still in common general use. Not to be confused with the ton units used in Imperial or Customary systems. See [`KILOGRAM`](#kilogram).

```hare
def TONNE = unit {
	dim = MASS,
	scale = 1.0e3,
};
```

[↲ constants](#constants)

---

### `TORR`

[`⌕ ../si/units.ha:560`](../si/units.ha#L560)

The torr is non-SI unit historically used in physics. The SI counterpart unit is the [`PASCAL`](#pascal).

```hare
def TORR = unit {
	dim = PRESSURE,
	scale = 133.322368421,
};
```

[↲ constants](#constants)

---

### `WAVENUMBER`

[`⌕ ../si/dimensions.ha:121`](../si/dimensions.ha#L121)

Alias for [`RECIPROCAL_LENGTH`](#reciprocal_length).

```hare
def WAVENUMBER = RECIPROCAL_LENGTH;
```

[↲ constants](#constants)

---

### `ACCELERATION`

[`⌕ ../si/dimensions.ha:187`](../si/dimensions.ha#L187)

```hare
def ACCELERATION = dimension {
	length = 1,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `ACTION`

[`⌕ ../si/dimensions.ha:188`](../si/dimensions.ha#L188)

```hare
def ACTION = dimension {
	mass = 1,
	length = 2,
	time = -1,
	...
};
```

[↲ constants](#constants)

---

### `AMPERE`

[`⌕ ../si/units.ha:380`](../si/units.ha#L380)

```hare
def AMPERE = unit {
	dim = CURRENT,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `AMPERE_PER_METRE`

[`⌕ ../si/units.ha:794`](../si/units.ha#L794)

```hare
def AMPERE_PER_METRE = unit {
	dim = MAGNETIC_FIELD_STRENGTH,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `AMPERE_PER_SQUARE_METRE`

[`⌕ ../si/units.ha:795`](../si/units.ha#L795)

```hare
def AMPERE_PER_SQUARE_METRE = unit {
	dim = CURRENT_DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `AREA`

[`⌕ ../si/dimensions.ha:189`](../si/dimensions.ha#L189)

```hare
def AREA = dimension {
	length = 2,
	...
};
```

[↲ constants](#constants)

---

### `ATTO`

[`⌕ ../si/prefix.ha:24`](../si/prefix.ha#L24)

```hare
def ATTO: f64 = 1.0e-18;
```

[↲ constants](#constants)

---

### `BECQUEREL`

[`⌕ ../si/units.ha:400`](../si/units.ha#L400)

```hare
def BECQUEREL = unit {
	dim = ACTIVITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `CANDELA`

[`⌕ ../si/units.ha:381`](../si/units.ha#L381)

```hare
def CANDELA = unit {
	dim = LUMINOSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `CANDELA_PER_SQUARE_METRE`

[`⌕ ../si/units.ha:796`](../si/units.ha#L796)

```hare
def CANDELA_PER_SQUARE_METRE = unit {
	dim = LUMINANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `CENTI`

[`⌕ ../si/prefix.ha:18`](../si/prefix.ha#L18)

```hare
def CENTI: f64 = 0.01;
```

[↲ constants](#constants)

---

### `CONCENTRATION`

[`⌕ ../si/dimensions.ha:191`](../si/dimensions.ha#L191)

```hare
def CONCENTRATION = dimension {
	substance = 1,
	length = -3,
	...
};
```

[↲ constants](#constants)

---

### `COULOMB`

[`⌕ ../si/units.ha:401`](../si/units.ha#L401)

```hare
def COULOMB = unit {
	dim = ELECTRIC_CHARGE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `COULOMB_PER_CUBIC_METRE`

[`⌕ ../si/units.ha:835`](../si/units.ha#L835)

```hare
def COULOMB_PER_CUBIC_METRE = unit {
	dim = VOLUME_CHARGE_DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `COULOMB_PER_KILOGRAM`

[`⌕ ../si/units.ha:840`](../si/units.ha#L840)

```hare
def COULOMB_PER_KILOGRAM = unit {
	dim = EXPOSURE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `COULOMB_PER_METRE`

[`⌕ ../si/units.ha:825`](../si/units.ha#L825)

```hare
def COULOMB_PER_METRE = unit {
	dim = LINEAR_CHARGE_DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `COULOMB_PER_SQUARE_METRE`

[`⌕ ../si/units.ha:830`](../si/units.ha#L830)

```hare
def COULOMB_PER_SQUARE_METRE = unit {
	dim = SURFACE_CHARGE_DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `CUBIC_METRE`

[`⌕ ../si/units.ha:797`](../si/units.ha#L797)

```hare
def CUBIC_METRE = unit {
	dim = VOLUME,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `CUBIC_METRE_PER_KILOGRAM`

[`⌕ ../si/units.ha:798`](../si/units.ha#L798)

```hare
def CUBIC_METRE_PER_KILOGRAM = unit {
	dim = SPECIFIC_VOLUME,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `CURRENT_DENSITY`

[`⌕ ../si/dimensions.ha:192`](../si/dimensions.ha#L192)

```hare
def CURRENT_DENSITY = dimension {
	current = 1,
	length = -2,
	...
};
```

[↲ constants](#constants)

---

### `DECA`

[`⌕ ../si/prefix.ha:15`](../si/prefix.ha#L15)

```hare
def DECA: f64 = 10.0;
```

[↲ constants](#constants)

---

### `DECI`

[`⌕ ../si/prefix.ha:17`](../si/prefix.ha#L17)

```hare
def DECI: f64 = 0.1;
```

[↲ constants](#constants)

---

### `DEGREE_CELSIUS`

[`⌕ ../si/units.ha:402`](../si/units.ha#L402)

```hare
def DEGREE_CELSIUS = unit {
	dim = TEMPERATURE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `DENSITY`

[`⌕ ../si/dimensions.ha:193`](../si/dimensions.ha#L193)

```hare
def DENSITY = dimension {
	mass = 1,
	length = -3,
	...
};
```

[↲ constants](#constants)

---

### `DIMENSIONLESS_UNIT`

[`⌕ ../si/units.ha:376`](../si/units.ha#L376)

```hare
def DIMENSIONLESS_UNIT = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `ENTROPY`

[`⌕ ../si/dimensions.ha:194`](../si/dimensions.ha#L194)

```hare
def ENTROPY = dimension {
	mass = 1,
	length = 2,
	time = -2,
	temperature = -1,
	...
};
```

[↲ constants](#constants)

---

### `EXA`

[`⌕ ../si/prefix.ha:8`](../si/prefix.ha#L8)

```hare
def EXA: f64 = 1.0e18;
```

[↲ constants](#constants)

---

### `FARAD`

[`⌕ ../si/units.ha:403`](../si/units.ha#L403)

```hare
def FARAD = unit {
	dim = CAPACITANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `FEMTO`

[`⌕ ../si/prefix.ha:23`](../si/prefix.ha#L23)

```hare
def FEMTO: f64 = 1.0e-15;
```

[↲ constants](#constants)

---

### `GIGA`

[`⌕ ../si/prefix.ha:11`](../si/prefix.ha#L11)

```hare
def GIGA: f64 = 1.0e9;
```

[↲ constants](#constants)

---

### `GRAY`

[`⌕ ../si/units.ha:404`](../si/units.ha#L404)

```hare
def GRAY = unit {
	dim = ABSORBED_DOSE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `HECTO`

[`⌕ ../si/prefix.ha:14`](../si/prefix.ha#L14)

```hare
def HECTO: f64 = 100.0;
```

[↲ constants](#constants)

---

### `HENRY`

[`⌕ ../si/units.ha:405`](../si/units.ha#L405)

```hare
def HENRY = unit {
	dim = INDUCTANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `HERTZ`

[`⌕ ../si/units.ha:396`](../si/units.ha#L396)

```hare
def HERTZ = unit {
	dim = FREQUENCY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `JOULE`

[`⌕ ../si/units.ha:406`](../si/units.ha#L406)

```hare
def JOULE = unit {
	dim = ENERGY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `KATAL`

[`⌕ ../si/units.ha:407`](../si/units.ha#L407)

```hare
def KATAL = unit {
	dim = CATALYTIC_ACTIVITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `KELVIN`

[`⌕ ../si/units.ha:382`](../si/units.ha#L382)

```hare
def KELVIN = unit {
	dim = TEMPERATURE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `KILO`

[`⌕ ../si/prefix.ha:13`](../si/prefix.ha#L13)

```hare
def KILO: f64 = 1.0e3;
```

[↲ constants](#constants)

---

### `KILOGRAM`

[`⌕ ../si/units.ha:383`](../si/units.ha#L383)

```hare
def KILOGRAM = unit {
	dim = MASS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `KILOGRAM_PER_SQUARE_METRE`

[`⌕ ../si/units.ha:802`](../si/units.ha#L802)

```hare
def KILOGRAM_PER_SQUARE_METRE = unit {
	dim = SURFACE_DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `LINEAR_CHARGE_DENSITY`

[`⌕ ../si/dimensions.ha:209`](../si/dimensions.ha#L209)

```hare
def LINEAR_CHARGE_DENSITY = dimension {
	length = -1,
	time = 1,
	current = 1,
	...
};
```

[↲ constants](#constants)

---

### `LUMEN`

[`⌕ ../si/units.ha:408`](../si/units.ha#L408)

```hare
def LUMEN = unit {
	dim = LUMINOUS_FLUX,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `LUMEN_PER_WATT`

[`⌕ ../si/units.ha:803`](../si/units.ha#L803)

```hare
def LUMEN_PER_WATT = unit {
	dim = LUMINOUS_EFFICACY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `LUMINANCE`

[`⌕ ../si/dimensions.ha:195`](../si/dimensions.ha#L195)

```hare
def LUMINANCE = dimension {
	luminosity = 1,
	length = -2,
	...
};
```

[↲ constants](#constants)

---

### `LUMINOUS_EFFICACY`

[`⌕ ../si/dimensions.ha:196`](../si/dimensions.ha#L196)

```hare
def LUMINOUS_EFFICACY = dimension {
	mass = -1,
	length = -2,
	time = 3,
	luminosity = 1,
	...
};
```

[↲ constants](#constants)

---

### `LUX`

[`⌕ ../si/units.ha:409`](../si/units.ha#L409)

```hare
def LUX = unit {
	dim = ILLUMINANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `MAGNETIC_FIELD_STRENGTH`

[`⌕ ../si/dimensions.ha:197`](../si/dimensions.ha#L197)

```hare
def MAGNETIC_FIELD_STRENGTH = dimension {
	current = 1,
	length = -1,
	...
};
```

[↲ constants](#constants)

---

### `MEGA`

[`⌕ ../si/prefix.ha:12`](../si/prefix.ha#L12)

```hare
def MEGA: f64 = 1.0e6;
```

[↲ constants](#constants)

---

### `METRE`

[`⌕ ../si/units.ha:384`](../si/units.ha#L384)

```hare
def METRE = unit {
	dim = LENGTH,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `METRE_PER_SECOND`

[`⌕ ../si/units.ha:804`](../si/units.ha#L804)

```hare
def METRE_PER_SECOND = unit {
	dim = VELOCITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `METRE_PER_SECOND_SQUARED`

[`⌕ ../si/units.ha:805`](../si/units.ha#L805)

```hare
def METRE_PER_SECOND_SQUARED = unit {
	dim = ACCELERATION,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `MICRO`

[`⌕ ../si/prefix.ha:20`](../si/prefix.ha#L20)

```hare
def MICRO: f64 = 1.0e-6;
```

[↲ constants](#constants)

---

### `MILLI`

[`⌕ ../si/prefix.ha:19`](../si/prefix.ha#L19)

```hare
def MILLI: f64 = 1.0e-3;
```

[↲ constants](#constants)

---

### `MOLE`

[`⌕ ../si/units.ha:385`](../si/units.ha#L385)

```hare
def MOLE = unit {
	dim = SUBSTANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `MOLE_PER_CUBIC_METRE`

[`⌕ ../si/units.ha:806`](../si/units.ha#L806)

```hare
def MOLE_PER_CUBIC_METRE = unit {
	dim = CONCENTRATION,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `NANO`

[`⌕ ../si/prefix.ha:21`](../si/prefix.ha#L21)

```hare
def NANO: f64 = 1.0e-9;
```

[↲ constants](#constants)

---

### `NEWTON`

[`⌕ ../si/units.ha:410`](../si/units.ha#L410)

```hare
def NEWTON = unit {
	dim = FORCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `NONE`

[`⌕ ../si/prefix.ha:16`](../si/prefix.ha#L16)

```hare
def NONE: f64 = 1.0;
```

[↲ constants](#constants)

---

### `OHM`

[`⌕ ../si/units.ha:411`](../si/units.ha#L411)

```hare
def OHM = unit {
	dim = RESISTANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `PASCAL`

[`⌕ ../si/units.ha:412`](../si/units.ha#L412)

```hare
def PASCAL = unit {
	dim = PRESSURE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `PETA`

[`⌕ ../si/prefix.ha:9`](../si/prefix.ha#L9)

```hare
def PETA: f64 = 1.0e15;
```

[↲ constants](#constants)

---

### `PICO`

[`⌕ ../si/prefix.ha:22`](../si/prefix.ha#L22)

```hare
def PICO: f64 = 1.0e-12;
```

[↲ constants](#constants)

---

### `QUECTO`

[`⌕ ../si/prefix.ha:28`](../si/prefix.ha#L28)

```hare
def QUECTO: f64 = 1.0e-30;
```

[↲ constants](#constants)

---

### `QUETTA`

[`⌕ ../si/prefix.ha:4`](../si/prefix.ha#L4)

```hare
def QUETTA: f64 = 1.0e30;
```

[↲ constants](#constants)

---

### `RADIAN`

[`⌕ ../si/units.ha:413`](../si/units.ha#L413)

```hare
def RADIAN = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_AMPERE`

[`⌕ ../si/units.ha:390`](../si/units.ha#L390)

```hare
def RECIPROCAL_AMPERE = unit {
	dim = RECIPROCAL_CURRENT,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_AREA`

[`⌕ ../si/dimensions.ha:190`](../si/dimensions.ha#L190)

```hare
def RECIPROCAL_AREA = dimension {
	length = -2,
	...
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_CANDELA`

[`⌕ ../si/units.ha:391`](../si/units.ha#L391)

```hare
def RECIPROCAL_CANDELA = unit {
	dim = RECIPROCAL_LUMINOSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_KELVIN`

[`⌕ ../si/units.ha:392`](../si/units.ha#L392)

```hare
def RECIPROCAL_KELVIN = unit {
	dim = RECIPROCAL_TEMPERATURE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_KILOGRAM`

[`⌕ ../si/units.ha:393`](../si/units.ha#L393)

```hare
def RECIPROCAL_KILOGRAM = unit {
	dim = RECIPROCAL_MASS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_METRE`

[`⌕ ../si/units.ha:394`](../si/units.ha#L394)

```hare
def RECIPROCAL_METRE = unit {
	dim = WAVENUMBER,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_MOLE`

[`⌕ ../si/units.ha:395`](../si/units.ha#L395)

```hare
def RECIPROCAL_MOLE = unit {
	dim = RECIPROCAL_SUBSTANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `RECIPROCAL_VOLUME`

[`⌕ ../si/dimensions.ha:207`](../si/dimensions.ha#L207)

```hare
def RECIPROCAL_VOLUME = dimension {
	length = -3,
	...
};
```

[↲ constants](#constants)

---

### `RONNA`

[`⌕ ../si/prefix.ha:5`](../si/prefix.ha#L5)

```hare
def RONNA: f64 = 1.0e27;
```

[↲ constants](#constants)

---

### `RONTO`

[`⌕ ../si/prefix.ha:27`](../si/prefix.ha#L27)

```hare
def RONTO: f64 = 1.0e-27;
```

[↲ constants](#constants)

---

### `SECOND`

[`⌕ ../si/units.ha:386`](../si/units.ha#L386)

```hare
def SECOND = unit {
	dim = TIME,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `SIEMENS`

[`⌕ ../si/units.ha:414`](../si/units.ha#L414)

```hare
def SIEMENS = unit {
	dim = CONDUCTANCE,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `SIEVERT`

[`⌕ ../si/units.ha:415`](../si/units.ha#L415)

```hare
def SIEVERT = unit {
	dim = DOSE_EQUIVALENT,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `SPECIFIC_VOLUME`

[`⌕ ../si/dimensions.ha:198`](../si/dimensions.ha#L198)

```hare
def SPECIFIC_VOLUME = dimension {
	mass = -1,
	length = 3,
	...
};
```

[↲ constants](#constants)

---

### `STERADIAN`

[`⌕ ../si/units.ha:416`](../si/units.ha#L416)

```hare
def STERADIAN = unit {
	dim = DIMENSIONLESS,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `SURFACE_CHARGE_DENSITY`

[`⌕ ../si/dimensions.ha:216`](../si/dimensions.ha#L216)

```hare
def SURFACE_CHARGE_DENSITY = dimension {
	length = -2,
	time = 1,
	current = 1,
	...
};
```

[↲ constants](#constants)

---

### `SURFACE_DENSITY`

[`⌕ ../si/dimensions.ha:199`](../si/dimensions.ha#L199)

```hare
def SURFACE_DENSITY = dimension {
	mass = 1,
	length = -2,
	...
};
```

[↲ constants](#constants)

---

### `SURFACE_TENSION`

[`⌕ ../si/dimensions.ha:203`](../si/dimensions.ha#L203)

```hare
def SURFACE_TENSION = dimension {
	mass = 1,
	length = 0,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `TERA`

[`⌕ ../si/prefix.ha:10`](../si/prefix.ha#L10)

```hare
def TERA: f64 = 1.0e12;
```

[↲ constants](#constants)

---

### `TESLA`

[`⌕ ../si/units.ha:417`](../si/units.ha#L417)

```hare
def TESLA = unit {
	dim = MAGNETIC_FLUX_DENSITY,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `TORQUE`

[`⌕ ../si/dimensions.ha:201`](../si/dimensions.ha#L201)

```hare
def TORQUE = dimension {
	mass = 1,
	length = 2,
	time = -2,
	...
};
```

[↲ constants](#constants)

---

### `VELOCITY`

[`⌕ ../si/dimensions.ha:205`](../si/dimensions.ha#L205)

```hare
def VELOCITY = dimension {
	length = 1,
	time = -1,
	...
};
```

[↲ constants](#constants)

---

### `VOLT`

[`⌕ ../si/units.ha:418`](../si/units.ha#L418)

```hare
def VOLT = unit {
	dim = ELECTRIC_POTENTIAL,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `VOLUME`

[`⌕ ../si/dimensions.ha:206`](../si/dimensions.ha#L206)

```hare
def VOLUME = dimension {
	length = 3,
	...
};
```

[↲ constants](#constants)

---

### `VOLUME_CHARGE_DENSITY`

[`⌕ ../si/dimensions.ha:223`](../si/dimensions.ha#L223)

```hare
def VOLUME_CHARGE_DENSITY = dimension {
	length = -3,
	time = 1,
	current = 1,
	...
};
```

[↲ constants](#constants)

---

### `WATT`

[`⌕ ../si/units.ha:419`](../si/units.ha#L419)

```hare
def WATT = unit {
	dim = POWER,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `WEBER`

[`⌕ ../si/units.ha:420`](../si/units.ha#L420)

```hare
def WEBER = unit {
	dim = MAGNETIC_FLUX,
	scale = 1.0,
};
```

[↲ constants](#constants)

---

### `YOCTO`

[`⌕ ../si/prefix.ha:26`](../si/prefix.ha#L26)

```hare
def YOCTO: f64 = 1.0e-24;
```

[↲ constants](#constants)

---

### `YOTTA`

[`⌕ ../si/prefix.ha:6`](../si/prefix.ha#L6)

```hare
def YOTTA: f64 = 1.0e24;
```

[↲ constants](#constants)

---

### `ZEPTO`

[`⌕ ../si/prefix.ha:25`](../si/prefix.ha#L25)

```hare
def ZEPTO: f64 = 1.0e-21;
```

[↲ constants](#constants)

---

### `ZETTA`

[`⌕ ../si/prefix.ha:7`](../si/prefix.ha#L7)

```hare
def ZETTA: f64 = 1.0e21;
```

[↲ constants](#constants)

---

