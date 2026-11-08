// SPDX-License-Identifier: MIT
// (C) 2026 Tom Spencer <tcs.git@pm.me>

use io;
use memio;
use strings;
use test;

fn _new_test_buf() memio::stream = {
	static let buf: [128]u8 = [0...];
	return memio::fixed(buf);
};

fn _assert_string(h: memio::stream, n: size, expected: str) void = {
	assert(memio::string(&h)! == expected);
	assert(n == len(strings::toutf8(expected)));
};

@test fn test_write_string() void = {
	let h = _new_test_buf();
	const input = "90° · Ω · Å";
	const n = write_string(&h, input)!;
	_assert_string(h, n, input);
};

@test fn write_value_fixed() void = {
	let h = _new_test_buf();
	const n = write_value(&h, 12.5, 2, notation::FIXED)!;
	_assert_string(h, n, "12.50");
};

@test fn write_value_general() void = {
	let h = _new_test_buf();
	const n = write_value(&h, 12.5)!;
	_assert_string(h, n, "12.5");
};

@test fn write_value_scientific() void = {
	let h = _new_test_buf();
	const n = write_value(&h, 1234.0, 2, notation::SCIENTIFIC)!;
	_assert_string(h, n, "1.23×10³");
};

@test fn write_value_scientific_ascii() void = {
	let h = _new_test_buf();
	const n = write_value(&h, 1234.0, 2, notation::SCIENTIFIC, encoding::ASCII)!;
	_assert_string(h, n, "1.23*10^3");
};

@test fn write_value_scientific_negative_exponent() void = {
	let h = _new_test_buf();
	const n = write_value(&h, 0.00123, 2, notation::SCIENTIFIC)!;
	_assert_string(h, n, "1.23×10⁻³");
};

@test fn write_int_as_superscript_zero() void = {
	let h = _new_test_buf();
	const n = write_int_as_superscript(&h, 0)!;
	_assert_string(h, n, "");
};

@test fn write_int_as_superscript() void = {
	let h = _new_test_buf();
	const n = write_int_as_superscript(&h, 1234567890)!;
	_assert_string(h, n, "¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_int_as_superscript_negative() void = {
	let h = _new_test_buf();
	const n = write_int_as_superscript(&h, -1234567890)!;
	_assert_string(h, n, "⁻¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_str_as_superscript() void = {
	let h = _new_test_buf();
	const n = write_str_as_superscript(&h, "-1234567890")!;
	_assert_string(h, n, "⁻¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_exponent_zero() void = {
	let h = _new_test_buf();
	let n = write_exponent(&h, 0, encoding::ASCII)!;
	n += write_exponent(&h, 0, encoding::UTF8)!;
	_assert_string(h, n, "");
};

@test fn write_exponent_positive_ascii() void = {
	let h = _new_test_buf();
	const n = write_exponent(&h, 1234567890, encoding::ASCII)!;
	_assert_string(h, n, "^1234567890");
};

@test fn write_exponent_negative_ascii() void = {
	let h = _new_test_buf();
	const n = write_exponent(&h, -1234567890, encoding::ASCII)!;
	_assert_string(h, n, "^-1234567890");
};

@test fn write_exponent_positive_utf() void = {
	let h = _new_test_buf();
	const n = write_exponent(&h, 1234567890, encoding::UTF8)!;
	_assert_string(h, n, "¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_exponent_negative_utf() void = {
	let h = _new_test_buf();
	const n = write_exponent(&h, -1234567890, encoding::UTF8)!;
	_assert_string(h, n, "⁻¹²³⁴⁵⁶⁷⁸⁹⁰");
};


@test fn write_reformatted_unit_symbols() void = {
	let h = _new_test_buf();
	const expected = "kohm";
	const n = write_reformatted_unit(&h, "kohm", encoding::ASCII)!;
};

@test fn write_reformatted_unit_ohm_utf8() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "kΩ", encoding::UTF8)!;
	_assert_string(h, n, "kΩ");
};

@test fn write_reformatted_unit_superscript() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m¹²³⁴⁵⁶⁷⁸⁹⁰", encoding::UTF8)!;
	_assert_string(h, n, "m¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_reformatted_unit_superscript_ascii() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m¹²³⁴⁵⁶⁷⁸⁹⁰", encoding::ASCII)!;
	_assert_string(h, n, "m^1234567890");
};

@test fn write_reformatted_unit_power() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m^1234567890", encoding::UTF8)!;
	_assert_string(h, n, "m¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_reformatted_unit_power_ascii() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m^1234567890", encoding::ASCII)!;
	_assert_string(h, n, "m^1234567890");
};

@test fn write_reformatted_unit_negative_exponent() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m^-1234567890", encoding::UTF8)!;
	_assert_string(h, n, "m⁻¹²³⁴⁵⁶⁷⁸⁹⁰");
};

@test fn write_reformatted_unit_negative_exponent_ascii() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m^-1234567890", encoding::ASCII)!;
	_assert_string(h, n, "m^-1234567890");
};

@test fn write_reformatted_unit_positive_exponent() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m^+123", encoding::UTF8)!;
	_assert_string(h, n, "m¹²³");
};

@test fn write_reformatted_unit_bracketed_exponent() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "Mm**(-2)", encoding::UTF8)!;
	_assert_string(h, n, "Mm⁻²");
};

@test fn write_reformatted_unit_bracketed_exponent_ascii() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "Mm**(-2)", encoding::ASCII)!;
	_assert_string(h, n, "Mm^-2");
};

@test fn write_reformatted_unit_braced_exponent() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "Mm**{-2}", encoding::UTF8)!;
	_assert_string(h, n, "Mm⁻²");
};

@test fn write_reformatted_unit_grouped_expression() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "(Mm**-2)", encoding::UTF8)!;
	_assert_string(h, n, "(Mm⁻²)");
};

@test fn write_reformatted_unit_grouped_braced_expression() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "{Mm**-2}", encoding::UTF8)!;
	_assert_string(h, n, "{Mm⁻²}");
};

@test fn write_reformatted_unit_multiplication() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m*s", encoding::UTF8)!;
	_assert_string(h, n, "m⋅s");
};

@test fn write_reformatted_unit_multiplication_ascii() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "m×s", encoding::ASCII)!;
	_assert_string(h, n, "m*s");
};

@test fn write_reformatted_unit_complex_expression() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "Pa^2/mm^(3)*ohm^(-4)", encoding::UTF8)!;
	_assert_string(h, n, "Pa²/mm³⋅Ω⁻⁴");
};

@test fn write_reformatted_unit_complex_expression_ascii() void = {
	let h = _new_test_buf();
	const n = write_reformatted_unit(&h, "Pa^2/mm^(3)*Ω^(-4)", encoding::ASCII)!;
	_assert_string(h, n, "Pa^2/mm^3*ohm^-4");
};

