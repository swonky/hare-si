// SPDX-License-Identifier: MPL-2.0
// (c) Tom Spencer <https://codeberg.org/swonky/hare-si>

use ascii;
use fmt;
use strings;
use os;
use encoding::utf8;

type lexer = fn(_: *strings::iterator) (token | done);

type token_kind = enum u8 {
	UNSPECIFIED,
	IDENTIFIER,
	INTEGER,
	SUPER_INTEGER,
	MULTIPLY,
	POWER,
	SOLIDUS,
	PLUS,
	SUPER_PLUS,
	MINUS,
	SUPER_MINUS,
	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,
	EXPONENT,
	POINT,
	COMMA,
};

type token = struct {
	kind: token_kind,
	text: str,
};

fn make_token(
	start: *strings::iterator, 
	end: *strings::iterator, 
	kind: token_kind,
) token = {
	return token {
		kind = kind,
		text = strings::slice(start, end),
	};
};

fn is_space(c: rune) bool = {
	if (ascii::isspace(c)) {
		return true;
	};
	return switch (c) {
	case SPACE_NO_BREAK, SPACE_THIN, SPACE_NARROW_NO_BREAK, SPACE_IDEOGRAPHIC =>
		yield true;
	case =>
		yield false;
	};
};

fn is_mu(c: rune) bool = c == LETTER_MICRO_SIGN || c == LETTER_GREEK_SMALL_MU;
fn is_omega(c: rune) bool = c == LETTER_GREEK_CAPITAL_OMEGA || c == OHM_SIGN;
fn is_ident(c: rune) bool = ascii::isalpha(c) || is_mu(c) || is_omega(c);

fn is_middle_dot(c: rune) bool = switch (c) {
	case DOT_MIDDLE, DOT_HYPHENATION, DOT_BULLET_OPERATOR, 
		DOT_OPERATOR, DOT_LATIN_SINOLOGICAL =>
		yield true;
	case =>
		yield false;
};

fn is_digit_super(c: rune) bool = switch (c) {
	case DIGIT_SUPER_ZERO, DIGIT_SUPER_ONE, DIGIT_SUPER_TWO, DIGIT_SUPER_THREE, 
		DIGIT_SUPER_FOUR, DIGIT_SUPER_FIVE, DIGIT_SUPER_SIX, DIGIT_SUPER_SEVEN, 
		DIGIT_SUPER_EIGHT, DIGIT_SUPER_NINE =>
		yield true;
	case =>
		yield false;
};

fn next_rune(s: *strings::iterator) (rune | done) = {
	return match (utf8::next(s)) {
	case (utf8::more | utf8::invalid) =>
		abort("invalid UTF-8 code point");
	case let result: (rune | done) =>
		yield result;
	};
};

fn peek_rune(s: *strings::iterator) (rune | done) = {
	let copy = *s;
	return next_rune(&copy);
};

fn is_exponent_prefix(r: rune) bool = {
	if (ascii::isdigit(r)) {
		return true;
	};
	return switch (r) {
	case PLUS_SIGN, HYPHEN, HYPHEN_MINUS, MINUS_SIGN =>
		yield true;
	case =>
		yield false;
	};
};

