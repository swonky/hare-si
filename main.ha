use fmt;
use io;
use math;
use strconv;
use strings;
use os;

type no_match    = !str;
type unspecified = !str;
type not_implemented = !str;
type invalid = !void;
type expected_ = !str;

type unexpected  = struct {
	pos: size,
	exp: str,
	got: str,
};

type error = !(no_match | unexpected | invalid | strconv::invalid | strconv::overflow);

// Unit prefix decimal exponents
type prefix = enum i8 {
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
};

def prefix_scale: [_]f64 = [
	1.0e24,  // YOTTA
	1.0e21,  // ZETTA
	1.0e18,  // EXA
	1.0e15,  // PETA
	1.0e12,  // TERA
	1.0e9,   // GIGA
	1.0e6,   // MEGA
	1.0e3,   // KILO
	1.0e2,   // HECTO
	1.0e1,   // DECA
	1.0e-1,  // DECI
	1.0e-2,  // CENTI
	1.0e-3,  // MILLI
	1.0e-6,  // MICRO
	1.0e-9,  // NANO
	1.0e-12, // PICO
	1.0e-15, // FEMTO
	1.0e-18, // ATTO
	1.0e-21, // ZEPTO
	1.0e-24, // YOCTO
];

def prefix_names: [_]str = [
	"yotta",
	"zetta",
	"exa",
	"peta",
	"tera",
	"giga",
	"mega",
	"kilo",
	"hecto",
	"deca",
	"deci",
	"centi",
	"milli",
	"micro",
	"nano",
	"pico",
	"femto",
	"atto",
	"zepto",
	"yocto",
];

def prefix_symbols_ascii: [_]rune = [
	'Y',
	'Z',
	'E',
	'P',
	'T',
	'G',
	'M',
	'k',
	'h',
	'd',
	'c',
	'm',
	'u',
	'n',
	'p',
	'f',
	'a',
	'z',
	'y',
];

def prefix_symbols_utf8: [_]rune = [
	'Y',
	'Z',
	'E',
	'P',
	'T',
	'G',
	'M',
	'k',
	'h',
	'd',
	'c',
	'm',
	'μ',
	'n',
	'p',
	'f',
	'a',
	'z',
	'y',
];

type base_unit = enum {
	KILOGRAM,
	METRE,
	SECOND,
	AMPERE,
	KELVIN,
	MOLE,
	CANDELA,
};

type base_dimension = enum size {
	MASS, 
	LENGTH,
	TIME,
	CURRENT,
	TEMPERATURE,
	SUBSTANCE,
	LUMINOSITY,
};

type unit_kind = enum int {
	AMPERE,
	BECQUEREL,
	CANDELA,
	COULOMB,
	DEGREE_CELSIUS,
	FARAD,
	GRAM,
	GRAY,
	HENRY,
	HERTZ,
	JOULE,
	KATAL,
	KELVIN,
	LUMEN,
	LUX,
	METRE,
	MOLE,
	NEWTON,
	OHM,
	PASCAL,
	RADIAN,
	SECOND,
	SIEMENS,
	SIEVERT,
	STERADIAN,
	TESLA,
	VOLT,
	WATT,
	WEBER,
};

def sym_ampere               = "A";
def sym_becquerel            = "Bq";
def sym_candela              = "cd";
def sym_coulomb              = "C";
def sym_degree_celsius_utf8  = "°C";
def sym_degree_celsius_ascii = "degC";
def sym_farad                = "F";
def sym_gram                 = "g";
def sym_gray                 = "Gy";
def sym_henry                = "H";
def sym_hertz                = "Hz";
def sym_joule                = "J";
def sym_katal                = "kat";
def sym_kelvin               = "K";
def sym_lumen                = "lm";
def sym_lux                  = "lx";
def sym_metre                = "m";
def sym_mole                 = "mol";
def sym_newton               = "N";
def sym_ohm_utf8             = "Ω";
def sym_ohm_ascii            = "ohm";
def sym_pascal               = "Pa";
def sym_radian               = "rad";
def sym_second               = "s";
def sym_siemens              = "S";
def sym_sievert              = "Sv";
def sym_steradian            = "sr";
def sym_tesla                = "T";
def sym_volt                 = "V";
def sym_watt                 = "W";
def sym_weber                = "Wb";

