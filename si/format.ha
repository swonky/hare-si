// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

use bufio;
use fmt;
use io;
use memio;
use os;
use strings;
use strconv;

// Writes a unicode string to a stream.
// Returns number of bytes written.
fn write_string(out: io::handle, in: str) (size | io::error) = {
	return io::write(out, strings::toutf8(in))?;
};

// Formats and writes an f64 value to a stream using the specified notation,
// precision, and character encoding.
// Returns the number of bytes written.
fn write_value(
	out: io::handle,
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
		count += write_string(out, formatted)?;
		return count;
	};

	assert(formatted != "");
	let pair: (str, str) = strings::cut(formatted, "e");
	if (pair.1 == "") {
		pair = strings::cut(formatted, "E");
	};
	if (pair.1 == "") {
		count += write_string(out, formatted)?;
		return count;
	};

	assert(pair.0 != "");
	count += write_string(out, pair.0)?;

	const scale = switch (enc) {
	case encoding::ASCII => yield "*10";
	case encoding::UTF8 => yield "×10";
	case => abort("invalid encoding");
	};

	count += write_string(out, scale)?;

	const exponent = match (strconv::stoi(pair.1)) {
	case let i: int =>
		yield i;
	case =>
		return invalid_exponent;
	};
	count += write_exponent(out, exponent, enc)?;

	return count;
};

// Writes an integer to a stream using superscript digits.
// Returns the number of bytes written.
fn write_int_as_superscript(out: io::handle, n: int) (size | io::error) = {
	let count = 0z;

	if (n == 0 || n == 1) return count;

	if (n < 0) {
		count += memio::appendrune(out, SUPERSCRIPT_MINUS)?;
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
		count += memio::appendrune(out, superscript_digits[digit])?;
	};

	return count;
};

// Converts a string of decimal digits and an optional leading minus sign
// to superscript characters and writes the result to a stream.
// Returns [[invalid_exponent]] or [[io::error]] on failure.
// Returns the number of bytes written on success.
fn write_str_as_superscript(out: io::handle, s: str) (size | error) = {
	let trimmed = strings::trim(s);
	if (trimmed == "0" || trimmed == "1") {
		return 0z;
	};
	let count = 0z;
	let iter = strings::iter(trimmed);
	for (const digit => strings::next(&iter)) {
		const symbol = switch (digit) {
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
			case => return invalid_exponent;
		};
		count += memio::appendrune(out, symbol)?;
	};
	return count;
};

// Writes the encoded string representation of kind to a stream.
// Returns the number of bytes written.
fn write_unit_prefix(
	out: io::handle,
	kind: prefix_kind,
	enc: encoding,
) (size | io::error) = {
	return switch (enc) {
	case encoding::ASCII, encoding::JSON =>
		yield write_string(out, prefix_symbols_ascii[kind: size])?;
	case encoding::UTF8 =>
		yield write_string(out, prefix_symbols_utf8[kind: size])?;
	};
};

// Writes the encoded string representation of kind to a stream.
// Returns the number of bytes written.
fn write_unit_suffix(
	out: io::handle,
	kind: unit_kind,
	enc: encoding = encoding::UTF8,
) (size | io::error) = {
	return switch (enc) {
	case encoding::ASCII, encoding::JSON =>
		yield write_string(out, symbols_ascii[kind: size])?;
	case encoding::UTF8 =>
		yield write_string(out, symbols_utf8[kind: size])?;
	};
};

// Writes the encoded string representation of kind to a stream.
// Returns the number of bytes written.
fn write_symbol(
	out: io::handle,
	kind: symbol_kind,
	enc: encoding
) (size | error) = {
	return match (kind) {
	case let k: prefix_kind =>
		yield write_unit_prefix(out, k, enc)?;
	case let k: unit_kind =>
		yield write_unit_suffix(out, k, enc)?;
	};
};

