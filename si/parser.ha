// SPDX-License-Identifier: MPL-2.0
// (c) Tom Spencer <https://codeberg.org/swonky/hare-si>

use fmt;
use io;
use math;
use os;
use strconv;
use strings;
use types;

// State machine for recursive-descent parsing.
type parser = struct {
	scanner: strings::iterator,
	advance: *lexer,
	current: (token | done),
};

// Advances the scanner and returns the next token.
fn advance(p: *parser) (token | done) = {
	p.current = p.advance(&p.scanner);
	return p.current;
};

// Returns the name of the unit associated by k.
fn lookup_name(k: unit_kind) str  = unit_names[k: size];

// Returns the unit associated with k
fn lookup_unit(k: unit_kind) unit = units[k: size];

// Returns the product of x and 10 to the power of p.
fn scale10(x: f64, p: int) f64 = {
	if (p == 0) return x;
	const sign = math::signi(p): int;
		
	p = p * sign;

	let factor = if (sign == -1) 0.1 else 10.0;

	for (p > 0) {
		if (p % 2 == 1) x *= factor;
		factor *= factor;
		p /= 2;
	};

	return x;
};

// Returns the left and right parts of the input string cut at index n.
// If n is equal to or greater than the length of the string, the second
// part will be empty.
// Output is borrowed from input string.
fn ncut(input: str, n: size) (str, str) = {
	if (n >= count(input)) {
		return (input, "");
	};
	const prefix = strings::sub(input, 0, n);
	const suffix = strings::sub(input, n);
	return (prefix, suffix);
};

// Returns the decimal prefix and unit symbol componants of the input string.
// If the input string does not match any prefix or unit symbol, the first 
// componant of the tuple will be empty.
// Output is trimmed and borrowed from input string.
export fn identify(in: str) (prefix_kind, unit_kind) = {
	const tr = strings::trim(in);
	match (match_suffix(tr)) {
	case let u: unit_kind =>
		return (prefix_kind::NONE, u);
	case =>
		void;
	};
	
	const sz = count(tr);
	if (sz <= 1) {
		return (prefix_kind::NONE, unit_kind::NONE);
	};

	if (sz >= 3) {
		if (strings::hasprefix(tr, sym_deca)) {
			const parts = ncut(tr, 2z);
			match (match_suffix(parts.1)) {
			case let k: unit_kind =>
				return (prefix_kind::DECA, k);
			case void =>
				void;
			};
		};
	};

	const parts = ncut(tr, 1z);

	const pk = match (match_prefix(parts.0)) {
	case let k: prefix_kind => 
		yield k;
	case => 
		yield prefix_kind::NONE;
	};

	const uk = match (match_suffix(parts.1)) {
	case let k: unit_kind => 
		yield k;
	case => 
		yield unit_kind::NONE;
	};

	return (pk, uk);
};

// Searches an ordered symbol array for s.
// Returns void if not found.
fn match_symbol(s: str, table: []symbol) (symbol_kind | void) = {
	let lo = 0z;
	let hi = len(table);
	for (lo < hi) {
		const mid = lo + (hi - lo) / 2z;
		const cmp = strings::compare(table[mid].repr, s);
		if (cmp < 0) {
			lo = mid + 1z;
		} else if (cmp > 0) {
			hi = mid;
		} else {
			return table[mid].kind;
		};
	};
	return void;
};

// Returns the kind of prefix symbol matching s.
// Returns void if not found.
// Wrapper for [[match_symbol]].
fn match_prefix(in: str) (prefix_kind | void) = {
	return match (match_symbol(in, prefix_lookup)) {
	case let value: prefix_kind => yield value;
	case let value: void => yield value;
	case => unreachable("incorrect lookup table");
	};
};

// Returns the kind of unit symbol matching s.
// Returns void if not found.
// Wrapper for [[match_symbol]].
fn match_suffix(in: str) (unit_kind | void) = {
	return match (match_symbol(in, symbol_lookup)) {
	case let value: unit_kind => yield value;
	case let value: void => yield value;
	case => unreachable("incorrect lookup table");
	};
};

