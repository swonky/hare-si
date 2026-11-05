use bufio;
use fmt;
use io;
use memio;
use os;
use strings;
use strconv;

fn write_value(
	h: io::handle,
	value: f64,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = {
	const format = switch (repr) {
	case notation::FIXED =>
		yield strconv::ffmt::F;
	case notation::SCIENTIFIC, notation::E_UPPER, notation::E_LOWER =>
		yield strconv::ffmt::E;
	case notation::GENERAL =>
		yield strconv::ffmt::G;
	};

	const flags = switch (repr) {
	case notation::E_UPPER =>
		yield strconv::fflags::UPPER_EXP
			| strconv::fflags::SHOW_POS_EXP
			| strconv::fflags::SHOW_TWO_EXP_DIGITS;
	case notation::E_LOWER =>
		yield strconv::fflags::SHOW_POS_EXP
			| strconv::fflags::SHOW_TWO_EXP_DIGITS;
	case =>
		yield strconv::fflags::NONE;
	};

	let formatted = strconv::ftosf(value, format, prec, flags)?;

	let count = 0z;

	if (repr != notation::GENERAL && repr != notation::SCIENTIFIC) {
		count += io::write(h, strings::toutf8(formatted))?;
		return count;
	};

	assert(formatted != "");
	let pair: (str, str) = strings::cut(formatted, "e");
	if (pair.1 == "") {
		pair = strings::cut(formatted, "E");
	};
	if (pair.1 == "") {
		count += io::write(h, strings::toutf8(formatted))?;
		return count;
	};

	const exponent = match (strconv::stoi(pair.1)) {
	case let i: int =>
		yield i;
	case =>
		// TODO logging
		fmt::errorf("invalid exponent: {}\n", pair.1)!;
		abort("invalid exponent from strconv");
	};

	assert(pair.0 != "");

	const scale = switch (enc) {
	case encoding::ASCII => yield "*10";
	case encoding::UTF8 => yield "×10";
	case => abort("invalid encoding");
	};

	let out = strings::toutf8(pair.0);
	append_str(&out, scale)?;

	let count = io::write(h, out)?;
	count += write_exponent(h, exponent, enc)?;

	return count;
};

fn rune_to_superscript(i: rune) (rune | void) = switch (i) {
	case '-' => yield SUPERSCRIPT_MINUS;
	case '0' => yield DIGIT_SUPER_ZERO;
	case '1' => yield DIGIT_SUPER_ONE;
	case '2' => yield DIGIT_SUPER_TWO;
	case '3' => yield DIGIT_SUPER_THREE;
	case '4' => yield DIGIT_SUPER_FOUR;
	case '5' => yield DIGIT_SUPER_FIVE;
	case '6' => yield DIGIT_SUPER_SIX;
	case '7' => yield DIGIT_SUPER_SEVEN;
	case '8' => yield DIGIT_SUPER_EIGHT;
	case '9' => yield DIGIT_SUPER_NINE;
	case => yield void;
};

fn append_superscript(out: *[]u8, s: str) (void | invalid_exponent | nomem) = {
	let iter = strings::iter(s);
	for (const d => strings::next(&iter)) {
		const r = match (rune_to_superscript(d)) {
		case void =>
			return d: invalid_exponent;
		case let r: rune =>
			yield r;
		};
		let runes: [_]rune = [r];
		let s = strings::fromrunes(runes)?;
		append_str(out, s)?;
	};
};

fn append_str(out: *[]u8, s: str) (void | nomem) = {
	let u = strings::toutf8(s);
	append(out, u...)?;
};

fn format_unit(input: str, enc: encoding) (str | error) = {
	let p = parser {
		scanner = strings::iter(input),
		current = done,
		advance = &next_token,
	};

	let out: []u8 = [];
	let exponent = false;
	let parenthesised_exponent = false;

	const is_utf = enc == encoding::UTF8;

	for (true) {
		const tok = match (advance(&p)) {
		case done =>
			break;
		case let tok: token =>
			yield tok;
		};

		if (exponent) {
			switch (tok.kind) {
			case token_kind::PLUS =>
				continue;
			case token_kind::MINUS =>
				append_str(&out, "⁻")?;
				continue;
			case token_kind::INTEGER =>
				append_superscript(&out, tok.text)?;
				exponent = parenthesised_exponent;
				continue;
			case token_kind::LPAREN =>
				append_str(&out, "(")?;
				parenthesised_exponent = true;
				continue;
			case token_kind::RPAREN =>
				append_str(&out, ")")?;
				exponent = false;
				parenthesised_exponent = false;
				continue;
			case =>
				exponent = false;
				parenthesised_exponent = false;
			};
		};

		switch (tok.kind) {
		case token_kind::IDENTIFIER =>
			let text = tok.text;
			if (len(text) > 1 && strings::hasprefix(text, "u")) {
				append_str(&out, if (enc == encoding::UTF8) "µ" else "u")?;
				text = strings::sub(text, 1);
			};

			const suffix = if (strings::hassuffix(text, sym_ohm_ascii)) {
				yield if (is_utf) sym_ohm_utf8 else sym_ohm_ascii;
			} else if (strings::hassuffix(text, "degC")) {
				yield if (is_utf) "°C" else "degC";
			} else if (strings::hassuffix(text, "deg")) {
				yield if (is_utf) "°" else "deg";
			} else if (strings::hassuffix(text, sym_angstrom_ascii)) {
				yield if (is_utf) {
					yield sym_angstrom_utf8;
				} else {
					yield sym_angstrom_ascii;
				};
			} else {
				yield "";
			};

			if (len(suffix) > 0) {
				append_str(&out, strings::sub(text, 0, len(text) - len(
					if (strings::hassuffix(text, "ohm")) "ohm"
					else if (strings::hassuffix(text, "degC")) "degC"
					else "deg"
				)))?;
				append_str(&out, suffix)?;
			} else {
				append_str(&out, text)?;
			};
		case token_kind::INTEGER =>
			append_str(&out, tok.text)?;
		case token_kind::PLUS =>
			append_str(&out, "+")?;
		case token_kind::MINUS =>
			append_str(&out, "−")?;
		case token_kind::POWER =>
			if (enc == encoding::ASCII) {
				append_str(&out, "^")?;
			} else {
				exponent = true;
			};
		case token_kind::MULTIPLY =>
			append_str(&out, "·")?;
		case token_kind::SOLIDUS =>
			append_str(&out, "/")?;
		case token_kind::LPAREN =>
			append_str(&out, "(")?;
		case token_kind::RPAREN =>
			append_str(&out, ")")?;
		case =>
			append_str(&out, tok.text)?;
		};
	};

	return strings::fromutf8(out)!;
};

// Formats and prints n as superscript to h.
fn write_super(h: io::handle, n: int) (size | io::error | nomem) = {
	let count = 0z;

	if (n == 0) return count;

	if (n < 0) {
		count += memio::appendrune(h, SUPERSCRIPT_MINUS)?;
		n = -n;
	};

	let buf: [10]u8 = [0...];
	let sz = 0z;

	for (n > 0) {
		buf[sz] = ('0' + n % 10): u8;
		sz += 1z;
		n = n / 10;
	};

	for (let j = sz; j > 0z; j -= 1z) {
		let digit = (buf[j - 1z] - '0'): size;
		count += memio::appendrune(h, superscript_digits[digit])?;
	};

	return count;
};

// Prints an exponent i to h with character encoding enc.
// 
//	write_exponent(os::stdout, 30, encoding::ASCII)
//	>> ^30
//
//	write_exponent(os::stdout, 30, encoding::UTF8)
//	>> ³⁰
//
fn write_exponent(h: io::handle, n: int, enc: encoding) (size | error) = {
	let count = 0z;

	if (n == 0) return 0;

	const is_utf = enc == encoding::UTF8;

	if (!is_utf) {
		count += memio::appendrune(h, CIRCUMFLEX_ACCENT)?;
		count += io::write(h, strings::toutf8(strconv::itos(n)))?;
		return count;
	};

	count += write_super(h, n)?;
	return count;
};

// Prints a quantity to an [[io::handle]], optionally using a specified unit
// format, precision, numeric notation, and character encoding. Returns the
// number of bytes printed.
export fn write_quantity(
	h: io::handle,
	qty: quantity,
	unit_format: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = {
	let count = 0z;
	match (unit_format) {
	case void =>
		const value: f64 = qty.value * qty.unit.scale;
		count += write_value(h ,value, prec, repr, enc)?;
		count += fmt::fprint(h, " ")?;
		count += write_unit(h, qty.unit, enc)?;
	case let s: str =>
		let target: unit = strpu(s)?;
		
		if (!equal(qty.unit.dim, target.dim)) {
			return dimension_mismatch;
		};

		const value: f64 = qty.value * qty.unit.scale / target.scale;

		count += write_value(h, value, prec, repr, enc)?;

		let formatted_unit = format_unit(s, enc)?;
		defer free(formatted_unit);

		count += fmt::fprintf(h, " {}", formatted_unit)!;
	};
	return count;
};


// Prints a quantity to an [[io::handle]], optionally using a specified unit
// format, precision, numeric notation, and character encoding.
// Returns the number of bytes printed.
export fn write_unit(h: io::handle, u: unit, enc: encoding) (size | error) = {
	let first = true;

	const exponents: [_]int = [
		u.dim.mass,
		u.dim.length,
		u.dim.time,
		u.dim.current,
		u.dim.temperature,
		u.dim.substance,
		u.dim.luminosity,
	];
	
	if (enc == encoding::JSON) {
		return encodejson(h, u);
	};

	const sym_mult = switch (enc) {
	case encoding::ASCII => yield ASTERISK;
	case encoding::UTF8 => yield DOT_OPERATOR;
	case encoding::JSON => yield unreachable();
	};


	let total: size = 0;
	for (let i = 0z; i < len(symbols_base); i += 1) {

		if (exponents[i] == 0) continue;

		if (!first) total += fmt::fprint(h, sym_mult)?;

		total += fmt::fprint(h, symbols_base[i])?;
		total += write_exponent(h, exponents[i], enc)?;
		first = false;
	};

	return total;
};

// Formats and prints x to handler h.
// Returns the number of bytes printed.
// See also: [[fprint]], [[println]].
export fn fprint(
	h: io::handle,
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = {
	return match (x) {
	case let q: quantity =>
		yield write_quantity(h, q, ustr, prec, repr, enc)?;
	case let u: unit =>
		yield write_unit(h, u, enc)?;
	};
};

// Formats and prints x to [[os::stdout]].
// Returns the number of bytes printed.
// See also: [[fprint]], [[println]].
export fn print(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = fprint(os::stdout, x, ustr, prec, repr, enc); 

// Formats and prints x followed by a newline to h.
// Returns the number of bytes printed.
// See also: [[fprint]], [[print]].
export fn println(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = {
	let count = print(x, ustr, prec, repr, enc)?;
	count += fmt::println()?;
	return count;
};

// Formats a quantity as a string using the specified unit format, precision,
// notation, and character encoding.
// The result must be freed after use.
export fn strf(
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (str | error) = {
	let stream = memio::dynamic();
	defer io::close(&stream)!;
	fprint(&stream, x, ustr, prec, repr, enc)?;
	return strings::dup(memio::string(&stream)?)?;
};

@test fn strf() void = {
	const s = strf(SPEED_OF_LIGHT, "m/s", 3, notation::FIXED, encoding::ASCII)!;
	defer free(s);
	assert(s == "299792458.000 m/s");
};

