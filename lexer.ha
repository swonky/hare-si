use ascii;
use encoding::utf8;
use fmt;
use strings;
use os;
use unicode;

// type encoding = !void;
// type unexpected = !void;
//
// type error = encoding | unexpected;
//
//
//
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
	pos: size,
};

type predicate = fn(rune) bool;

export type scanner = struct {
	utf8::decoder,
};

export fn scan(src: str) scanner = scanner { src = strings::toutf8(src), ... };

fn next_rune(s: *scanner) (rune | done) = {
	return match (utf8::next(s)) {
	case (utf8::more | utf8::invalid) =>
		abort("invalid UTF-8 code point");
	case let result: (rune | done) =>
		yield result;
	}
};

fn peek_rune(s: *scanner) (rune | done) = {
	let copy = *s;
	return next_rune(&copy);
};


fn next_token(s: *scanner) (token | done) = {
	// Skip whitespace.
	for (true) {
		const start: scanner = *s;
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

	const start: scanner = *s;

	const c = match (next_rune(s)) {
	case done =>
		return done;
	case let c: rune =>
		yield c;
	};

	const kind = switch (c) {
	case '*' =>
		const next = peek_rune(s);
		if (next == '*') {
			next_rune(s);
			yield token_kind::POWER;
		};
		yield token_kind::MULTIPLY;
	case '^' =>
		yield token_kind::POWER;
	case '×', '·', '.' =>
		yield token_kind::MULTIPLY;
	case '/' =>
		yield token_kind::SOLIDUS;
	case '(' =>
		yield token_kind::LPAREN;
	case ')' =>
		yield token_kind::RPAREN;
	case '{' =>
		yield token_kind::LBRACE;
	case '}' =>
		yield token_kind::RBRACE;
	case '+' =>
		yield token_kind::PLUS;
	case '-' =>
		yield token_kind::MINUS;
	case '⁺' =>
		yield token_kind::SUPER_PLUS;
	case '⁻' =>
		yield token_kind::SUPER_MINUS;
	case =>
		yield token_kind::UNSPECIFIED;
	};

	// Single-character token.
	if (kind != token_kind::UNSPECIFIED &&
		kind != token_kind::INTEGER) {
		return make_token(&start, s, kind);
	};

	let pred: predicate;
	if (is_digit(c)) {
		kind = token_kind::INTEGER;
		pred = is_digit;
	} else if (is_digit_super(c)) {
		kind = token_kind::INTEGER_SUPER;
		pred = is_digit_super;
	} else if (is_digit_sub(c)) {
		kind = token_kind::INTEGER_SUB;
		pred = is_digit_sub;
	} else {
		kind = token_kind::IDENTIFIER;
		pred = is_ident;
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
	let scanner: scanner = scan(s);
	let buffer: [1024]u8 = [0...];
	for (let c => next_token(&scanner)) {
		let n: int = c.token: int;
		fmt::printf("{}", n)!;
	};
};