def name_ampere              = "ampere";
def name_becquerel           = "becquerel";
def name_candela             = "candela";
def name_coulomb             = "coulomb";
def name_degree_celsius      = "degree Celsius";
def name_farad               = "farad";
def name_gram                = "gram";
def name_gray                = "gray";
def name_henry               = "henry";
def name_hertz               = "hertz";
def name_joule               = "joule";
def name_katal               = "katal";
def name_kelvin              = "kelvin";
def name_lumen               = "lumen";
def name_lux                 = "lux";
def name_metre               = "metre";
def name_mole                = "mole";
def name_newton              = "newton";
def name_ohm                 = "ohm";
def name_pascal              = "pascal";
def name_radian              = "radian";
def name_second              = "second";
def name_siemens             = "siemens";
def name_sievert             = "sievert";
def name_steradian           = "steradian";
def name_tesla               = "tesla";
def name_volt                = "volt";
def name_watt                = "watt";
def name_weber               = "weber";

def symbols_utf8: [_]str = [
	sym_ampere,
	sym_becquerel,
	sym_candela,
	sym_coulomb,
	sym_degree_celsius_utf8,
	sym_farad,
	sym_gram,
	sym_gray,
	sym_henry,
	sym_hertz,
	sym_joule,
	sym_katal,
	sym_kelvin,
	sym_lumen,
	sym_lux,
	sym_metre,
	sym_mole,
	sym_newton,
	sym_ohm_utf8,
	sym_pascal,
	sym_radian,
	sym_second,
	sym_siemens,
	sym_sievert,
	sym_steradian,
	sym_tesla,
	sym_volt,
	sym_watt,
	sym_weber,
];

def symbols_ascii: [_]str = [
	sym_ampere,
	sym_becquerel,
	sym_candela,
	sym_coulomb,
	sym_degree_celsius_ascii,
	sym_farad,
	sym_gram,
	sym_gray,
	sym_henry,
	sym_hertz,
	sym_joule,
	sym_katal,
	sym_kelvin,
	sym_lumen,
	sym_lux,
	sym_metre,
	sym_mole,
	sym_newton,
	sym_ohm_ascii,
	sym_pascal,
	sym_radian,
	sym_second,
	sym_siemens,
	sym_sievert,
	sym_steradian,
	sym_tesla,
	sym_volt,
	sym_watt,
	sym_weber,
];

def unit_names: [_]str = [
	name_ampere,
	name_becquerel,
	name_candela,
	name_coulomb,
	name_degree_celsius,
	name_farad,
	name_gram,
	name_gray,
	name_henry,
	name_hertz,
	name_joule,
	name_katal,
	name_kelvin,
	name_lumen,
	name_lux,
	name_metre,
	name_mole,
	name_newton,
	name_ohm,
	name_pascal,
	name_radian,
	name_second,
	name_siemens,
	name_sievert,
	name_steradian,
	name_tesla,
	name_volt,
	name_watt,
	name_weber,
];

def units: [_]unit = [
	ampere,
	becquerel,
	candela,
	coulomb,
	degree_celsius,
	farad,
	gram,
	gray,
	henry,
	hertz,
	joule,
	katal,
	kelvin,
	lumen,
	lux,
	metre,
	mole,
	newton,
	ohm,
	pascal,
	radian,
	second,
	siemens,
	sievert,
	steradian,
	tesla,
	volt,
	watt,
	weber,
];


type symbol = struct {
	kind: unit_kind,
	repr: str,
};

