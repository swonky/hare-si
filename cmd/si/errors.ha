use fmt;
use os;
use si;

type argument_error = !str;
type missing_value = !str;
type unsupported_shell = !str;
type unsupported_output = !str;
type invalid_flag = !str;

type error = !(
	argument_error
	| missing_value
	| unsupported_shell
	| unsupported_output
	| invalid_flag
	| si::error
);

fn errorln(title: str, msg: (void | str) = void) void = {
	const error_label = if (NO_COLOR) {
		yield "error:";
	} else {
		yield "\x1b[1;31merror:\x1b[0m";
	};
	match (msg) {
	case let s: str =>
		fmt::fprintf(os::stderr, "{0} {1}\n  {2}\n", error_label, title, msg)!;
	case =>
		fmt::fprintf(os::stderr, "{0} {1}\n", error_label, title)!;
	};

};

fn print_error(err: error) void = {
	match (err) {
	case let e: unsupported_output =>
		errorln("unsupported output encoding", e: str);
		print_help(os::stderr)!;
	case let e: unsupported_shell =>
		errorln("unsupported shell", e: str);
		print_help(os::stderr)!;
	case let e: missing_value =>
		errorln("missing value", e: str);
		print_help(os::stderr)!;
	case let e: argument_error =>
		errorln("bad argument", e: str);
		print_help(os::stderr)!;
	case let e: invalid_flag =>
		errorln("bad argument", e: str);
		print_help(os::stderr)!;
	case let e: si::error =>
		errorln(si::strerror(e));
	};
};
