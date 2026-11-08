// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

use math;
use strings;
use test;

fn _assert_close(a: f64, b: f64) void = assert(math::isclosef64(a, b));

fn _assert_unit(input: (str | unit), expected: unit) void = {
	const u = match (input) {
	case let s: str =>
		yield strpu(s)!;
	case let u: unit =>
		yield u;
	};
	assert(u.scale == expected.scale);
	assert(u.dim.mass == expected.dim.mass);
	assert(u.dim.length == expected.dim.length);
	assert(u.dim.time == expected.dim.time);
	assert(u.dim.current == expected.dim.current);
	assert(u.dim.temperature == expected.dim.temperature);
	assert(u.dim.substance == expected.dim.substance);
	assert(u.dim.luminosity == expected.dim.luminosity);
};

fn _assert_invalid_unit(input: str) void = {
	match (strpu(input)) {
	case let u: unit =>
		abort("expected invalid unit");
	case let err: error =>
		void;
	};
};

fn _assert_invalid_quantity(input: str) void = {
	match (strp(input)) {
	case let q: quantity =>
		abort("expected invalid quantity");
	case let err: error =>
		void;
	};
};

@test fn scale10_identity() void = {
	_assert_close(scale10(1.25, 0), 1.25);
	_assert_close(scale10(0.0, 10), 0.0);
};

@test fn scale10_positive() void = {
	_assert_close(scale10(1.0, 1), 10.0);
	_assert_close(scale10(1.0, 3), 1000.0);
	_assert_close(scale10(1.25, 6), 1250000.0);
};

@test fn scale10_negative() void = {
	_assert_close(scale10(1.0, -1), 0.1);
	_assert_close(scale10(1.0, -3), 0.001);
	_assert_close(scale10(1.25, -6), 0.00000125);
};

@test fn ncut_within_input() void = {
	const parts = ncut("abcdef", 3);
	assert(parts.0 == "abc");
	assert(parts.1 == "def");
};

@test fn ncut_at_end() void = {
	const parts = ncut("abc", 3);
	assert(parts.0 == "abc");
	assert(parts.1 == "");
};

@test fn ncut_beyond_end() void = {
	const parts = ncut("abc", 10);
	assert(parts.0 == "abc");
	assert(parts.1 == "");
};

@test fn match_prefix_valid() void = {
	assert(match_prefix("k") is prefix_kind);
};

@test fn match_prefix_invalid() void = {
	assert(match_prefix("x") is void);
};

@test fn match_suffix_valid() void = {
	assert(match_suffix("m") is unit_kind);
};

@test fn match_suffix_invalid() void = {
	assert(match_suffix("xyz") is void);
};

@test fn parse_symbol_base_unit() void = {
	const u = parse_symbol("m") as unit;
	assert(u.scale == 1.0);
	assert(u.dim.length == 1);
};

@test fn parse_symbol_prefixed_unit() void = {
	const u = parse_symbol("km") as unit;
	assert(u.scale == 1000.0);
	assert(u.dim.length == 1);
};

@test fn parse_symbol_invalid() void = {
	assert(parse_symbol("") is void);
	assert(parse_symbol("x") is void);
	assert(parse_symbol("xyz") is void);
};

@test fn parse_superscript_positive() void = {
	assert(parse_superscript("²") as int == 2);
	assert(parse_superscript("¹²³") as int == 123);
	assert(parse_superscript("⁺³") as int == 3);
};

@test fn parse_superscript_negative() void = {
	assert(parse_superscript("⁻¹") as int == -1);
	assert(parse_superscript("⁻¹²³") as int == -123);
};

@test fn parse_superscript_zero() void = {
	assert(parse_superscript("⁰") as int == 0);
};

@test fn parse_superscript_invalid() void = {
	assert(parse_superscript("") is error);
	assert(parse_superscript("¹x") is error);
	assert(parse_superscript("x") is error);
};

@test fn parse_superscript_overflow() void = {
	assert(parse_superscript("⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹") is error);
};


@test fn strpu_base_units() void = {
	_assert_unit("m", METRE);
	_assert_unit("s", SECOND);
	_assert_unit("kg", KILOGRAM);
	_assert_unit("A", AMPERE);
	_assert_unit("K", KELVIN);
	_assert_unit("mol", MOLE);
	_assert_unit("cd", CANDELA);
};

@test fn strpu_prefixed_units() void = {
	_assert_unit("km", KILOMETRE);
	_assert_unit("mm", MILLIMETRE);
	_assert_unit("nm", NANOMETRE);
};

@test fn strpu_micro_sign() void = {
	_assert_unit("µm", MICROMETRE);
};

@test fn strpu_mu() void = {
	_assert_unit("μm", MICROMETRE);
};

@test fn strpu_omega() void = {
	_assert_unit("Ω", OHM);
};

@test fn strpu_ohm_sign() void = {
	_assert_unit("Ω", OHM);
};

@test fn strpu_derived_units() void = {
	_assert_unit("Hz", HERTZ);
	_assert_unit("N", NEWTON);
	_assert_unit("Pa", PASCAL);
	_assert_unit("J", JOULE);
	_assert_unit("W", WATT);
};

@test fn strpu_multiplication() void = {
	_assert_unit("N*m", NEWTON_METRE);
	_assert_unit("N·m", NEWTON_METRE);
	_assert_unit("N⋅m", NEWTON_METRE);
	_assert_unit("N×m", NEWTON_METRE);
};