def symbol_lookup: [_]symbol = [
	symbol { repr = "A",    kind = unit_kind::AMPERE         },
	symbol { repr = "Bq",   kind = unit_kind::BECQUEREL      },
	symbol { repr = "C",    kind = unit_kind::COULOMB        },
	symbol { repr = "F",    kind = unit_kind::FARAD          },
	symbol { repr = "Gy",   kind = unit_kind::GRAY           },
	symbol { repr = "H",    kind = unit_kind::HENRY          },
	symbol { repr = "Hz",   kind = unit_kind::HERTZ          },
	symbol { repr = "J",    kind = unit_kind::JOULE          },
	symbol { repr = "K",    kind = unit_kind::KELVIN         },
	symbol { repr = "N",    kind = unit_kind::NEWTON         },
	symbol { repr = "Pa",   kind = unit_kind::PASCAL         },
	symbol { repr = "S",    kind = unit_kind::SIEMENS        },
	symbol { repr = "Sv",   kind = unit_kind::SIEVERT        },
	symbol { repr = "T",    kind = unit_kind::TESLA          },
	symbol { repr = "V",    kind = unit_kind::VOLT           },
	symbol { repr = "W",    kind = unit_kind::WATT           },
	symbol { repr = "Wb",   kind = unit_kind::WEBER          },
	symbol { repr = "cd",   kind = unit_kind::CANDELA        },
	symbol { repr = "degC", kind = unit_kind::DEGREE_CELSIUS },
	symbol { repr = "g",    kind = unit_kind::GRAM           },
	symbol { repr = "kat",  kind = unit_kind::KATAL          },
	symbol { repr = "lm",   kind = unit_kind::LUMEN          },
	symbol { repr = "lx",   kind = unit_kind::LUX            },
	symbol { repr = "m",    kind = unit_kind::METRE          },
	symbol { repr = "mol",  kind = unit_kind::MOLE           },
	symbol { repr = "ohm",  kind = unit_kind::OHM            },
	symbol { repr = "rad",  kind = unit_kind::RADIAN         },
	symbol { repr = "s",    kind = unit_kind::SECOND         },
	symbol { repr = "sr",   kind = unit_kind::STERADIAN      },
	symbol { repr = "°C",   kind = unit_kind::DEGREE_CELSIUS },
	symbol { repr = "Ω",    kind = unit_kind::OHM            },
];

fn match_symbol(s: str) (unit_kind | void) = {
	// fmt::printf("matching: {}\n", s)!;
	let lo = 0z;
	let hi = len(symbol_lookup);
	for (lo < hi) {
		const mid = lo + (hi - lo) / 2z;
		const cmp = strings::compare(symbol_lookup[mid].repr, s);
		if (cmp < 0) {
			lo = mid + 1z;
		} else if (cmp > 0) {
			hi = mid;
		} else {
			return symbol_lookup[mid].kind;
		};
	};
	return void;
};

fn parse_unit(s: str) (unit | void) = {
	const sz: size = count(s);
	if (sz == 0) {
		return void;
	};
	match (match_symbol(s)) {
	case let kind: unit_kind =>
		return lookup_unit(kind);
	case =>
		void;
	};
	if (sz == 1) {
		return void;
	};
	let iter = strings::iter(s);
	const first = match (strings::next(&iter)) {
	case let r: rune =>
		yield r;
	case done =>
		return void;
	};
	// fmt::printf("matching prefix: {}\n", first)!;
	let scale = match (lookup_prefix(first)) {
	case let pref: prefix =>
		yield prefix_scale[pref];
	case void =>
		return void;
	};
	const suffix = strings::sub(s, 1);
	return match (match_symbol(suffix)) {
	case let kind: unit_kind =>
		let u: unit = lookup_unit(kind);
		u.scale = u.scale * scale;
		yield u;
	case void =>
		yield void;
	};
};

fn to_ascii(sym: unit_kind) str = symbols_ascii[sym: size];
fn to_utf8(sym: unit_kind) str  = symbols_utf8[sym: size];

fn lookup_name(sym: unit_kind) str  = unit_names[sym: size];
fn lookup_unit(sym: unit_kind) unit = units[sym: size];

fn lookup_prefix(c: rune) (prefix | void) = return switch (c) {
	case 'Y' => yield prefix::YOTTA;
	case 'Z' => yield prefix::ZETTA;
	case 'E' => yield prefix::EXA;
	case 'P' => yield prefix::PETA;
	case 'T' => yield prefix::TERA;
	case 'G' => yield prefix::GIGA;
	case 'M' => yield prefix::MEGA;
	case 'k' => yield prefix::KILO;
	case 'h' => yield prefix::HECTO;
	case 'd' => yield prefix::DECI;
	case 'c' => yield prefix::CENTI;
	case 'm' => yield prefix::MILLI;
	case 'u', 'μ', 'µ'  => yield prefix::MICRO;
	case 'n' => yield prefix::NANO;
	case 'p' => yield prefix::PICO;
	case 'f' => yield prefix::FEMTO;
	case 'a' => yield prefix::ATTO;
	case 'z' => yield prefix::ZEPTO;
	case 'y' => yield prefix::YOCTO;
	case => void;
};

