use fmt;
use math;
use io;


type hello = enum rune {
	WORLD = '=',
};

// Unit prefix decimal exponents
type decimal_prefix = enum i8 {
	YOTTA = 24,
	ZETTA = 21,
	EXA   = 18,
	PETA  = 15,
	TERA  = 12,
	GIGA  = 9,
	MEGA  = 6,
	KILO  = 3,
	HECTO = 2,
	DECA  = 1,
	DECI  = -1,
	CENTI = -2,
	MILLI = -3,
	MICRO = -6,
	NANO  = -9,
	PICO  = -12,
	FEMTO = -15,
	ATTO  = -18,
	ZEPTO = -21,
	YOCTO = -24,
};

fn prefix_exponent(c: rune) (i8 | void) = {
	let prefix = switch (c) {
	case 'Y' => decimal_prefix::YOTTA;
	case 'Z' => decimal_prefix::ZETTA;
	case 'E' => decimal_prefix::EXA;
	case 'P' => decimal_prefix::PETA;
	case 'T' => decimal_prefix::TERA;
	case 'G' => decimal_prefix::GIGA;
	case 'M' => decimal_prefix::MEGA;
	case 'k' => decimal_prefix::KILO;
	case 'h' => decimal_prefix::HECTO;
	case 'd' => decimal_prefix::DECI;
	case 'c' => decimal_prefix::CENTI;
	case 'm' => decimal_prefix::MILLI;
	case 'u', 'μ' => decimal_prefix::MICRO;
	case 'n' => decimal_prefix::NANO;
	case 'p' => decimal_prefix::PICO;
	case 'f' => decimal_prefix::FEMTO;
	case 'a' => decimal_prefix::ATTO;
	case 'z' => decimal_prefix::ZEPTO;
	case 'y' => decimal_prefix::YOCTO;
	case => return void;
	};
	return prefix: i8;
};

// Unit prefix binary exponents
type binary_prefix = enum {
	QUEBI = 100,
	ROBI  = 90,
	YOBI  = 80,
	ZEBI  = 70,
	EXBI  = 60,
	PEBI  = 50,
	TEBI  = 40,
	GIBI  = 30,
	MEBI  = 20,
	KIBI  = 10,
};

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

// Dimension
type dimension = struct {
	mass        : int, // mass
	length      : int, // length
	time        : int, // time
	current     : int, // electric current
	temperature : int, // thermodynamic temperature
	substance   : int, // amount of substance
	luminosity  : int  // luminous intensity
};

type unit = struct {
	dim: dimension,
	scale: f32,
};

def dimensionless = dimension { ... };

fn is_dimensionless(dim: dimension) bool = dim.mass == 0 && dim.length == 0 && dim.time == 0
	&& dim.current == 0 && dim.temperature == 0 && dim.substance == 0 && dim.luminosity == 0;

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
def catalytic_activity    = dimension { time       = -1, substance  = 1,                                  };
def conductance           = dimension { mass       = -1, length     = -2, time    = 3,  current = 2,  ... };
def dose_equivalent       = dimension { length     = 2,  time       = -2, ...                             };
def electric_charge       = dimension { time       = 1,  current    = 1,                                  };
def electric_potential    = dimension { mass       = 1,  length     = 2,  time    = -3, current = -1, ... };
def energy                = dimension { mass       = 1,  length     = 2,  time    = -2, ...               };
def force                 = dimension { mass       = 1,  length     = 1,  time    = -2, ...               };
def frequency             = dimension { time       = -1, ...                                              };
def illuminance           = dimension { length     = -2, luminosity = 1,                                  };
def inductance            = dimension { mass       = 1,  length     = 2,  time    = -2, current = -2, ... };
def luminous_flux         = dimension { luminosity = 1,                                                   };
def magnetic_flux         = dimension { mass       = 1,  length     = 2,  time    = -2, current = -1, ... };
def magnetic_flux_density = dimension { mass       = 1,  time       = -2, current = -1,                   };
def power                 = dimension { mass       = 1,  length     = 2,  time    = -3, ...               };
def pressure              = dimension { mass       = 1,  length     = -1, time    = -2,                   };
def resistance            = dimension { mass       = 1,  length     = 2,  time    = -3, current = -2, ... };

def acceleration          = dimension { length     = 1,  time       = -2, ...                             };
def velocity              = dimension { length     = 1,  time       = -1, ...                             };
def area                  = dimension { length     = 2,                                                   };
def volume                = dimension { length     = 3,                                                   };

// Base units
def kilogram  = unit { dim = mass,        scale = 1.0 };
def metre     = unit { dim = length,      scale = 1.0 };
def second    = unit { dim = time,        scale = 1.0 };
def ampere    = unit { dim = current,     scale = 1.0 };
def kelvin    = unit { dim = temperature, scale = 1.0 };
def mole      = unit { dim = substance,   scale = 1.0 };
def candela   = unit { dim = luminosity,  scale = 1.0 };

// Derived units
def becquerel = unit { dim = activity,              scale = 1.0 };
def coulomb   = unit { dim = electric_charge,       scale = 1.0 };
def farad     = unit { dim = capacitance,           scale = 1.0 };
def gray      = unit { dim = absorbed_dose,         scale = 1.0 };
def henry     = unit { dim = inductance,            scale = 1.0 };
def hertz     = unit { dim = frequency,             scale = 1.0 };
def joule     = unit { dim = energy,                scale = 1.0 };
def katal     = unit { dim = catalytic_activity,    scale = 1.0 };
def lumen     = unit { dim = luminous_flux,         scale = 1.0 };
def lux       = unit { dim = illuminance,           scale = 1.0 };
def newton    = unit { dim = force,                 scale = 1.0 };
def ohm       = unit { dim = resistance,            scale = 1.0 };
def pascal    = unit { dim = pressure,              scale = 1.0 };
def radian    = unit { dim = plane_angle,           scale = 1.0 };
def siemens   = unit { dim = conductance,           scale = 1.0 };
def sievert   = unit { dim = dose_equivalent,       scale = 1.0 };
def steradian = unit { dim = solid_angle,           scale = 1.0 };
def tesla     = unit { dim = magnetic_flux_density, scale = 1.0 };
def volt      = unit { dim = electric_potential,    scale = 1.0 };
def watt      = unit { dim = power,                 scale = 1.0 };
def weber     = unit { dim = magnetic_flux,         scale = 1.0 };


fn pow(a: unit, exp: int) unit = {
	return unit {
	};
};

type dim_op = *fn(dimension, dimension) dimension;

fn mult_dim(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        + b.mass,
	length      = a.length      + b.length,
	time        = a.time        + b.time,
	current     = a.current     + b.current,
	temperature = a.temperature + b.temperature,
	substance   = a.substance   + b.substance,
	candela     = a.candela     + b.candela,
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
			candela     = dim.candela     * exp,
		};
};


fn mult_unit(a: unit, b: unit) unit = {
	return unit {
		dimension = mult_dim(a, b),
		scale     = a.scale * b.scale,
	};
};

fn to_json(buf: []u8, u: unit) (str | nomem) = {
	return fmt::bsprintf(buf, "{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}",
		u.dim.kg, u.dim.m, u.dim.s, u.dim.A, u.dim.K, u.dim.mol, u.dim.cd, u.scale);
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

export fn main() void = {
	let c: unit = multiply(newton, metre);
	uprint(c)!;	
	let d: rune = hello::WORLD: rune;
	fmt::printf("{}", d)!;	
};
