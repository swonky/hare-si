// Error types and handlers.
use encoding::utf8;
use fmt;
use io;
use strconv;

fn unreachable() never = {
	abort("unreachable code");
};

// The dimensions of two units or quantities do not match.
export type dimension_mismatch = !void;

// No matching unit or prefix was found.
export type no_match = !str;

// The requested operation is not implemented.
export type not_implemented = !void;

// The input is invalid.
export type invalid = !void;

// An invalid exponent was encountered.
export type invalid_exponent = !void;

// An unexpected token was encountered during parsing.
export type unexpected_token = !rune;

// Represents any error that can occur in the si library
export type error = !( no_match | invalid_exponent
	| dimension_mismatch | unexpected_token | not_implemented
	| invalid | io::error | strconv::invalid | strconv::overflow
	| utf8::invalid | nomem );

// Returns a human-readable description of an error.
// Returned value should NOT be freed by the caller.
export fn strerror(err: error) str = {
	match (err) {
	case let e: invalid =>
		return "Invalid";
	case let e: no_match =>
		return "Unrecognised symbol";
	case let e: dimension_mismatch =>
		return "Dimension mismatch";
	case let e: invalid_exponent =>
		return "Invalid exponent: ";
	case let e: unexpected_token =>
		return "Unexpected token";
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

// Prints the human readable description of the error to stderr.
export fn printerror(err: error) (void | io::error) = {
	const msg: str = strerror(err);
	fmt::errorf("{}", msg)?;

	match (err) {
	case let e: no_match =>
		fmt::errorf(": {}", e)?;
	case let e: unexpected_token =>
		fmt::errorf(": {}", e)?;
	case =>
		void;
	};
};