// Dimension
type dimension = struct {
	mass:        int, // mass
	length:      int, // length
	time:        int, // time
	current:     int, // electric current
	temperature: int, // thermodynamic temperature
	substance:   int, // amount of substance
	luminosity:  int,  // luminous intensity
};

type unit = struct {
	dim:   dimension,
	scale: f64,
};

// Dimensionless
def dimensionless = dimension { ... };

// Returns true if unit is dimensionless
// fn is_dimensionless(u: unit) bool = u.dim.mass == 0 && u.dim.length == 0 && u.dim.time == 0
// 	&& u.dim.current == 0 && u.dim.temperature == 0 && u.dim.substance == 0 && u.dim.luminosity == 0;

// Base dimensions
def mass        = dimension { mass        = 1, ...};
def length      = dimension { length      = 1, ...};
def time        = dimension { time        = 1, ...};
def current     = dimension { current     = 1, ...};
def temperature = dimension { temperature = 1, ...};
def substance   = dimension { substance   = 1, ...};
def luminosity  = dimension { luminosity  = 1, ...};

// Derived dimensions
def absorbed_dose         = dimension { length     = 2,  time       = -2, ...                             };
def activity              = dimension { time       = -1, ...                                              };
def capacitance           = dimension { mass       = -1, length     = -2, time    = 4,  current = 2,  ... };
def catalytic_activity    = dimension { time       = -1, substance  = 1,  ...                             };
def conductance           = dimension { mass       = -1, length     = -2, time    = 3,  current = 2,  ... };
def dose_equivalent       = dimension { length     = 2,  time       = -2, ...                             };
def electric_charge       = dimension { time       = 1,  current    = 1,  ...                             };
def electric_potential    = dimension { mass       = 1,  length     = 2,  time    = -3, current = -1, ... };
def energy                = dimension { mass       = 1,  length     = 2,  time    = -2, ...               };
def force                 = dimension { mass       = 1,  length     = 1,  time    = -2, ...               };
def frequency             = dimension { time       = -1, ...                                              };
def illuminance           = dimension { length     = -2, luminosity = 1, ...                              };
def inductance            = dimension { mass       = 1,  length     = 2,  time    = -2, current = -2, ... };
def luminous_flux         = dimension { luminosity = 1,  ...                                              };
def magnetic_flux         = dimension { mass       = 1,  length     = 2,  time    = -2, current = -1, ... };
def magnetic_flux_density = dimension { mass       = 1,  time       = -2, current = -1, ...               };
def power                 = dimension { mass       = 1,  length     = 2,  time    = -3, ...               };
def pressure              = dimension { mass       = 1,  length     = -1, time    = -2, ...               };
def resistance            = dimension { mass       = 1,  length     = 2,  time    = -3, current = -2, ... };

def acceleration          = dimension { length     = 1,  time       = -2, ...                             };
def velocity              = dimension { length     = 1,  time       = -1, ...                             };
def area                  = dimension { length     = 2, ...                                               };
def volume                = dimension { length     = 3, ...                                               };

// Base units
def kilogram          = unit { dim = mass,                  scale = 1.0               };
def metre             = unit { dim = length,                scale = 1.0               };
def second            = unit { dim = time,                  scale = 1.0               };
def ampere            = unit { dim = current,               scale = 1.0               };
def kelvin            = unit { dim = temperature,           scale = 1.0               };
def mole              = unit { dim = substance,             scale = 1.0               };
def candela           = unit { dim = luminosity,            scale = 1.0               };

def gram              = unit { dim = mass,                  scale = 1e-3              };

