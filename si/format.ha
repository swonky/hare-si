use fmt;
use io;
use strings;
use strconv;

export type notation = enum u8 {
	GENERAL,
	FIXED,
	SCIENTIFIC,
	E_UPPER,
	E_LOWER,
};

type encoding = enum u8 { ASCII, UTF8 };

type format_options = struct {
	enc: encoding,
};

def default_format_options = format_options { enc = encoding::UTF8 };

fn sprint_f64(f: f64, prec: (uint|void) = void, notation: notation = notation::GENERAL) (str | nomem) = {
	const format = switch (notation) {
	case notation::FIXED =>
		yield strconv::ffmt::F;
	case notation::SCIENTIFIC, notation::E_UPPER, notation::E_LOWER =>
		yield strconv::ffmt::E;
	case notation::GENERAL =>
		yield strconv::ffmt::G;
	};

	const flags = switch (notation) {
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

	const s = strconv::ftosf(f, format, prec, flags)?;
	defer free(s);

	if (notation != notation::GENERAL && notation != notation::SCIENTIFIC) {
		return strings::dup(s);
	};
	
	let pair: (str, str) = strings::cut(s, "e");
	if (pair.1 == "") {
		pair = strings::cut(s, "E");
	};
	if (pair.1 == "") {
		return strings::dup(s);
	};

	const exp = match (strconv::stoi(pair.1)) {
	case let exp: int =>
		yield exp;
	case =>
		abort("invalid exponent from strconv");
	};

	let out = strings::toutf8(pair.0);
	append_str(&out, "×10")?;

	match (append_superscript(&out, strconv::itos(exp))) {
	case void => void;
	case nomem => return nomem;
	case invalid_exponent => abort("invalid exponent");
	};

	return strings::fromutf8(out)!;
};

fn print_f64(f: f64, prec: (uint|void) = void, notation: notation = notation::GENERAL) (size | io::error) = {
	const s = match (sprint_f64(f, prec, notation)) {
	case let s: str =>
		yield s;
	case nomem =>
		return nomem;
	};
	defer free(s);

	return fmt::print(s);
};

fn int_to_superscript(i: int) (rune | void) = switch (i) {
	case 0 => yield DIGIT_SUPER_ZERO;
	case 1 => yield DIGIT_SUPER_ONE;
	case 2 => yield DIGIT_SUPER_TWO;
	case 3 => yield DIGIT_SUPER_THREE;
	case 4 => yield DIGIT_SUPER_FOUR;
	case 5 => yield DIGIT_SUPER_FIVE;
	case 6 => yield DIGIT_SUPER_SIX;
	case 7 => yield DIGIT_SUPER_SEVEN;
	case 8 => yield DIGIT_SUPER_EIGHT;
	case 9 => yield DIGIT_SUPER_NINE;
	case => yield void;
};

fn rune_to_superscript(i: rune) (rune | void) = switch (i) {
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

fn format_unit(input: str, opts: format_options = default_format_options) (str | error) = {
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
			if (len(tok.text) > 1 && strings::hasprefix(tok.text, "u")) {
				append_str(&out, "µ")?;
				append_str(&out, strings::sub(tok.text, 1))?;
			} else {
				const text = switch (tok.text) {
				case "ohm" =>
					yield "Ω";
				case "degC" =>
					yield "°C";
				case "deg" =>
					yield "°";
				case =>
					yield tok.text;
				};
				append_str(&out, text)?;
			};
		case token_kind::INTEGER =>
			append_str(&out, tok.text)?;
		case token_kind::PLUS =>
			append_str(&out, "+")?;
		case token_kind::MINUS =>
			append_str(&out, "−")?;
		case token_kind::POWER =>
			exponent = true;
		case token_kind::MULTIPLY =>
			append_str(&out, "·")?;
		case token_kind::SOLIDUS =>
			append_str(&out, "/")?;
		case token_kind::LPAREN =>
			append_str(&out, "(")?;
		case token_kind::RPAREN =>
			append_str(&out, ")")?;
		case =>
			return '0': unexpected_token;
		};
	};

	return strings::fromutf8(out)!;
};
