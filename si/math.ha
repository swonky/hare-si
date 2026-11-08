// SPDX-License-Identifier: MIT
// (C) 2026 Tom Spencer <tcs.git@pm.me>

// math
//
// Arithmetic operations for constructing derived dimensions and units.

use math;

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

//Returns whether a and b are within tol of each other.
export fn isclose(
	a: quantity,
	b: quantity,
	tol: f64 = math::STANDARD_TOL,
) (bool | dimension_mismatch) = {
	if (!equal(a.unit.dim, b.unit.dim)) {
		return dimension_mismatch;
	};
	const av = a.value * a.unit.scale;
	const bv = b.value * b.unit.scale;

	return math::isclosef64(av, bv, tol);
};

// Scales the unit by a f64 or metric prefix factor.
export fn scale(u: unit, fac: (prefix_kind | f64)) unit = {
	const multiplier = match (fac) {
	case let kind: prefix_kind =>
		yield prefix_scale[kind];
	case let f: f64 =>
		yield f;
	};

	return unit { dim = u.dim, scale = u.scale * multiplier };
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

// Returns the quotient of units a and b.
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
export fn powd(x: dimension, p: int) dimension = switch (p) {
	case 0 =>
		yield DIMENSIONLESS;
	case 1 =>
		yield x;
	case =>
		yield dimension {
			mass        = x.mass        * p,
			length      = x.length      * p,
			time        = x.time        * p,
			current     = x.current     * p,
			temperature = x.temperature * p,
			substance   = x.substance   * p,
			luminosity  = x.luminosity  * p,
		};
};

// Returns the product of units a and b.
export fn mulu(a: unit, b: unit) unit = {
	return unit {
		dim   = muld(a.dim, b.dim),
		scale = a.scale * b.scale,
	};
};

// Returns the quotient of units a and b.
export fn divu(a: unit, b: unit) unit = {
	return unit {
		dim   = divd(a.dim, b.dim),
		scale = a.scale / b.scale,
	};
};

// Returns the quantity x raised to the integer power p.
export fn powu(x: unit, p: int) unit = {
	return unit {
		dim   = powd(x.dim, p),
		scale = if (p == 0) 1.0 else math::powf64(x.scale, p: f64),
	};
};

// Returns the sum of quantities a and b, converting b to a's unit.
// If b is an f64, it is treated as a value in a's unit.
export fn add(
	a: quantity,
	b: (quantity | f64),
) (quantity | dimension_mismatch) = {
	const value = match (b) {
	case let qty: quantity =>
		if (!equal(a.unit.dim, qty.unit.dim)) {
			return dimension_mismatch;
		};
		yield a.value + qty.value * qty.unit.scale / a.unit.scale;
	case let f: f64 =>
		yield a.value + f;
	};
	return quantity { unit = a.unit, value = value };
};

// Returns the difference of quantities a and b, converting b to a's unit.
// If b is an f64, it is treated as a value in a's unit.
export fn sub(
	a: quantity,
	b: (quantity | f64),
) (quantity | dimension_mismatch) = {
	const value = match (b) {
	case let qty: quantity =>
		if (!equal(a.unit.dim, qty.unit.dim)) {
			return dimension_mismatch;
		};
		yield a.value - qty.value * qty.unit.scale / a.unit.scale;
	case let f: f64 =>
		yield a.value - f;
	};
	return quantity { unit = a.unit, value = value };
};

// Returns the product of quantities a and b, or scales a by b if b is an f64.
export fn mulq(a: quantity, b: (quantity | f64)) quantity = {
	return match (b) {
	case let qty: quantity =>
		const u = mulu(a.unit, qty.unit);
		const v = a.value * qty.value;
		yield quantity { unit = u, value = v };
	case let f: f64 =>
		const u = a.unit;
		const v = a.value * f;
		yield quantity { unit = u, value = v };
	};
};

// Returns the quotient of quantities a and b, or scales a by 1/b if b is an f64.
export fn divq(a: quantity, b: (quantity | f64)) quantity = {
	return match (b) {
	case let qty: quantity =>
		const u = divu(a.unit, qty.unit);
		const v = a.value / qty.value;
		yield quantity { unit = u, value = v };
	case let f: f64 =>
		const u = a.unit;
		const v = a.value / f;
		yield quantity { unit = u, value = v };
	};
};

// Returns true if the value of the quantity or scale of its unit is infinite.
export fn isinf(q: quantity) bool = {
	return math::isinf(q.value) || math::isinf(q.unit.scale);
};

// Returns true if the value of the quantity or scale of its unit is NaN.
export fn isnan(q: quantity) bool = {
	return math::isnan(q.value) || math::isnan(q.unit.scale);
};

// Returns quantity x raised to the integer power p.
export fn powq(x: quantity, p: int) quantity = {
	const u = powu(x.unit, p);
	const v = math::powf64(x.value, p: f64);
	return quantity { unit = u, value = v };
};
