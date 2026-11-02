use fmt;
use io;
use os;
use strconv;
use strings;

use si;

type options = struct {
	input:       str,
	output:      str,
	precision:   (void | uint),
	notation:    si::notation,
	format:      str,
	unit:        (void | str),
	strict:      bool,
	completions: (void | str),
};

const HELP = `
A utility for parsing, converting, and formatting quantities using the International System of Units (SI).

Usage:
  si [OPTIONS] VALUE

Arguments:
  VALUE              Quantity to evaluate, including its unit expression.

Options:
  -c, --completions  SHELL     Generate shell completions (bash or zsh).
  -n, --notation     NOTATION  Numeric notation (general, fixed, scientific, e, E).
  -o, --output       FORMAT    Output format (pretty, plain, json, or latex).
  -p, --precision    INTEGER   Decimal precision (default: 3).
  -u, --unit         UNIT      Target unit representation.

Flags:
  -s, --strict       Enforce strict parsing rules for values.
  -v, --version      Display version information.
  -h, --help         Display this help.

Unit expressions use ASCII infix notation (e.g. kg*m/s^2):
  *  multiplication
  /  division
  ^  exponentiation
  -  negative
  +  positive
  () grouping

Examples:
  si '1.5 kg*m/s^2'
  si --output=json '1.5 kg*m/s^2'
  si -o plain -u g '1.5 kg'
  si -p=6 -n=e '1.5 kg'
  si -- 1.5 kg*m/s^2
`;

fn print_help() void = {
	fmt::fprint(os::stdout, HELP)!;
};

fn print_version() void = {
	fmt::printf("si {}-{}\n", si::sem_version, si::git_version)!;
};

fn append_input(out: *[]u8, arg: str) void = {
	if (len(*out) > 0) {
		append(out, ' ': u8)!;
	};
	append(out, strings::toutf8(arg)...)!;
};

fn parse_precision(s: str) (uint | str) = {
	const n = match (strconv::stoi(s)) {
	case let n: int =>
		yield n: uint;
	case =>
		return "invalid precision";
	};

	if (n < 0) {
		return "precision must be non-negative";
	};

	return n;
};

fn parse_notation(s: str) (si::notation | str) = {
	switch (s) {
	case "general" =>
		return si::notation::GENERAL;
	case "fixed" =>
		return si::notation::FIXED;
	case "scientific" =>
		return si::notation::SCIENTIFIC;
	case "e" =>
		return si::notation::E_LOWER;
	case "E" =>
		return si::notation::E_UPPER;
	case =>
		return "invalid notation";
	};
};

