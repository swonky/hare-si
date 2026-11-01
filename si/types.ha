// Dimension
export type dimension = struct {
	mass:        int, // mass
	length:      int, // length
	time:        int, // time
	current:     int, // electric current
	temperature: int, // thermodynamic temperature
	substance:   int, // amount of substance
	luminosity:  int,  // luminous intensity
};

// Unit
export type unit = struct {
	dim:   dimension,
	scale: f64,
};

// Quantity
export type quantity = struct {
	unit:  unit,
	value: f64,
};

export type notation = enum u8 {
	GENERAL,
	FIXED,
	SCIENTIFIC,
	E_UPPER,
	E_LOWER,
};

type encoding = enum u8 { ASCII, UTF8 };