// Derived units
def becquerel         = unit { dim = activity,              scale = 1.0               };
def coulomb           = unit { dim = electric_charge,       scale = 1.0               };
def degree_celsius    = unit { dim = temperature,           scale = 1.0               };
def farad             = unit { dim = capacitance,           scale = 1.0               };
def gray              = unit { dim = absorbed_dose,         scale = 1.0               };
def henry             = unit { dim = inductance,            scale = 1.0               };
def hertz             = unit { dim = frequency,             scale = 1.0               };
def joule             = unit { dim = energy,                scale = 1.0               };
def katal             = unit { dim = catalytic_activity,    scale = 1.0               };
def lumen             = unit { dim = luminous_flux,         scale = 1.0               };
def lux               = unit { dim = illuminance,           scale = 1.0               };
def newton            = unit { dim = force,                 scale = 1.0               };
def ohm               = unit { dim = resistance,            scale = 1.0               };
def pascal            = unit { dim = pressure,              scale = 1.0               };
def radian            = unit { dim = dimensionless,         scale = 1.0               };
def siemens           = unit { dim = conductance,           scale = 1.0               };
def sievert           = unit { dim = dose_equivalent,       scale = 1.0               };
def steradian         = unit { dim = dimensionless,         scale = 1.0               };
def tesla             = unit { dim = magnetic_flux_density, scale = 1.0               };
def volt              = unit { dim = electric_potential,    scale = 1.0               };
def watt              = unit { dim = power,                 scale = 1.0               };
def weber             = unit { dim = magnetic_flux,         scale = 1.0               };

// Non-SI
def minute            = unit { dim = time,                  scale = 60.0              };
def hour              = unit { dim = time,                  scale = 3600.0            };
def day               = unit { dim = time,                  scale = 86400.0           };
def astronomical_unit = unit { dim = length,                scale = 149597870700.0    };
def hectare           = unit { dim = area,                  scale = 10000.0           };
def litre             = unit { dim = volume,                scale = 0.001             };
def tonne             = unit { dim = mass,                  scale = 1000.0            };
def dalton            = unit { dim = mass,                  scale = 1.66053906892e-27 };
def electronvolt      = unit { dim = energy,                scale = 1.602176634e-19   };
def neper             = unit { dim = dimensionless,         scale = 1.0               };
def bel               = unit { dim = dimensionless,         scale = 1.0               };

fn mult_dim(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        + b.mass,
	length      = a.length      + b.length,
	time        = a.time        + b.time,
	current     = a.current     + b.current,
	temperature = a.temperature + b.temperature,
	substance   = a.substance   + b.substance,
	luminosity  = a.luminosity  + b.luminosity,
};

fn div_dim(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        - b.mass,
	length      = a.length      - b.length,
	time        = a.time        - b.time,
	current     = a.current     - b.current,
	temperature = a.temperature - b.temperature,
	substance   = a.substance   - b.substance,
	luminosity  = a.luminosity  - b.luminosity,
};

fn pow_dim(dim: dimension, exp: int) dimension = switch (exp) {
	case 0 =>
		yield dimensionless;
	case 1 =>
		yield dim;
	case =>
		yield dimension {
			mass        = dim.mass        * exp,
			length      = dim.length      * exp,
			time        = dim.time        * exp,
			current     = dim.current     * exp,
			temperature = dim.temperature * exp,
			substance   = dim.substance   * exp,
			luminosity  = dim.luminosity  * exp,
		};
};

fn mult_unit(a: unit, b: unit) unit = {
	return unit {
		dim   = mult_dim(a.dim, b.dim),
		scale = a.scale * b.scale,
	};
};

fn div_unit(a: unit, b: unit) unit = {
	return unit {
		dim   = div_dim(a.dim, b.dim),
		scale = a.scale / b.scale,
	};
};

fn pow_unit(a: unit, exp: int) unit = {
	return unit {
		dim   = pow_dim(a.dim, exp),
		scale = a.scale,
	};
};

fn to_json(buf: []u8, u: unit) (str | nomem) = {
	return fmt::bsprintf(buf, "{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}",
		u.dim.mass, u.dim.length, u.dim.time, u.dim.current, u.dim.temperature, u.dim.substance, u.dim.luminosity, u.scale);
};

fn uprint(u: unit) (size | io::error) = {
	let buf: *[512]u8 = alloc([0...])!;
	defer free(buf);
	return match (to_json(buf, u)) {
	case let json_object: str =>
		yield fmt::println(json_object);
	case nomem =>
		yield nomem;
	};
};

