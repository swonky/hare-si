// math
//
// Arithmetic operations for constructing derived dimensions and units.
//
// Returns true if dimensions a and b are equal.
export fn equal(a: dimension, b: dimension) bool = {
	return a.mass == b.mass
	       && a.length == b.length
	       && a.time == b.time
	       && a.current == b.current
	       && a.temperature == b.temperature
	       && a.substance == b.substance
	       && a.luminosity == b.luminosity;
};

// Returns the product of units a and b.
export fn muld(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        + b.mass,
	length      = a.length      + b.length,
	time        = a.time        + b.time,
	current     = a.current     + b.current,
	temperature = a.temperature + b.temperature,
	substance   = a.substance   + b.substance,
	luminosity  = a.luminosity  + b.luminosity,
};

// Returns the quotiant of units a and b.
export fn divd(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        - b.mass,
	length      = a.length      - b.length,
	time        = a.time        - b.time,
	current     = a.current     - b.current,
	temperature = a.temperature - b.temperature,
	substance   = a.substance   - b.substance,
	luminosity  = a.luminosity  - b.luminosity,
};

// Returns the dimension x raised to the power of p
export fn powd(x: dimension, p: int) dimension = switch (exp) {
	case 0 =>
		yield dimensionless;
	case 1 =>
		yield x;
	case =>
		yield dimension {
			mass        = x.mass        * exp,
			length      = x.length      * exp,
			time        = x.time        * exp,
			current     = x.current     * exp,
			temperature = x.temperature * exp,
			substance   = x.substance   * exp,
			luminosity  = x.luminosity  * exp,
		};
};

// Returns the product of units a and b.
export fn mulu(a: unit, b: unit) unit = {
	return unit {
		dim   = muld(a.dim, b.dim),
		scale = a.scale * b.scale,
	};
};

// Returns the quotiant of units a and b.
export fn divu(a: unit, b: unit) (unit | divide_by_zero) = {

	if (math::isclosef64(b.scale, 0.0)) {
		return divide_by_zero;
	};
	return unit {
		dim   = divd(a.dim, b.dim),
		scale = a.scale / b.scale,
	};
};

// Returns the unit a raised to the power of b.
export fn powu(a: unit, exp: int) unit = {
	return unit {
		dim   = powd(a.dim, exp),
		scale = math::powf64(a.scale, exp: f64),
	};
};