fn parse_symbol(s: str) (unit | void) = {
	const sz: size = count(s);
	if (sz == 0) {
		return void;
	};

	match (match_suffix(s)) {
	case let kind: unit_kind =>
		return lookup_unit(kind);
	case =>
		void;
	};

	if (sz == 1) {
		return void;
	};

	for (let i = 0z; i < len(prefix_symbols_utf8); i += 1) {
		const pref = prefix_lookup[i];
		const psz = count(pref.repr);
		if (sz <= psz) {
			continue;
		};
		if (!strings::hasprefix(s, pref.repr)) {
			continue;
		};

		const kind = match (pref.kind) {
		case let k: prefix_kind =>
			yield k;
		case =>
			abort("invalid lookup table");
		};

		const scale = prefix_scale[kind: size];
		const suffix = strings::sub(s, psz);
		return match (match_suffix(suffix)) {
		case let kind: unit_kind =>
			let u: unit = lookup_unit(kind);
			u.scale *= scale;
			yield u;
		case void =>
			yield void;
		};
	};
	return void;
};

fn parse_primary(p: *parser) (unit | error) = {
	match (p.current) {
	case let tok: token =>
		switch (tok.kind) {
		case token_kind::IDENTIFIER =>
			advance(p);
			match (parse_symbol(tok.text)) {
			case let u: unit =>
				return u;
			case void =>
				return tok.text: no_match;
			};
		case token_kind::LPAREN, token_kind::LBRACE =>
			const closing = if (tok.kind == token_kind::LPAREN) {
				yield token_kind::RPAREN;
			} else {
				yield token_kind::RBRACE;
			};

			advance(p);

			const result = parse_unit(p)?;

			match (p.current) {
			case let tok: token =>
				if (tok.kind != closing) {
					return tok: unexpected_token;
				};
				advance(p);
			case done =>
				return unclosed_scope;
			};

			return result;

		case =>
			return tok: unexpected_token;
		};
	case done =>
		return unclosed_scope;
	};
};

fn parse_factor(p: *parser) (unit | error) = {
	let result = parse_primary(p)?;

	let tok = match (p.current) {
	case let tok: token =>
		yield tok;
	case done =>
		return result;
	};

	return switch (tok.kind) {
	case token_kind::POWER =>
		advance(p);

		let sign: i8 = 1;

		match (p.current) {
		case let tok: token =>
			switch (tok.kind) {
			case token_kind::PLUS =>
				advance(p);
			case token_kind::MINUS =>
				sign = -1;
				advance(p);
			case =>
				void;
			};
		case done =>
			return invalid_exponent;
		};

		const tok = match (p.current) {
		case let tok: token =>
			if (tok.kind != token_kind::INTEGER) {
				return tok: unexpected_token;
			};
			yield tok;
		case done =>
			return invalid_exponent;
		};

		advance(p);
		yield powu(result, sign * strconv::stoi8(tok.text)?);

	case token_kind::SUPER_INTEGER =>
		advance(p);
		yield powu(result, parse_superscript(tok.text)?);

	case token_kind::SUPER_PLUS, token_kind::SUPER_MINUS =>
		const sign: i8 = if (tok.kind == token_kind::SUPER_MINUS) -1 else 1;
		advance(p);

		const tok = match (p.current) {
		case let tok: token =>
			if (tok.kind != token_kind::SUPER_INTEGER) {
				return tok: unexpected_token;
			};
			yield tok;
		case done =>
			return invalid_exponent;
		};

		advance(p);
		yield powu(result, sign * strconv::stoi8(tok.text)?);

	case =>
		yield result;
	};
};

fn parse_superscript(s: str) (int | error) = {
	let iter = strings::iter(s);
	let sign = 1;
	let value = 0;

	match (strings::next(&iter)) {
	case done =>
		return invalid_exponent;
	case let c: rune =>
		switch (c) {
		case SUPERSCRIPT_MINUS =>
			sign = -1;
		case SUPERSCRIPT_PLUS_SIGN =>
			void;
		case =>
			iter = strings::iter(s);
		};
	};

	let digits = 0z;

	for (const c => strings::next(&iter)) {
		const digit = switch (c) {
		case DIGIT_SUPER_ZERO => yield 0;
		case DIGIT_SUPER_ONE => yield 1;
		case DIGIT_SUPER_TWO => yield 2;
		case DIGIT_SUPER_THREE => yield 3;
		case DIGIT_SUPER_FOUR => yield 4;
		case DIGIT_SUPER_FIVE => yield 5;
		case DIGIT_SUPER_SIX => yield 6;
		case DIGIT_SUPER_SEVEN => yield 7;
		case DIGIT_SUPER_EIGHT => yield 8;
		case DIGIT_SUPER_NINE => yield 9;
		case =>
			return invalid_exponent;
		};

		if (value > (types::INT_MAX - digit) / 10) {
			return invalid_exponent;
		};

		value = value * 10 + digit;
		digits += 1z;
	};

	if (digits == 0z) {
		return invalid_exponent;
	};

	if (sign < 0) {
		if (value == types::INT_MAX + 1) {
			return types::INT_MIN;
		};
		return -value;
	};

	return value;
};