fn strerror(err: error) str = {
	match (err) {
	case let e: invalid =>
		return "Invalid";
	case let e: no_match =>
		return "Unrecognised symbol";
	case let e: strconv::error =>
		return strconv::strerror(e);
	case =>
		return "Uh oh";
	};
};


type parser = struct {
	scanner: strings::iterator,
	current: (token | done),
};

fn advance(p: *parser) void = {
	p.current = next_token(&p.scanner);
};

fn parse_primary(p: *parser) (unit | error) = {
	match (p.current) {
	case let tok: token =>
		switch (tok.kind) {
		case token_kind::IDENTIFIER =>
			advance(p);
			match (parse_unit(tok.text)) {
			case let u: unit =>
				return u;
			case void =>
				return tok.text: no_match;
			};
		case token_kind::LPAREN, token_kind::LBRACE =>
			const closing = if (tok.kind == token_kind::LPAREN) {
				yield token_kind::RPAREN;
			} else {
				yield token_kind::RBRACE;
			};

			advance(p);

			const result = parse_expr(p)?;

			match (p.current) {
			case let tok: token =>
				if (tok.kind != closing) {
					return invalid;
				};
				advance(p);
			case done =>
				return invalid;
			};

			return result;

		case =>
			return invalid;
		};
	case done =>
		return invalid;
	};
};

fn parse_factor(p: *parser) (unit | error) = {
	let result = parse_primary(p)?;

	let tok = match (p.current) {
	case let tok: token =>
		yield tok;
	case done =>
		return result;
	};

	return switch (tok.kind) {
	case token_kind::POWER =>
		advance(p);

		let sign: i8 = 1;

		match (p.current) {
		case let tok: token =>
			switch (tok.kind) {
			case token_kind::PLUS =>
				advance(p);
			case token_kind::MINUS =>
				sign = -1;
				advance(p);
			case =>
				void;
			};
		case done =>
			return invalid;
		};

		const tok = match (p.current) {
		case let tok: token =>
			if (tok.kind != token_kind::INTEGER) {
				return invalid;
			};
			yield tok;
		case done =>
			return invalid;
		};

		advance(p);
		yield pow_unit(result, sign * strconv::stoi8(tok.text)?);

	case token_kind::SUPER_INTEGER =>
		advance(p);
		yield pow_unit(result, strconv::stoi8(tok.text)?);

	case token_kind::SUPER_PLUS, token_kind::SUPER_MINUS =>
		const sign: i8 = if (tok.kind == token_kind::SUPER_MINUS) -1 else 1;
		advance(p);

		const tok = match (p.current) {
		case let tok: token =>
			if (tok.kind != token_kind::SUPER_INTEGER) {
				return invalid;
			};
			yield tok;
		case done =>
			return invalid;
		};

		advance(p);
		yield pow_unit(result, sign * strconv::stoi8(tok.text)?);

	case =>
		yield result;
	};
};

fn parse_expr(p: *parser) (unit | error) = {
	let result = parse_factor(p)?;

	for (true) {
		match (p.current) {
		case let tok: token =>
			switch (tok.kind) {
			case token_kind::MULTIPLY =>
				advance(p);
				const rhs = parse_factor(p)?;
				result = mult_unit(result, rhs);
			case token_kind::SOLIDUS =>
				advance(p);
				const rhs = parse_factor(p)?;
				result = div_unit(result, rhs);
			case =>
				return result;
			};
		case done =>
			return result;
		};
	};
};

fn parse(s: str) (unit | error) = {
	let p = parser {
		scanner = strings::iter(s),
		current = done,
	};

	advance(&p);

	const result = parse_expr(&p)?;

	match (p.current) {
	case done =>
		return result;
	case =>
		return invalid;
	};
};

export fn main() void = {
	if (len(os::args) < 2) {
		return;
	};
	match (parse(os::args[1])) {
	case let err: no_match =>
		fmt::printf("{}: {}", strerror(err), err)!;
		return;
	case let err: error =>
		fmt::printf("{}", strerror(err))!;
	case let u: unit =>
		uprint(u)!;
	};
};
