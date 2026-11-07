use memio;
use strings;
use test;

@test fn test_write_string() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);
	const input = "90° · Ω · Å";
	const expected = "90° · Ω · Å";

	const n = write_string(&h, input)!;
	assert(n == len(strings::toutf8(expected)));
	assert(memio::string(&h)! == expected);
};

@test fn write_value_fixed() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_value(&h, 12.5, 2, notation::FIXED)!;
	assert(memio::string(&h)! == "12.50");
	assert(n == 5z);
};

@test fn write_value_general() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_value(&h, 12.5)!;
	assert(memio::string(&h)! == "12.5");
	assert(n == 4z);
};

@test fn write_value_scientific() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_value(
		&h, 1234.0, 2, notation::SCIENTIFIC,
	)!;
	assert(memio::string(&h)! == "1.23×10³");
	assert(n == len(strings::toutf8("1.23×10³")));
};

@test fn write_value_scientific_ascii() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_value(
		&h, 1234.0, 2, notation::SCIENTIFIC,
		encoding::ASCII,
	)!;
	assert(memio::string(&h)! == "1.23*10^3");
	assert(n == 9z);
};

@test fn write_value_scientific_negative_exponent() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_value(
		&h, 0.00123, 2, notation::SCIENTIFIC,
	)!;
	assert(memio::string(&h)! == "1.23×10⁻³");
	assert(n == len(strings::toutf8("1.23×10⁻³")));
};

@test fn write_int_as_superscript_zero() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_int_as_superscript(&h, 0)!;
	assert(memio::string(&h)! == "");
	assert(n == 0z);
};

@test fn write_int_as_superscript() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_int_as_superscript(&h, 1234567890)!;
	assert(memio::string(&h)! == "¹²³⁴⁵⁶⁷⁸⁹⁰");
	assert(n == len(strings::toutf8("¹²³⁴⁵⁶⁷⁸⁹⁰")));
};

@test fn write_int_as_superscript_negative() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_int_as_superscript(&h, -1234567890)!;
	assert(memio::string(&h)! == "⁻¹²³⁴⁵⁶⁷⁸⁹⁰");
	assert(n == len(strings::toutf8("⁻¹²³⁴⁵⁶⁷⁸⁹⁰")));
};

@test fn write_str_as_superscript() void = {
	let buf: [64]u8 = [0...];
	let h = memio::fixed(buf);

	const n = write_str_as_superscript(&h, "-1234567890")!;
	assert(memio::string(&h)! == "⁻¹²³⁴⁵⁶⁷⁸⁹⁰");
	assert(n == len(strings::toutf8("⁻¹²³⁴⁵⁶⁷⁸⁹⁰")));
};

@test fn write_exponent() void = {
	let buf: [32]u8 = [0...];
	let h = memio::fixed(buf);

	write_exponent(&h, 0, encoding::UTF8)!;
	assert(memio::string(&h)! == "");

	write_exponent(&h, 30, encoding::UTF8)!;
	assert(memio::string(&h)! == "³⁰");

	write_exponent(&h, -12, encoding::UTF8)!;
	assert(memio::string(&h)! == "³⁰⁻¹²");

	write_exponent(&h, 30, encoding::ASCII)!;
	assert(memio::string(&h)! == "³⁰⁻¹²^30");

	write_exponent(&h, -12, encoding::ASCII)!;
	assert(memio::string(&h)! == "³⁰⁻¹²^30^-12");
};


