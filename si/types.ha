
// Symbol
type symbol = struct {
	kind: unit_kind,
	repr: str,
};

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
