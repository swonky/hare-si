use fmt;
use io;
use math;
use strconv;
use strings;
use os;

fn to_ascii(sym: unit_kind) str = symbols_ascii[sym: size];
fn to_utf8(sym: unit_kind) str  = symbols_utf8[sym: size];

fn lookup_name(sym: unit_kind) str  = unit_names[sym: size];
fn lookup_unit(sym: unit_kind) unit = units[sym: size];

fn match_symbol(s: str) (unit_kind | void) = {
	// TODO: logging
	// fmt::printf("matching: {}\n", s)!;
	let lo = 0z;
	let hi = len(symbol_lookup);
	for (lo < hi) {
		const mid = lo + (hi - lo) / 2z;
		const cmp = strings::compare(symbol_lookup[mid].repr, s);
		if (cmp < 0) {
			lo = mid + 1z;
		} else if (cmp > 0) {
			hi = mid;
		} else {
			return symbol_lookup[mid].kind;
		};
	};
	return void;
};

fn mult_dim(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        + b.mass,
	length      = a.length      + b.length,
	time        = a.time        + b.time,
	current     = a.current     + b.current,
	temperature = a.temperature + b.temperature,
	substance   = a.substance   + b.substance,
	luminosity  = a.luminosity  + b.luminosity,
};

fn div_dim(a: dimension, b: dimension) dimension = dimension {
	mass        = a.mass        - b.mass,
	length      = a.length      - b.length,
	time        = a.time        - b.time,
	current     = a.current     - b.current,
	temperature = a.temperature - b.temperature,
	substance   = a.substance   - b.substance,
	luminosity  = a.luminosity  - b.luminosity,
};

fn pow_dim(dim: dimension, exp: int) dimension = switch (exp) {
	case 0 =>
		yield dimensionless;
	case 1 =>
		yield dim;
	case =>
		yield dimension {
			mass        = dim.mass        * exp,
			length      = dim.length      * exp,
			time        = dim.time        * exp,
			current     = dim.current     * exp,
			temperature = dim.temperature * exp,
			substance   = dim.substance   * exp,
			luminosity  = dim.luminosity  * exp,
		};
};

fn mult_unit(a: unit, b: unit) unit = {
	return unit {
		dim   = mult_dim(a.dim, b.dim),
		scale = a.scale * b.scale,
	};
};

fn div_unit(a: unit, b: unit) unit = {
	return unit {
		dim   = div_dim(a.dim, b.dim),
		scale = a.scale / b.scale,
	};
};

fn pow_unit(a: unit, exp: int) unit = {
	return unit {
		dim   = pow_dim(a.dim, exp),
		scale = a.scale,
	};
};

fn to_json(buf: []u8, u: unit) (str | nomem) = {
	return fmt::bsprintf(buf, "{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}",
		u.dim.mass, u.dim.length, u.dim.time, u.dim.current, u.dim.temperature, u.dim.substance, u.dim.luminosity, u.scale);
};

fn quantity_to_json(buf: []u8, q: quantity) (str | nomem) = {
	return fmt::bsprintf(buf,
		"{{\"value\":{},\"unit\":{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}}}",
		q.value,
		q.unit.dim.mass,
		q.unit.dim.length,
		q.unit.dim.time,
		q.unit.dim.current,
		q.unit.dim.temperature,
		q.unit.dim.substance,
		q.unit.dim.luminosity,
		q.unit.scale,
	);
};

fn uprint(u: unit) (size | io::error) = {
	let buf: *[512]u8 = alloc([0...])!;
	defer free(buf);
	return match (to_json(buf, u)) {
	case let json_object: str =>
		yield fmt::println(json_object);
	case nomem =>
		yield nomem;
	};
};

fn qprint(q: quantity) (size | io::error) = {
	let buf: *[512]u8 = alloc([0...])!;
	defer free(buf);
	return match (quantity_to_json(buf, q)) {
	case let json_object: str =>
		yield fmt::printf("{}\n", json_object);
	case nomem =>
		yield nomem;
	};
};

type parser = struct {
	scanner: strings::iterator,
	current: (token | done),
};

fn advance(p: *parser) (token | done) = {
	p.current = next_token(&p.scanner);
	return p.current;
};

