// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

// Represents the dimensional exponents of the seven SI base dimensions.
export type dimension = struct {
 	// mass (M)
	mass:        int,
 	// length (L)
	length:      int,
 	// time (T)
	time:        int,
	// electric current (I)
	current:     int, 
        // thermodynamic temperature (Θ)
	temperature: int,
 	// amount of substance (N)
	substance:   int,
 	// luminous intensity (J)
	luminosity:  int,
};

// Represents a unit of measurement by its physical [[dimension]] and scale.
export type unit = struct {
	dim:   dimension,
	scale: f64,
};


// Represents a physical quantity as a [[unit]] and numerical value.
export type quantity = struct {
	unit:  unit,
	value: f64,
};

// Specifies the notation used to format floating-point values. This enum
// adapts and combines the declarative intentions of the enum [[strconv::ffmt]]
// and the [[strconv::UPPER_EXP]] flag, and extends to provide additional
// formatting options for alternative forms of scientific notation expressions.
export type notation = enum u8 {
	// General format. Uses whichever of SCIENTIFIC and FIXED is shortest.
	// Similar to [strconv::ffmt::G].
	GENERAL,
	// General format. Uses whichever of SCIENTIFIC and FIXED is shortest.
	// Similar to [strconv::ffmt::F].
	FIXED,
	// E-notation. Consists of a fixed precision number between (1, 10),
	// followed by '*10' (ascii) or '×10' (utf0, then an exponent expression.
	SCIENTIFIC,
	// E-notation. Consists of a fixed precision number between (1, 10),
	// followed by uppercase 'E', then a signed integer exponent.
	// Similar to [[strconv::ffmt::E]] and [[strconv::UPPER_EXP]].
	E_UPPER,
	// E-notation. Consists of a fixed precision number between (1, 10),
	// followed by lowercase 'e', then a signed integer exponent.
	// Similar to [[strconv::ffmt::E]].
	E_LOWER,
};

// Specifies the output encoding.
export type encoding = enum u8 {
	// Plain text restricted to the 128 code points of the ASCII character set.
	ASCII,
	// Plain text using the full range of the Unicode UTF-8 character set.
	UTF8,
	// Machine-readable JSON object syntax.
	JSON,
};

// Union of symbol enum types.
export type symbol_kind = (prefix_kind | unit_kind);
