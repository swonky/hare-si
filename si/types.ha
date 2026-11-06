// Represents the dimensional exponents of the seven SI base dimensions.
export type dimension = struct {
	mass:        int, // mass
	length:      int, // length
	time:        int, // time
	current:     int, // electric current
	temperature: int, // thermodynamic temperature
	substance:   int, // amount of substance
	luminosity:  int, // luminous intensity
};

// Represents a unit of measurement by its physical [[dimension]] and scale.
export type unit = struct {
	dim:   dimension,
	scale: f64,
};

// Represents a physical quantity as a unit and numerical value.
export type quantity = struct {
	unit:  unit,
	value: f64,
};

// Specifies the notation used to format floating-point values.
export type notation = enum u8 {
	GENERAL,
	FIXED,
	SCIENTIFIC,
	E_UPPER,
	E_LOWER,
};

// Specifies the character encoding options.
export type encoding = enum u8 {
	ASCII,
	UTF8,
	JSON,
};

// Union of symbol enum types.
export type symbol_kind = (prefix_kind | unit_kind);