// Parses an entire unit expression.
fn parse_symbol(s: str) (unit | void) = {
	const sz: size = count(s);
	if (sz == 0) {
		return void;
	};
	match (match_symbol(s)) {
	case let kind: unit_kind =>
		return lookup_unit(kind);
	case =>
		void;
	};
	if (sz == 1) {
		return void;
	};
	let iter = strings::iter(s);
	const first = match (strings::next(&iter)) {
	case let r: rune =>
		yield r;
	case done =>
		return void;
	};
	// TODO: logging
	// fmt::printf("matching prefix: {}\n", first)!;
	let scale = match (lookup_prefix(first)) {
	case let pref: prefix =>
		yield prefix_scale[pref];
	case void =>
		return void;
	};
	const suffix = strings::sub(s, 1);
	return match (match_symbol(suffix)) {
	case let kind: unit_kind =>
		let u: unit = lookup_unit(kind);
		u.scale = u.scale * scale;
		yield u;
	case void =>
		yield void;
	};
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
					return invalid;
				};
				advance(p);
			case done =>
				return invalid;
			};

			return result;

		case =>
			return invalid;
		};
	case done =>
		return invalid;
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
			return invalid;
		};

		const tok = match (p.current) {
		case let tok: token =>
			if (tok.kind != token_kind::INTEGER) {
				return invalid;
			};
			yield tok;
		case done =>
			return invalid;
		};

		advance(p);
		yield pow_unit(result, sign * strconv::stoi8(tok.text)?);

	case token_kind::SUPER_INTEGER =>
		advance(p);
		yield pow_unit(result, strconv::stoi8(tok.text)?);

	case token_kind::SUPER_PLUS, token_kind::SUPER_MINUS =>
		const sign: i8 = if (tok.kind == token_kind::SUPER_MINUS) -1 else 1;
		advance(p);

		const tok = match (p.current) {
		case let tok: token =>
			if (tok.kind != token_kind::SUPER_INTEGER) {
				return invalid;
			};
			yield tok;
		case done =>
			return invalid;
		};

		advance(p);
		yield pow_unit(result, sign * strconv::stoi8(tok.text)?);

	case =>
		yield result;
	};
};

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
				result = mult_unit(result, rhs);
			case token_kind::SOLIDUS =>
				advance(p);
				const rhs = parse_factor(p)?;
				result = div_unit(result, rhs);
			case =>
				return result;
			};
		case done =>
			return result;
		};
	};
};

fn parse_value(p: *parser) (f64 | strconv::invalid | strconv::overflow) = {
	const start: parser = *p;
	let next: parser = *p;

	for (true) {
		advance(&next);
		match (next.current) {
		case let tok: token =>
			switch (tok.kind) {
			case token_kind::INTEGER, token_kind::POINT,
				token_kind::COMMA, token_kind::EXPONENT,
				token_kind::PLUS, token_kind::MINUS =>
				advance(p);
			case =>
				break;
			};
		case done =>
			break;
		};
	};

	const value = strings::slice(&start.scanner, &p.scanner);
	return parse_float(value);
};

fn parse_quantity(p: *parser) (quantity | error) = {
	const v: f64  = parse_value(p)?;
	advance(p);
	const u: unit = parse_unit(p)?;
	return quantity { unit = u, value = v };
};

fn parse(s: str) (quantity | error) = {
	let p = parser {
		scanner = strings::iter(s),
	    	current = done,
	};

	const result = parse_quantity(&p)?;

	match (p.current) {
	case done =>
		return result;
	case =>
		return invalid;
	};
};

fn scale10(value: f64, exp: int) f64 = {
	let result = value;
	if (exp > 0) {
		for (let i = 0; i < exp; i += 1) {
			result *= 10.0;
		};
	} else {
		for (let i = 0; i > exp; i -= 1) {
			result /= 10.0;
		};
	};
	return result;
};

fn parse_float(s: str) (f64 | strconv::invalid | strconv::overflow) = {
	const parts: (str, str) = strings::cut(s, "e");
	const mantissa: f64 = strconv::stof64(parts.0)?;

	if (count(parts.1) == 0) {
		return mantissa;
	};

	const exponent: int = strconv::stoi(parts.1)?;
	return scale10(mantissa, exponent);
};

fn print_remainder(p: *parser) void = {
	let debug: parser = *p;
	fmt::printf("remainder=")!;
	for (true) {
		advance(&debug);
		match (debug.current) {
		case let tok: token =>
			fmt::printf("{}", tok.text)!;
		case done =>
			break;
		};
	};
	fmt::println()!;
};

export fn main() void = {
	if (len(os::args) < 2) {
		return;
	};
	match (parse(os::args[1])) {
	case let err: no_match =>
		fmt::printf("{}: {}", strerror(err), err)!;
		return;
	case let err: error =>
		fmt::printf("{}", strerror(err))!;
	case let q: quantity =>
		qprint(q)!;
	};
};
