use ascii;
use fmt;
use strings;
use os;
use encoding::utf8;

type not_an_int = !void;

type token_kind = enum u8 {
	UNSPECIFIED,
	IDENTIFIER,

	INTEGER,
	INTEGER_SUPER,
	INTEGER_SUB,

	MULTIPLY,       // ., ·, *
	POWER,          // **, ^
	SOLIDUS,        // /

	PLUS,
	MINUS,
	SUPER_PLUS,
	SUPER_MINUS,

	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,
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

// Horizontal whitespace
def SPACE_NO_BREAK             : rune = '\u00A0';
def SPACE_THIN                 : rune = '\u2009';
def SPACE_NARROW_NO_BREAK      : rune = '\u202F';
def SPACE_IDEOGRAPHIC          : rune = '\u3000';

// Mu variants
def LETTER_MICRO_SIGN          : rune = '\u00B5'; // µ
def LETTER_GREEK_SMALL_MU      : rune = '\u03BC'; // μ

// Omega variants
def LETTER_GREEK_CAPITAL_OMEGA : rune = '\u03A9'; // Ω
def OHM_SIGN                   : rune = '\u2126'; // Ω

// Middle dots and related symbols
def DOT_MIDDLE                 : rune = '\u00B7'; // ·
def DOT_HYPHENATION            : rune = '\u2027'; // ‧
def DOT_BULLET_OPERATOR        : rune = '\u2219'; // ∙
def DOT_OPERATOR               : rune = '\u22C5'; // ⋅
def DOT_LATIN_SINOLOGICAL      : rune = '\uA78F'; // ꞏ

// Superscript digits
def DIGIT_SUPER_ZERO           : rune = '\u2070'; // ⁰
def DIGIT_SUPER_ONE            : rune = '\u00B9'; // ¹
def DIGIT_SUPER_TWO            : rune = '\u00B2'; // ²
def DIGIT_SUPER_THREE          : rune = '\u00B3'; // ³
def DIGIT_SUPER_FOUR           : rune = '\u2074'; // ⁴
def DIGIT_SUPER_FIVE           : rune = '\u2075'; // ⁵
def DIGIT_SUPER_SIX            : rune = '\u2076'; // ⁶
def DIGIT_SUPER_SEVEN          : rune = '\u2077'; // ⁷
def DIGIT_SUPER_EIGHT          : rune = '\u2078'; // ⁸
def DIGIT_SUPER_NINE           : rune = '\u2079'; // ⁹

// Sign operators
def PLUS_SIGN                  : rune = '\u002B'; // +
def SUPERSCRIPT_PLUS_SIGN      : rune = '\u207A'; // ⁺
def HYPHEN_MINUS               : rune = '\u002D'; // -
def HYPHEN                     : rune = '\u2010'; // ‐
def MINUS_SIGN                 : rune = '\u2212'; // −
def SUPERSCRIPT_MINUS          : rune = '\u207B'; // ⁻

// Binary operators
def ASTERISK                   : rune = '\u002A'; // *
def ASTERISK_OPERATOR          : rune = '\u2217'; // ∗
def STAR_OPERATOR              : rune = '\u22C6'; // ⋆
def MULTIPLICATION_SIGN        : rune = '\u00D7'; // ×
def SOLIDUS                    : rune = '\u002F'; // /
def CIRCUMFLEX_ACCENT          : rune = '\u005E'; // ^
def INVISIBLE_TIMES            : rune = '\u2062';

// Brackets
def LEFT_PARENTHESIS           : rune = '\u0028'; // (
def RIGHT_PARENTHESIS          : rune = '\u0029'; // )
def LEFT_CURLY_BRACKET         : rune = '\u007B'; // {
def RIGHT_CURLY_BRACKET        : rune = '\u007D'; // }

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

fn is_mu(c: rune) bool = 
	c == LETTER_MICRO_SIGN 
	|| c == LETTER_GREEK_SMALL_MU;

fn is_omega(c: rune) bool =
	c == LETTER_GREEK_CAPITAL_OMEGA
	|| c == OHM_SIGN;

fn is_ident(c: rune) bool =
	ascii::isalpha(c)
	|| is_mu(c)
	|| is_omega(c);

fn is_middle_dot(c: rune) bool = switch (c) {
	case DOT_MIDDLE, DOT_HYPHENATION, DOT_BULLET_OPERATOR, DOT_OPERATOR, DOT_LATIN_SINOLOGICAL =>
		yield true;
	case =>
		yield false;
};

fn is_digit_super(c: rune) bool = switch (c) {
	case DIGIT_SUPER_ZERO, DIGIT_SUPER_ONE, DIGIT_SUPER_TWO, DIGIT_SUPER_THREE, DIGIT_SUPER_FOUR, DIGIT_SUPER_FIVE, DIGIT_SUPER_SIX, DIGIT_SUPER_SEVEN, DIGIT_SUPER_EIGHT, DIGIT_SUPER_NINE =>
		yield true;
	case =>
		yield false;
};

fn to_int(c: rune) (int | not_an_int) = {
	if (ascii::isdigit(c)) {
		return (c: i32 - '0': i32): int;
	};
	return switch (c) {
	case DIGIT_SUPER_ZERO =>
		yield 0;
	case DIGIT_SUPER_ONE =>
		yield 1;
	case DIGIT_SUPER_TWO =>
		yield 2;
	case DIGIT_SUPER_THREE =>
		yield 3;
	case DIGIT_SUPER_FOUR =>
		yield 4;
	case DIGIT_SUPER_FIVE =>
		yield 5;
	case DIGIT_SUPER_SIX =>
		yield 6;
	case DIGIT_SUPER_SEVEN =>
		yield 7;
	case DIGIT_SUPER_EIGHT =>
		yield 8;
	case DIGIT_SUPER_NINE =>
		yield 9;
	case =>
		yield not_an_int;
	};
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

fn next_token(s: *strings::iterator) (token | done) = {

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
		kind = token_kind::INTEGER_SUPER;
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

export fn main() void = {
	if (len(os::args) < 2) {
		return;
	};
	const s: str = os::args[1];
	let scanner: strings::iterator = strings::iter(s);
	let buffer: [1024]u8 = [0...];
	for (let c => next_token(&scanner)) {
		let n: int = c.kind: int;
		fmt::printf("[{}:{}] ", c.text, n)!;
	};

};