// Parses a units.
fn parse_unit(p: *parser) (unit | error) = {
	let start: parser = *p;
	let result = parse_factor(p)?;

	for (true) {
		match (p.current) {
		case let tok: token =>
			switch (tok.kind) {
			case token_kind::MULTIPLY =>
				advance(p);
				const rhs = parse_factor(p)?;
				result = mulu(result, rhs);
			case token_kind::SOLIDUS =>
				advance(p);
				const rhs = parse_factor(p)?;
				return divu(result, rhs);
			case =>
				return result;
			};
		case done =>
			return result;
		};
	};
};

// Parses float values.
fn parse_value(p: *parser) (f64 | strconv::invalid | strconv::overflow) = {
	const start: parser = *p;
	let next: parser = *p;

	for (let tok => advance(&next)) {
		switch (tok.kind) {
		case token_kind::INTEGER, token_kind::POINT,
			token_kind::COMMA, token_kind::EXPONENT,
			token_kind::PLUS, token_kind::MINUS =>
			advance(p);
		case =>
			break;
		};
	};

	const text = strings::slice(&start.scanner, &p.scanner);
	const parts = strings::cut(text, "e");
	const mantissa = strconv::stof64(parts.0)?;
	const exponent = strconv::stoi(parts.1)?;

	return if (count(parts.1) == 0) mantissa else scale10(mantissa, exponent);
};

// Parse a quantity
fn parse_quantity(p: *parser) (quantity | error) = {
	const v: f64  = parse_value(p)?;
	advance(p);
	const u: unit = parse_unit(p)?;
	return quantity { unit = u, value = v };
};

fn remainder(s: *strings::iterator) str = {
	const start = *s;
	for (let r => strings::next(s)) {
		void;
	};
	return strings::slice(&start, s);
};

export fn split(input: str) (f64, str) = {
	let p = parser {
		scanner = strings::iter(input),
	    	current = done,
		advance = &lex_permissive,
	};

	const v: f64 = match (parse_value(&p)) {
	case let f: f64 =>
		yield f;
	case =>
		yield 0.0;
	};

	const rest = remainder(&p); 

	return (v, strings::trim(rest));
};

// Parses a unit expression. Accepts fixed-point and scientific notation, with 
// permissive unit syntax including alternative multiplication operators 
// (*, ×, ·, ⋅), exponent notation (^, **, superscripts), exponent signs (+, −),
// grouping (( ), { }), ASCII or UTF-8 encoded symbols, alternative micro (µ, μ) 
// and ohm (Ω, Ω) symbols. Whitespace is permitted.
//
// Valid examples:
// 	strpu("m");
// 	strpu("m/s^2");
// 	strpu("°C");
// 	strpu("kΩ");
// 	strpu("kohm");
// 	strpu("mol**-1");
// 	strpu("m²");
//
// Returns the parsed [[unit]] on success, or an [[error]] if the input is invalid.
//
// - see also: [[strp]]
export fn strpu(s: str) (unit | error) = {
	let p = parser {
		scanner = strings::iter(s),
	    	current = done,
		advance = &lex_permissive,
	};

	advance(&p);

	const result = parse_unit(&p)?;

	match (p.current) {
	case done =>
		return result;
	case =>
		return invalid;
	};
};

// Parses a numeric quantity and unit expression. Accepts fixed-point and
// scientific notation, with permissive unit syntax including alternative
// multiplication operators (*, ×, ·, ⋅), exponent notation (^, **, superscripts),
// exponent signs (+, −), grouping (( ), { }), ASCII or UTF-8 encoded symbols, 
// alternative micro (µ, μ) and ohm (Ω, Ω) symbols. Whitespace is permitted.
//
// Valid examples:
// 	strp("67 m");
// 	strp("1.21 GW");
// 	strp("9.80665 m/s^2");
// 	strp("32°C");
// 	strp("1.5 kΩ");
// 	strp("1.5 kohm");
// 	strp("6.022e23 mol**-1");
// 	strp("20 m²");
//
// Returns the parsed [[quantity]] on success, or an [[error]] if the input is invalid.
//
// - see also: [[strpu]]
export fn strp(s: str) (quantity | error) = {
	let p = parser {
		scanner = strings::iter(s),
	    	current = done,
		advance = &lex_permissive,
	};

	const result = parse_quantity(&p)?;

	match (p.current) {
	case done =>
		return result;
	case =>
		return invalid;
	};
};