fn parse_options() (options | void) = {
	let opts = options {
		input = "",
		output = "pretty",
		precision = void,
		notation = si::notation::GENERAL,
		format = "",
		unit = void,
		strict = false,
		completions = void,
	};

	let input: []u8 = [];
	let args = os::args;
	let positional_only = false;
	let have_input = false;
	let i = 1z;

	for (i < len(args)) {
		const arg = args[i];

		if (positional_only) {
			append_input(&input, arg);
			i += 1;
			continue;
		};

		if (arg == "--") {
			positional_only = true;
			i += 1;
			continue;
		};

		if (arg == "-h" || arg == "--help") {
			print_help();
			return void;
		};

		if (arg == "-v" || arg == "--version") {
			print_version();
			return void;
		};

		if (arg == "-s" || arg == "--strict") {
			opts.strict = true;
			i += 1;
			continue;
		};

		let option = "";
		let value: (str | void) = void;

		if (arg == "-o" || arg == "--output") {
			option = "output";
		} else if (arg == "-p" || arg == "--precision") {
			option = "precision";
		} else if (arg == "-n" || arg == "--notation") {
			option = "notation";
		} else if (arg == "-f" || arg == "--format") {
			option = "format";
		} else if (arg == "-u" || arg == "--unit") {
			option = "unit";
		} else if (arg == "-c" || arg == "--completions") {
			option = "completions";
		} else if (strings::hasprefix(arg, "--output=")) {
			option = "output";
			value = strings::sub(arg, 9, len(arg));
		} else if (strings::hasprefix(arg, "--precision=")) {
			option = "precision";
			value = strings::sub(arg, 12, len(arg));
		} else if (strings::hasprefix(arg, "--notation=")) {
			option = "notation";
			value = strings::sub(arg, 11, len(arg));
		} else if (strings::hasprefix(arg, "--format=")) {
			option = "format";
			value = strings::sub(arg, 9, len(arg));
		} else if (strings::hasprefix(arg, "--unit=")) {
			option = "unit";
			value = strings::sub(arg, 7, len(arg));
		} else if (strings::hasprefix(arg, "--completions=")) {
			option = "completions";
			value = strings::sub(arg, 14, len(arg));
		} else if (strings::hasprefix(arg, "-o=")) {
			option = "output";
			value = strings::sub(arg, 3, len(arg));
		} else if (strings::hasprefix(arg, "-p=")) {
			option = "precision";
			value = strings::sub(arg, 3, len(arg));
		} else if (strings::hasprefix(arg, "-n=")) {
			option = "notation";
			value = strings::sub(arg, 3, len(arg));
		} else if (strings::hasprefix(arg, "-f=")) {
			option = "format";
			value = strings::sub(arg, 3, len(arg));
		} else if (strings::hasprefix(arg, "-u=")) {
			option = "unit";
			value = strings::sub(arg, 3, len(arg));
		} else if (strings::hasprefix(arg, "-c=")) {
			option = "completions";
			value = strings::sub(arg, 3, len(arg));
		};

		if (option != "") {
			if (value is void) {
				i += 1;
				if (i >= len(args)) {
					fmt::errorfln("missing value for --{}", option)!;
					print_help();
					return void;
				};
				value = args[i];
			};

			const s = value as str;

			switch (option) {
			case "output" =>
				opts.output = s;
			case "precision" =>
				opts.precision = match (parse_precision(s)) {
				case let n: uint => yield n;
				case let err: str =>
					fmt::errorln(err)!;
					print_help();
					return void;
				};
			case "notation" =>
				opts.notation = match (parse_notation(s)) {
				case let n: si::notation => yield n;
				case let err: str =>
					fmt::errorln(err)!;
					print_help();
					return void;
				};
			case "format" =>
				opts.format = s;
			case "unit" =>
				opts.unit = s;
			case "completions" =>
				opts.completions = s;
			case =>
				abort();
			};

			i += 1;
			continue;
		};

		if (strings::hasprefix(arg, "-")) {
			fmt::errorfln("unknown option: {}", arg)!;
			print_help();
			return void;
		};

		if (have_input) {
			fmt::errorln("unexpected positional argument")!;
			print_help();
			return void;
		};

		append_input(&input, arg);
		have_input = true;
		i += 1;
	};

	if (len(input) == 0) {
		fmt::errorln("no input provided")!;
		print_help();
		return void;
	};

	opts.input = strings::fromutf8(input)!;
	return opts;
};

fn run(opts: options) (void | si::error) = {
	const qty = match (si::parse(opts.input)) {
	case let err: si::no_match =>
		fmt::errorfln("{}: {}", si::strerror(err), err)?;
		return;
	case let err: si::error =>
		fmt::errorln(si::strerror(err))?;
		return;
	case let qty: si::quantity =>
		yield qty;
	};

	si::fprintqln(
		os::stdout,
		qty,
		opts.unit,
		opts.precision,
		opts.notation,
	)?;
};

export fn main() void = {
	const opts = match (parse_options()) {
	case void =>
		return;
	case let opts: options =>
		yield opts;
	};

	match (run(opts)) {
	case let err: si::error =>
		fmt::errorln(si::strerror(err))!;
	case void =>
		void;
	};
};
