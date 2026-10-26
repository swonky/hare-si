use fmt;
use io;

// Unit prefix decimal exponents
type prefix = enum {
	YOTTA = 24,
	ZETTA = 21,
	EXA = 18,
	PETA = 15,
	TERA = 12,
	GIGA = 9,
	MEGA = 6,
	KILO = 3,
	HECTO = 2,
	DECA = 1,
	DECI = -1,
	CENTI = -2,
	MILLI = -3,
	MICRO = -6,
	NANO = -9,
	PICO = -12,
	FEMTO = -15,
	ATTO = -18,
	ZEPTO = -21,
	YOCTO = -24,
};

// Dimension
type dimension = struct {
	kg: int,  // mass
	m: int,   // length
	s: int,   // time
	A: int,   // electric current
	K: int,   // thermodynamic temperature
	mol: int, // amount of substance
	cd: int   // luminous intensity
};

type unit = struct {
	dim: dimension,
	scale: f32,
};

const metre = unit {
	dim = dimension { m = 1, ... },
	scale = 1.0
};

const newton = unit {
	dim = dimension { kg = 1, m = 1, s = -2, ... },
	scale = 1.0
};

const joule = unit {
	dim = dimension { kg = 1, m = 2, s = -2, ... },
	scale = 1.0
};

fn multiply(a: unit, b: unit) unit = {
	return unit {
		dim = dimension {
			kg   = a.dim.kg  + b.dim.kg,
			m    = a.dim.m   + b.dim.m,
			s    = a.dim.s   + b.dim.s,
			A    = a.dim.A   + b.dim.A,
			K    = a.dim.K   + b.dim.K,
			mol  = a.dim.mol + b.dim.mol,
			cd   = a.dim.cd  + b.dim.cd,
		},
		scale = a.scale * b.scale
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
};
