use memio;

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

