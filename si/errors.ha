// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

// Error types and handlers.
use encoding::utf8;
use fmt;
use io;
use memio;
use strconv;
use types;

fn unreachable(s: str = "unreachable code") never = {
	abort(s);
};

export type unclosed_scope = !token_kind;
export type unexpected_token = !token;

// No matching unit or prefix was found.
export type invalid_symbol = !token;

// No matching unit or prefix was found.
export type invalid_numeric = !str;

// The dimensions of two units or quantities do not match.
export type dimension_mismatch = !void;

// The requested operation is not implemented.
export type not_implemented = !void;

// The input is invalid.
export type invalid = !void;

// An invalid exponent was encountered.
export type invalid_exponent = !void;

// Represents any error that can occur in the si library
export type error = !( invalid_symbol | invalid_exponent | invalid_numeric | unexpected_token
	| unclosed_scope | dimension_mismatch |  not_implemented
	| invalid | io::error | strconv::invalid | strconv::overflow
	| utf8::invalid | nomem );

// Returns a human-readable description of an error.
// Output strings are statically allocated and are overwritten on subsequent
// calls.
export fn strerror(err: error) str = {
	static let buf: [128]u8 = [0...];
	let h = memio::fixed(buf);

	match (err) {
	case let e: invalid =>
		return "Invalid";
	case let e: dimension_mismatch =>
		return "Dimension mismatch";
	case let e: invalid_exponent =>
		return "Invalid exponent: ";
	case let e: unclosed_scope =>
		const tk = e: token_kind;
		const r = switch (tk) {
		case token_kind::RPAREN =>
			yield ')';
		case token_kind::RBRACE =>
			yield '}';
		case =>
			return "unbalanced brackets";
		};
		fmt::fprintf(&h, "expected closing '{}'", r)!;
		return memio::string(&h)!;
	case let e: invalid_numeric =>
		const s = e: str;
		fmt::fprintf(
			&h,
			"unexpected token '{}', expected numeric value",
			s, 
		)!;
		return memio::string(&h)!;
	case let e: invalid_symbol =>
		const tok = e: token;
		fmt::fprintf(&h, "invalid symbol '{}' at position {}", tok.text, tok.pos)!;
		return memio::string(&h)!;
	case let e: unexpected_token =>
		const tok = e: token;
		fmt::fprintf(&h, "unexpected token '{}' at position {}", tok.text, tok.pos)!;
		return memio::string(&h)!;
	case let e: utf8::invalid =>
		return utf8::strerror(e);
	case let e: strconv::error =>
		return strconv::strerror(e);
	case let e: io::error =>
		return io::strerror(e);
	case let e: nomem =>
		return "Ran out of memory";
	case =>
		return "Unhandled exception";
	};
};

