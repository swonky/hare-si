use io;
use strconv;

export type dimension_mismatch = !void;
export type no_match    = !str;
export type not_implemented = !str;
export type invalid = !void;
type expected_ = !str;

export type unexpected  = struct {
	pos: size,
	exp: str,
	got: str,
};

export type error = !(no_match | dimension_mismatch | unexpected | not_implemented | invalid | io::error | strconv::invalid | strconv::overflow);


export fn strerror(err: error) str = {
	match (err) {
	case let e: invalid =>
		return "Invalid";
	case let e: no_match =>
		return "Unrecognised symbol";
	case let e: dimension_mismatch =>
		return "Dimension mismatch";
	case let e: strconv::error =>
		return strconv::strerror(e);
	case let e: io::error =>
		return io::strerror(e);
	case =>
		return "Uh oh";
	};
};