fn write_superscript_as_ascii(out: io::handle, s: str) (size | error) = {
	let count = 0z;
	let iter = strings::iter(s);

	for (const digit => strings::next(&iter)) {
		const symbol = switch (digit) {
		case DIGIT_SUPER_ZERO => yield "0";
		case DIGIT_SUPER_ONE => yield "1";
		case DIGIT_SUPER_TWO => yield "2";
		case DIGIT_SUPER_THREE => yield "3";
		case DIGIT_SUPER_FOUR => yield "4";
		case DIGIT_SUPER_FIVE => yield "5";
		case DIGIT_SUPER_SIX => yield "6";
		case DIGIT_SUPER_SEVEN => yield "7";
		case DIGIT_SUPER_EIGHT => yield "8";
		case DIGIT_SUPER_NINE => yield "9";
		case =>
			return invalid_exponent;
		};
		count += write_string(out, symbol)?;
	};

	return count;
};

fn write_exponent_sign(
	out: io::handle,
	sign: rune,
	enc: encoding,
) (size | error) = {
	const symbol = switch (sign) {
	case PLUS_SIGN, SUPERSCRIPT_PLUS_SIGN =>
		return 0z;
	case HYPHEN_MINUS, MINUS_SIGN, SUPERSCRIPT_MINUS =>
		yield if (enc == encoding::UTF8) SUPERSCRIPT_MINUS else HYPHEN_MINUS;
	case =>
		return invalid_exponent;
	};

	let count = 0z;
	if (enc == encoding::ASCII) {
		count += memio::appendrune(out, CIRCUMFLEX_ACCENT)?;
	};
	count += memio::appendrune(out, symbol)?;
	return count;
};

fn get_delimiter(
	out: io::handle,
	kind: token_kind,
) (rune | void) = {
	return switch (kind) {
	case =>
		yield void;
	};
};

