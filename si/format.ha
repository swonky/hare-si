use fmt;
use io;
use os;
use strings;
use strconv;

fn fprintf64(
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
	count += fprintexp(h, exponent, enc)?;

	return count;
};

// output must be freed by the caller
fn int_to_superscript(i: int) (str | nomem) = {
	let n = if (i < 0) -i else i;
	let buf: [11]rune = ['\x00'...];
	let sz = 0z;

	if (i < 0) {
		buf[sz] = '⁻';
		sz += 1z;
	};

	if (n == 0) {
		buf[sz] = DIGIT_SUPER_ZERO;
		sz += 1z;
	} else {
		for (n > 0) {
			const digit = n % 10;
			buf[sz] = superscript_digits[digit: size];
			sz += 1z;
			n /= 10;
		};

		for (let j = if (i < 0) 1z else 0z; j < (sz - 1z + (if (i < 0) 1z else 0z)) / 2z; j += 1z) {
			let k = sz - 1z - (j - (if (i < 0) 1z else 0z));
			let tmp = buf[j];
			buf[j] = buf[k];
			buf[k] = tmp;
		};
	};

	return strings::fromrunes(buf[..sz]);
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

// Prints an exponent i to h with character encoding enc.
// 
//	fprintexp(os::stdout, 30, encoding::ASCII)
//	>> ^30
//
//	fprintexp(os::stdout, 30, encoding::UTF8)
//	>> ³⁰
//
fn fprintexp(h: io::handle, i: int, enc: encoding) (size | error) = {
	let count = 0z;

	if (i == 0) {
		return 0;
	};

	const is_utf = enc == encoding::UTF8;

	if (!is_utf) {
		count += fmt::fprint(h, CIRCUMFLEX_ACCENT)?;
	};

	let exp: int = if (i < 0) {
		const sym_minus = if (is_utf) SUPERSCRIPT_MINUS else HYPHEN_MINUS;
		count += fmt::fprint(h, sym_minus)?;
		yield i*-1;
	} else {
		yield i;
	};

	assert(exp > 0);

	let formatted = if (is_utf) {
		yield int_to_superscript(exp)?;
	} else {
		yield strings::dup(strconv::itos(exp))?;
	};
	defer free(formatted);
	count += fmt::fprint(h, formatted)?;

	return count;
};

// Prints a quantity to an [[io::handle]], optionally using a specified unit
// format, precision, numeric notation, and character encoding. Returns the
// number of bytes printed.
export fn fprintq(
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
		count += fprintf64(h ,value, prec, repr, enc)?;
		count += fmt::fprint(h, " ")?;
		count += fprintu(h, qty.unit, enc)?;
	case let s: str =>
		let target: unit = strpu(s)?;
		
		if (!equal(qty.unit.dim, target.dim)) {
			return dimension_mismatch;
		};

		const value: f64 = qty.value * qty.unit.scale / target.scale;

		count += fprintf64(h, value, prec, repr, enc)?;

		let formatted_unit = format_unit(s, enc)?;
		defer free(formatted_unit);

		count += fmt::fprintf(h, " {}", formatted_unit)!;
	};
	return count;
};

// Prints a quantity to an [[io::handle]], optionally using a specified unit
// format, precision, numeric notation, and character encoding. Returns the
// number of bytes printed.
export fn fprintu(h: io::handle, u: unit, enc: encoding) (size | error) = {
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

		if (exponents[i] == 0) { continue; };

		if (!first) {
			total += fmt::fprint(h, sym_mult)?;
		};

		total += fmt::fprint(h, symbols_base[i])?;
		total += fprintexp(h, exponents[i], enc)?;
		first = false;
	};

	return total;
};

// Prints a quantity followed by a newline to an [[io::handle]]. Accepts the
// same formatting options as [[fprintq]]. Returns the number of bytes printed.
export fn fprintqln(
	h: io::handle,
	qty: quantity,
	unit_format: (str | void) = void,
	prec: (uint | void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (size | error) = {
	let count = fprintq(h, qty, unit_format, prec, repr, enc)?;
	count += fmt::fprint(h, "\n")?;
	return count;
};

// Prints a unit followed by a newline to an [[io::handle]]. Returns the
// number of bytes printed.
fn fprintuln(h: io::handle, u: unit, enc: encoding) (size | error) = {
	let count = fprintu(h, u, enc)?;
	count += fmt::fprint(h, "\n")?;
	return count;
};