@test fn strpu_division() void = {
	_assert_unit("m/s", METRE_PER_SECOND);
	_assert_unit("m/s^2", METRE_PER_SECOND_SQUARED);
	_assert_unit("kg/m^3", KILOGRAM_PER_CUBIC_METRE);
};

@test fn strpu_exponents() void = {
	_assert_unit("m^2", SQUARE_METRE);
	_assert_unit("m**2", SQUARE_METRE);
	_assert_unit("m²", SQUARE_METRE);
	_assert_unit("m^-2", RECIPROCAL_SQUARE_METRE);
	_assert_unit("m⁻²", RECIPROCAL_SQUARE_METRE);
	_assert_unit("m^+2", SQUARE_METRE);
	_assert_unit("m^(+2)", SQUARE_METRE);
	_assert_unit("m^{+2}", SQUARE_METRE);
};

@test fn strpu_grouping() void = {
	_assert_unit("m^-2*(A*s)", COULOMB_PER_SQUARE_METRE);
	_assert_unit("m^-2*{A*s}", COULOMB_PER_SQUARE_METRE);
	_assert_unit("(A*s)/m^2", COULOMB_PER_SQUARE_METRE);
};

@test fn strpu_whitespace() void = {
	_assert_unit(" m ", METRE);
	_assert_unit("m / s", METRE_PER_SECOND);
};

@test fn strpu_invalid_symbols() void = {
	_assert_invalid_unit("");
	_assert_invalid_unit("x");
	_assert_invalid_unit("xyz");
	_assert_invalid_unit("mxyz");
};

@test fn strpu_invalid_expressions() void = {
	_assert_invalid_unit("m/");
	_assert_invalid_unit("m*");
	_assert_invalid_unit("m^");
	_assert_invalid_unit("m^x");
	_assert_invalid_unit("m^2^3");
	_assert_invalid_unit("(m");
	_assert_invalid_unit("m)");
	_assert_invalid_unit("{m");
	_assert_invalid_unit("m}");
	_assert_invalid_unit("m/s)");
};

@test fn identify_base_unit() void = {
	const m = identify("m");
	const s = identify("s");

	assert(m.0 == prefix_kind::NONE);
	assert(m.1 != unit_kind::NONE);
	assert(s.0 == prefix_kind::NONE);
	assert(s.1 != unit_kind::NONE);
	assert(m.1 != s.1);
};

@test fn identify_prefixed_unit() void = {
	const m = identify("m");
	const km = identify("km");

	assert(km.0 != prefix_kind::NONE);
	assert(km.1 == m.1);
};

@test fn identify_trimmed_input() void = {
	const a = identify("km");
	const b = identify(" km ");

	assert(a.0 == b.0);
	assert(a.1 == b.1);
};

@test fn identify_invalid_symbol() void = {
	const u = identify("xyz");
	assert(u.0 == prefix_kind::NONE);
	assert(u.1 == unit_kind::NONE);
};

@test fn split_integer_value() void = {
	const parts = split("123 m")!;
	assert(parts.0 == "123");
	assert(parts.1 == "m");
};

@test fn split_decimal_value() void = {
	const parts = split("12.5 kg")!;
	assert(parts.0 == "12.5");
	assert(parts.1 == "kg");
};

@test fn split_scientific_value() void = {
	const parts = split("1.25e-3 m")!;
	assert(parts.0 == "1.25e-3");
	assert(parts.1 == "m");
};

@test fn split_whitespace() void = {
	const parts = split("  12.5   kg  ")!;
	assert(parts.0 == "12.5");
	assert(parts.1 == "kg");
};

@test fn split_invalid_value() void = {
	assert(split("m") is error);
	assert(split("") is error);
};

@test fn strp_integer_quantity() void = {
	const q = strp("67 m")!;
	assert(q.value == 67.0);
	_assert_unit(q.unit, METRE);
};

@test fn strp_decimal_quantity() void = {
	const q = strp("1.25 kg")!;
	_assert_close(q.value, 1.25);
	_assert_unit(q.unit, KILOGRAM);
};

@test fn strp_scientific_quantity() void = {
	const q = strp("6.022e23 mol")!;
	_assert_close(q.value, 6.022e23);
	_assert_unit(q.unit, MOLE);
};

@test fn strp_negative_exponent() void = {
	const q = strp("1.25e-3 m")!;
	_assert_close(q.value, 0.00125);
	_assert_unit(q.unit, METRE);
};

@test fn strp_quantity_with_compound_unit() void = {
	const q = strp("9.80665 m/s^2")!;
	_assert_close(q.value, 9.80665);
	_assert_unit(q.unit, METRE_PER_SECOND_SQUARED);
};

@test fn strp_quantity_with_prefixed_unit() void = {
	const q = strp("1.5 kΩ")!;
	_assert_close(q.value, 1.5);
	_assert_unit(q.unit, KILOOHM);
};

@test fn strp_invalid_quantity() void = {
	_assert_invalid_quantity("");
	_assert_invalid_quantity("m");
	_assert_invalid_quantity("abc m");
	_assert_invalid_quantity("12");
	_assert_invalid_quantity("12 xyz");
	_assert_invalid_quantity("12 m extra");
};