fn write_reformatted_unit(
	out: io::handle,
	input: str,
	enc: encoding,
) (size | error) = {
	let p = parser {
		scanner = strings::iter(input),
		current = done,
		advance = &lex_permissive,
	};

	let exponent = false;
	let exponent_bracket = false;
	let exponent_sign = false;
	let count = 0z;
	const is_utf = enc == encoding::UTF8;

	for (let tok => advance(&p)) {

		if (exponent) {
			switch (tok.kind) {
			case token_kind::LPAREN, token_kind::LBRACE =>
				if (exponent_bracket || exponent_sign) { 
					return tok: unexpected_token; 
				};
				exponent_bracket = true;

			case token_kind::RPAREN, token_kind::RBRACE =>
				if (!exponent_bracket) { 
					return tok: unexpected_token;
				};
				exponent_bracket = false;
				exponent_sign = false;
				exponent = false;

			case token_kind::MINUS =>
				if (exponent_sign) {
					return tok: unexpected_token; 
				};
				exponent_sign = true;

				if (is_utf) {
					count += memio::appendrune(out, SUPERSCRIPT_MINUS)?;
				} else {
					count += memio::appendrune(out, HYPHEN_MINUS)?;
				};

			case token_kind::PLUS =>
				if (exponent_sign) {
					return tok: unexpected_token; 
				};
				exponent_sign = true;

			case token_kind::INTEGER =>
				if (is_utf) {
					count += write_str_as_superscript(out, tok.text)?;
				} else {
					count += write_string(out, tok.text)?;
				};
				exponent = exponent_bracket;
				exponent_sign = exponent_bracket;

			case token_kind::SUPER_INTEGER =>
				count += if (is_utf) {
					yield write_string(out, tok.text)?;
				} else {
					yield write_superscript_as_ascii(out, tok.text)?;
				};
				exponent = exponent_bracket;
				exponent_sign = exponent_bracket;
			case =>
				return tok: unexpected_token;
			};
			continue;
		};

		switch (tok.kind) {
		case token_kind::IDENTIFIER =>
			const kinds = identify(tok.text);
			count += write_symbol(out, kinds.0, enc)?;
			count += write_symbol(out, kinds.1, enc)?;

		case token_kind::SUPER_INTEGER =>
			if (is_utf) {
				count += write_string(out, tok.text)?;
			} else {
				count += memio::appendrune(out, CIRCUMFLEX_ACCENT)?;
				count += write_superscript_as_ascii(out, tok.text)?;
			};

		case token_kind::SUPER_PLUS =>
			exponent = true;
			exponent_sign = true;

		case token_kind::SUPER_MINUS, =>
			exponent = true;
			exponent_sign = true;

			if (is_utf) {
				count += memio::appendrune(out, SUPERSCRIPT_MINUS)?;
			} else {
				count += memio::appendrune(out, CIRCUMFLEX_ACCENT)?;
				count += memio::appendrune(out, HYPHEN_MINUS)?;
			};

		case token_kind::POWER =>
			exponent = true;
			if (!is_utf) { 
				count += memio::appendrune(out, CIRCUMFLEX_ACCENT)?;
			};

		case token_kind::MULTIPLY =>
			const operator = if (is_utf) DOT_OPERATOR else ASTERISK;
			count += memio::appendrune(out, operator)?;
		case token_kind::SOLIDUS =>
			count += memio::appendrune(out, SOLIDUS)?;
		case token_kind::LPAREN =>
			count += memio::appendrune(out, LEFT_PARENTHESIS)?;
		case token_kind::RPAREN =>
			count += memio::appendrune(out, RIGHT_PARENTHESIS)?;
		case token_kind::LBRACE =>
			count += memio::appendrune(out, LEFT_CURLY_BRACKET)?;
		case token_kind::RBRACE =>
			count += memio::appendrune(out, RIGHT_CURLY_BRACKET)?;
		case =>
			return tok: unexpected_token;
		};
	};

	if (exponent) {
		return invalid_exponent;
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
fn write_exponent(out: io::handle, n: int, enc: encoding) (size | error) = {
	let count = 0z;

	if (n == 0) return 0;

	const is_utf = enc == encoding::UTF8;

	if (!is_utf) {
		count += memio::appendrune(out, CIRCUMFLEX_ACCENT)?;
		count += write_string(out, strconv::itos(n))?;
		return count;
	};

	count += write_int_as_superscript(out, n)?;
	return count;
};

// Prints a quantity to a stream, optionally using a specified unit format, 
// precision, numeric notation, and character encoding.
// Returns the number of bytes printed.
fn write_quantity(
	out: io::handle,
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
		count += write_value(out, value, prec, repr, enc)?;
		count += memio::appendrune(out, ' ')?;
		count += write_unit(out, qty.unit, enc)?;
	case let s: str =>
		let target: unit = strpu(s)?;
		
		if (!equal(qty.unit.dim, target.dim)) {
			return dimension_mismatch;
		};

		const value: f64 = qty.value * qty.unit.scale / target.scale;

		count += write_value(out, value, prec, repr, enc)?;
		count += memio::appendrune(out, ' ')?;
		count += write_reformatted_unit(out, s, enc)?;

	};
	return count;
};


// Prints a quantity to an [[io::handle]], optionally using a specified unit
// format, precision, numeric notation, and character encoding.
// Returns the number of bytes printed.
fn write_unit(out: io::handle, u: unit, enc: encoding) (size | error) = {
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
		return encodejson(out, u);
	};

	const sym_mult = switch (enc) {
	case encoding::ASCII => yield ASTERISK;
	case encoding::UTF8 => yield DOT_OPERATOR;
	case encoding::JSON => yield unreachable();
	};


	let total: size = 0;
	for (let i = 0z; i < len(symbols_base); i += 1) {

		if (exponents[i] == 0) continue;

		if (!first) total += fmt::fprint(out, sym_mult)?;

		total += fmt::fprint(out, symbols_base[i])?;
		total += write_exponent(out, exponents[i], enc)?;
		first = false;
	};

	return total;
};

// Formats and prints x to handler h.
// Returns the number of bytes printed.
// See also: [[fprint]], [[println]].
export fn fprint(
	out: io::handle,
	x: (quantity | unit),
	ustr: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = {
	return match (x) {
	case let q: quantity =>
		yield write_quantity(out, q, ustr, prec, repr, enc)?;
	case let u: unit =>
		yield write_unit(out, u, enc)?;
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

