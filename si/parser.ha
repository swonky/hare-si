use fmt;
use io;
use math;
use strconv;
use strings;
use os;

type parser = struct {
	scanner: strings::iterator,
	current: (token | done),
	advance: *fn(_: *strings::iterator) (token | done),
};

fn advance(p: *parser) (token | done) = {
	p.current = p.advance(&p.scanner);
	return p.current;
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
			return match (symbol_lookup[mid].kind) {
			case let k: unit_kind =>
				yield k;
			case =>
				abort("invalid lookup table");
			};
		};
	};
	return void;
};

fn eq_dim(a: dimension, b: dimension) bool = {
	return a.mass == b.mass
	       && a.length == b.length
	       && a.time == b.time
	       && a.current == b.current
	       && a.temperature == b.temperature
	       && a.substance == b.substance
	       && a.luminosity == b.luminosity;
};

fn mul_dim(a: dimension, b: dimension) dimension = dimension {
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

// Returns the product of a and b.
export fn mul(a: unit, b: unit) unit = {
	return unit {
		dim   = mul_dim(a.dim, b.dim),
		scale = a.scale * b.scale,
	};
};

// Returns the quotiant of a and b.
export fn div(a: unit, b: unit) (unit | divide_by_zero) = {

	if (math::isclosef64(b.scale, 0.0)) {
		return divide_by_zero;
	};
	return unit {
		dim   = div_dim(a.dim, b.dim),
		scale = a.scale / b.scale,
	};
};

// Returns the value of a raised to the power of b.
export fn pow_unit(a: unit, exp: int) unit = {
	return unit {
		dim   = pow_dim(a.dim, exp),
		scale = math::powf64(a.scale, exp: f64),
	};
};



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
		return match (match_symbol(suffix)) {
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

// // Parses an entire unit expression.
// fn parse_symbol(s: str) (unit | void) = {
// 	const sz: size = count(s);
// 	if (sz == 0) {
// 		return void;
// 	};
// 	match (match_symbol(s)) {
// 	case let kind: unit_kind =>
// 		return lookup_unit(kind);
// 	case =>
// 		void;
// 	};
// 	if (sz == 1) {
// 		return void;
// 	};
// 	let iter = strings::iter(s);
// 	const first = match (strings::next(&iter)) {
// 	case let r: rune =>
// 		yield r;
// 	case done =>
// 		return void;
// 	};
// 	// TODO: logging
// 	// fmt::printf("matching prefix: {}\n", first)!;
// 	let scale = match (lookup_prefix(first)) {
// 	case let pref: prefix =>
// 		yield prefix_scale[pref];
// 	case void =>
// 		return void;
// 	};
// 	const suffix = strings::sub(s, 1);
// 	return match (match_symbol(suffix)) {
// 	case let kind: unit_kind =>
// 		let u: unit = lookup_unit(kind);
// 		u.scale = u.scale * scale;
// 		yield u;
// 	case void =>
// 		yield void;
// 	};
// };
//
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
				result = mul(result, rhs);
			case token_kind::SOLIDUS =>
				advance(p);
				const rhs = parse_factor(p)?;
				return match(div(result, rhs)){
				case let u: unit => yield u;
				case => abort("invalid lookup table");
				};
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


fn parse_unit_str(s: str) (unit | error) = {
	let p = parser {
		scanner = strings::iter(s),
	    	current = done,
		advance = &next_token,
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

// export fn print(obj: (quantity | unit), u: (str | void) = void) (size | error) = {
// 	match (obj) {
// 	case let q: quantity =>
// 		return print_quantity(q, u);
// 	case let u: unit =>
// 		return print_unit(u);
// 	};
// };
	
export fn parse(s: str) (quantity | error) = {
	let p = parser {
		scanner = strings::iter(s),
	    	current = done,
		advance = &next_token_permissive,
	};

	const result = parse_quantity(&p)?;

	match (p.current) {
	case done =>
		return result;
	case =>
		return invalid;
	};
};
