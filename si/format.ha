use fmt;
use io;
use os;
use strings;
use strconv;

fn sprint_f64(
	value: f64,
	prec: (uint|void) = void,
	repr: notation = notation::GENERAL,
	enc: encoding = encoding::UTF8,
) (str | nomem) = {
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
	// defer free(formatted);

	if (repr != notation::GENERAL && repr != notation::SCIENTIFIC) {
		return strings::dup(formatted);
	};
	
	assert(formatted != "");
	let pair: (str, str) = strings::cut(formatted, "e");
	if (pair.1 == "") {
		pair = strings::cut(formatted, "E");
	};
	if (pair.1 == "") {
		return strings::dup(formatted);
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

	let scale = switch (enc) {
		case encoding::ASCII => yield "*10";
		case encoding::UTF8 => yield "×10";
		case => abort("invalid encoding");
	};

	let out = strings::toutf8(pair.0);
	append_str(&out, scale)?;

	let superscript_exponent = int_to_superscript(exponent)?;
	defer free(superscript_exponent);

	append_str(&out, superscript_exponent)?;

	return strings::fromutf8(out)!;
};

// Print formatted float value to stdout.
fn print_f64(
	value: f64,
	prec: (uint|void) = void,
	repr: notation = notation::GENERAL,
) (size | io::error) = {
	const s = match (sprint_f64(value, prec, repr)) {
	case let s: str =>
		yield s;
	case nomem =>
		return nomem;
	};
	defer free(s);
	return fmt::print(s);
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

			const suffix = if (strings::hassuffix(text, "ohm")) {
				yield if (enc == encoding::UTF8) "Ω" else "ohm";
			} else if (strings::hassuffix(text, "degC")) {
				yield if (enc == encoding::UTF8) "°C" else "degC";
			} else if (strings::hassuffix(text, "deg")) {
				yield if (enc == encoding::UTF8) "°" else "deg";
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

// Prints a quantity to an [io::handle]. Returns the number of bytes printed.
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
		count += print_f64(value, prec, repr)!;
		count += fprintu(h, qty.unit)?;
	case let s: str =>
		let target: unit = parse_unit_str(s)?;
		
		if (!equal(qty.unit.dim, target.dim)) {
			return dimension_mismatch;
		};

		const value: f64 = qty.value * qty.unit.scale / target.scale;
		let formatted_value = sprint_f64(value, prec, repr)!;
		defer free(formatted_value);

		let formatted_unit = format_unit(s, enc)?;
		defer free(formatted_unit);

		count += fmt::fprintf(os::stdout, "{} {}", formatted_value, formatted_unit)!;
	};
	return count;
};

// Prints a unit to an [io::handle]. Returns the number of bytes printed.
export fn fprintu(h: io::handle, u: unit) (size | error) = {
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

	let total: size = 0;
	for (let i = 0z; i < len(symbols_base); i += 1) {
		if (exponents[i] == 0) {
			continue;
		};

		total += fmt::fprintf(h, "{}{}", if (first) "" else "·", symbols_base[i])!;
		first = false;

		if (exponents[i] != 1) {
			let exp: int = if (exponents[i] < 0) {
				total += fmt::fprintf(h, "{}", '\u207B')!;
				yield exponents[i]*-1;
			} else {
				yield exponents[i];
			};
			match(int_to_superscript(exp)) {
			case let s: str =>
				total += fmt::fprint(h, s)!;
			case =>
				void;
			};
		};
	};

	return total;
};

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

export fn fprintuln(h: io::handle, u: unit) (size | error) = {
	let count = fprintu(h, u)?;
	count += fmt::fprint(h, "\n")?;
	return count;
};
