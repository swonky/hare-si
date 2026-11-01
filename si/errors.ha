use fmt;
use io;
use strconv;

export type dimension_mismatch = !void;
export type no_match    = !str;
export type not_implemented = !str;
export type invalid = !void;
export type invalid_exponent = !rune;
export type unexpected_token = !rune;
export type divide_by_zero = !void;

export type unexpected  = struct {
	pos: size,
	exp: str,
	got: str,
};

export type error = !(no_match | divide_by_zero| invalid_exponent
	| dimension_mismatch | unexpected_token | not_implemented
	| invalid | io::error | strconv::invalid | strconv::overflow
	| nomem );


export fn strerror(err: error) str = {
	match (err) {
	case let e: invalid =>
		return "Invalid";
	case let e: no_match =>
		return "Unrecognised symbol";
	case let e: dimension_mismatch =>
		return "Dimension mismatch";
	case let e: invalid_exponent =>
		return "Invalid exponent";
	case let e: unexpected_token =>
		return "Unexpected token";
	case let e: divide_by_zero =>
		return "Divide by zero";
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

export fn printerror(err: error) (void | io::error) = {
	const msg: str = strerror(err);
	fmt::errorf("{}", msg)?;

	match (err) {
	case let e: no_match =>
		fmt::errorf(": {}", e)?;
	case let e: invalid_exponent =>
		fmt::errorf(": {}", e)?;
	case let e: unexpected_token =>
		fmt::errorf(": {}", e)?;
	case =>
		void;
	};
};