fn lex_permissive(s: *strings::iterator) (token | done) = {
	for (true) {
		const start: strings::iterator = *s;
		const c = match (next_rune(s)) {
		case done =>
			return done;
		case let c: rune =>
			yield c;
		};
		if (!is_space(c)) {
			*s = start;
			break;
		};
	};

	const start: strings::iterator = *s;

	const c = match (next_rune(s)) {
	case done =>
		return done;
	case let c: rune =>
		yield c;
	};

	const kind = switch (c) {
	case ASTERISK, ASTERISK_OPERATOR =>
		yield match (peek_rune(s)) {
		case done =>
			yield token_kind::MULTIPLY;
		case let next: rune =>
			yield if (c == next) {
				next_rune(s);
				yield token_kind::POWER;
			} else {
				yield token_kind::MULTIPLY;
			};
		};
	case 'e' =>
		yield match (peek_rune(s)) {
		case done =>
			yield token_kind::EXPONENT;
		case let next: rune =>
			yield if (is_exponent_prefix(next)) {
				yield token_kind::EXPONENT;
			} else {
				yield token_kind::UNSPECIFIED;
			};
		};
	case DOT_MIDDLE, DOT_OPERATOR, MULTIPLICATION_SIGN, INVISIBLE_TIMES =>
		yield token_kind::MULTIPLY;
	case CIRCUMFLEX_ACCENT =>
		yield token_kind::POWER;
	case SOLIDUS =>
		yield token_kind::SOLIDUS;
	case LEFT_PARENTHESIS =>
		yield token_kind::LPAREN;
	case RIGHT_PARENTHESIS =>
		yield token_kind::RPAREN;
	case LEFT_CURLY_BRACKET =>
		yield token_kind::LBRACE;
	case RIGHT_CURLY_BRACKET =>
		yield token_kind::RBRACE;
	case PLUS_SIGN =>
		yield token_kind::PLUS;
	case HYPHEN, HYPHEN_MINUS, MINUS_SIGN =>
		yield token_kind::MINUS;
	case SUPERSCRIPT_PLUS_SIGN =>
		yield token_kind::SUPER_PLUS;
	case SUPERSCRIPT_MINUS =>
		yield token_kind::SUPER_MINUS;
	case FULL_STOP =>
		yield token_kind::POINT;
	case COMMA =>
		yield token_kind::COMMA;
	case =>
		yield token_kind::UNSPECIFIED;
	};

	if (kind != token_kind::UNSPECIFIED &&
		kind != token_kind::INTEGER) {
		return make_token(&start, s, kind);
	};

	let pred: *fn(_: rune) bool = @undefined;

	if (ascii::isdigit(c)) {
		kind = token_kind::INTEGER;
		pred = &ascii::isdigit;
	} else if (is_digit_super(c)) {
		kind = token_kind::SUPER_INTEGER;
		pred = &is_digit_super;
	} else if (is_ident(c)){
		kind = token_kind::IDENTIFIER;
		pred = &is_ident;
	} else {
		abort("unrecognised");
	};

	for (true) {
		const c = match (peek_rune(s)) {
		case done =>
			break;
		case let c: rune =>
			yield c;
		};
		if (!pred(c)) {
			break;
		};
		next_rune(s);
	};

	return make_token(&start, s, kind);
};

fn lex_restricted(s: *strings::iterator) (token | done) = {
	for (true) {
		const start: strings::iterator = *s;
		const c = match (next_rune(s)) {
		case done =>
			return done;
		case let c: rune =>
			yield c;
		};
		if (!is_space(c)) {
			*s = start;
			break;
		};
	};

	const start: strings::iterator = *s;

	const c = match (next_rune(s)) {
	case done =>
		return done;
	case let c: rune =>
		yield c;
	};

	const kind = switch (c) {
	case '+' =>
		yield token_kind::PLUS;
	case '-' =>
		yield token_kind::MINUS;
	case '^' =>
		yield token_kind::POWER;
	case '*' =>
		yield token_kind::MULTIPLY;
	case '/' =>
		yield token_kind::SOLIDUS;
	case '(' =>
		yield token_kind::LPAREN;
	case ')' =>
		yield token_kind::RPAREN;
	case =>
		yield token_kind::UNSPECIFIED;
	};

	if (kind != token_kind::UNSPECIFIED) {
		return make_token(&start, s, kind);
	};

	let pred: *fn(_: rune) bool = @undefined;

	if (ascii::isdigit(c)) {
		kind = token_kind::INTEGER;
		pred = &ascii::isdigit;
	} else if (is_ident(c)) {
		kind = token_kind::IDENTIFIER;
		pred = &is_ident;
	} else {
		abort("unrecognised character");
	};

	for (true) {
		const c = match (peek_rune(s)) {
		case done =>
			break;
		case let c: rune =>
			yield c;
		};

		if (!pred(c)) {
			break;
		};

		next_rune(s);
	};

	return make_token(&start, s, kind);
};
