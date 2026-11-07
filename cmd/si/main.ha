use fmt;
use io;
use os;
use strconv;
use strings;
use unix::tty;

use si;

type argument_error = !str;
type missing_value = !str;
type unsupported_shell = !str;

type error = !(argument_error | missing_value | unsupported_shell | si::error);

type options = struct {
	input:       str,
	output:      si::encoding,
	precision:   (void | uint),
	notation:    si::notation,
	format:      str,
	unit:        (void | str),
	strict:      bool,
	base:        bool,
	completions: (void | str),
	version:     bool,
};

@init fn colour_enabled() void = {
	if (!tty::isatty(os::stdout_file)) {
		NO_COLOR = true;
		return;
	};

	match (os::getenv("NO_COLOR")) {
	case let value: str =>
		if (len(value) > 0) {
			NO_COLOR = true;
			return;
		};
	case void =>
		void;
	};

	match (os::getenv("TERM")) {
	case let term: str =>
		NO_COLOR = term == "dumb";
	case void =>
		return;
	};
};

let NO_COLOR = false;

const SECTION_HEADING = "\x1b[1;36m";
const COMMAND_NAME = "\x1b[1;32m";
const OPTION_NAME = "\x1b[1;33m";
const OPTION_ARGUMENT = "\x1b[2m";
const RESET = "\x1b[0m";
const NONE = "";

const HELP = `
A utility for parsing, converting, and formatting quantities using the International System of Units (SI).

{0}Usage:{4}
  {1}si{4} [{2}OPTIONS{4}] {3}<VALUE>{4}

{0}Arguments:{4}
  {3}<VALUE>{4}                      Quantity to evaluate, including its unit expression.

{0}Options:{4}
  {2}-c, --completions {3}<SHELL>     {4}Prints shell completions {3}(bash, zsh){4}.
  {2}-n, --notation {3}<NOTATION>     {4}Numeric notation {3}(general, fixed, scientific, e, E){4}.
  {2}-o, --output {3}<FORMAT>         {4}Output format {3}(utf, ascii, json){4}.
  {2}-p, --precision {3}<PRECISION>   {4}Decimal precision.
  {2}-u, --unit {3}<UNIT>             {4}Target unit representation.
  {2}-s, --strict                  {4}Enforce strict parsing rules for values.
  {2}-b, --base                    {4}Format output using SI base units.
  {2}-v, --version                 {4}Display version information.
  {2}-h, --help                    {4}Display this help.
`;


fn print_help(out: (void | io::handle) = void) (void | io::error) = {
	let h = match (out) {
	case void =>
		yield os::stdout;
	case let h: io::handle =>
		yield h;
	};

	fmt::fprintf(h, "\nsi v{}\n", SEM_VERSION)!;

	if (NO_COLOR) {
		fmt::fprintf(h, HELP, NONE, NONE, NONE, NONE, NONE,)!;
	} else {
		fmt::fprintf(h, HELP, SECTION_HEADING, COMMAND_NAME, OPTION_NAME,
			OPTION_ARGUMENT, RESET,)!;
	};
};

fn print_version(opts: options) void = {
	if (opts.output == si::encoding::JSON) {
		fmt::printf(
			"{{\"version\":\"{}\",\"git_version\":\"{}\"}}\n",
			si::SEM_VERSION,
			si::GIT_VERSION,
		)!;
		return;
	};
	fmt::printf("si {}-{}\n", si::SEM_VERSION, si::GIT_VERSION)!;
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
		return "Invalid notation";
	};
};

fn parse_encoding(s: str) (si::encoding | str) = {
	switch (s) {
	case "ascii" =>
		return si::encoding::ASCII;
	case "utf" =>
		return si::encoding::UTF8;
	case "json" =>
		return si::encoding::JSON;
	case =>
		return "Invalid encoding";
	};
};

fn parse_options() (options | void | error) = {
	let opts = options {
		input = "",
		output = si::encoding::UTF8,
		precision = void,
		notation = si::notation::GENERAL,
		format = "",
		unit = void,
		strict = false,
		base = false,
		completions = void,
		version = false,
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
			print_help()?;
			return;
		};

		if (arg == "-v" || arg == "--version") {
			opts.version = true;
			i += 1;
			continue;
		};

		if (arg == "-s" || arg == "--strict") {
			opts.strict = true;
			i += 1;
			continue;
		};

		if (arg == "-b" || arg == "--base") {
			opts.base = true;
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
			value = strings::sub(arg, 9);
		} else if (strings::hasprefix(arg, "--precision=")) {
			option = "precision";
			value = strings::sub(arg, 12);
		} else if (strings::hasprefix(arg, "--notation=")) {
			option = "notation";
			value = strings::sub(arg, 11);
		} else if (strings::hasprefix(arg, "--format=")) {
			option = "format";
			value = strings::sub(arg, 9);
		} else if (strings::hasprefix(arg, "--unit=")) {
			option = "unit";
			value = strings::sub(arg, 7);
		} else if (strings::hasprefix(arg, "--completions=")) {
			option = "completions";
			value = strings::sub(arg, 14);
		} else if (strings::hasprefix(arg, "-o=")) {
			option = "output";
			value = strings::sub(arg, 3);
		} else if (strings::hasprefix(arg, "-p=")) {
			option = "precision";
			value = strings::sub(arg, 3);
		} else if (strings::hasprefix(arg, "-n=")) {
			option = "notation";
			value = strings::sub(arg, 3);
		} else if (strings::hasprefix(arg, "-f=")) {
			option = "format";
			value = strings::sub(arg, 3);
		} else if (strings::hasprefix(arg, "-u=")) {
			option = "unit";
			value = strings::sub(arg, 3);
		} else if (strings::hasprefix(arg, "-c=")) {
			option = "completions";
			value = strings::sub(arg, 3);
		};

		if (option != "") {
			if (value is void) {
				i += 1;
				if (i >= len(args)) {
					return option: missing_value;
				};
				value = args[i];
			};

			const s = value as str;

			switch (option) {
			case "output" =>
				opts.output = match (parse_encoding(s)) {
				case let n: si::encoding => yield n;
				case let err: str =>
					fmt::errorln(err)!;
					print_help(os::stderr)?;
					return void;
				};
			case "precision" =>
				opts.precision = match (parse_precision(s)) {
				case let n: uint => yield n;
				case let err: str =>
					fmt::errorln(err)!;
					print_help(os::stderr)?;
					return void;
				};
			case "notation" =>
				opts.notation = match (parse_notation(s)) {
				case let n: si::notation => yield n;
				case let err: str =>
					fmt::errorln(err)!;
					print_help(os::stderr)?;
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
			print_help(os::stderr)?;
			return void;
		};

		if (have_input) {
			fmt::errorln("unexpected positional argument")!;
			print_help(os::stderr)?;
			return void;
		};

		append_input(&input, arg);
		have_input = true;
		i += 1;
	};

	if (opts.version) {
		print_version(opts);
		return;
	};

	match (opts.completions) {
	case void => 
		if (len(input) == 0) {
			return "no input provided": argument_error;
		};
	case let shell: str => 
		switch (shell) {
		case "bash" =>
			fmt::print(BASH_COMPLETIONS)!;
			return void;
		case "zsh" =>
			fmt::print(ZSH_COMPLETIONS)!;
			return void;
		case =>
			return shell: unsupported_shell;
		};
	};

	if (opts.base && opts.unit is str) {
		return "--base and --unit cannot both be set": argument_error;
	};

	opts.input = strings::fromutf8(input)!;
	return opts;
};

fn run(opts: options) (void | si::error) = {
        const qty = si::strp(opts.input)?;

	if (opts.output == si::encoding::JSON) {
		si::encodejson(os::stdout, qty)?;
		fmt::println()?;
		return;
	};


	if (!opts.base && opts.unit is void) {
		const parts = si::split(opts.input)?;
		opts.unit = parts.1;
	};

	si::println(
		qty,
		opts.unit,
		opts.precision,
		opts.notation,
		opts.output,
	)?;
};

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
	case let e: unsupported_shell =>
		errorln("unsupported shell", e: str);
		print_help(os::stderr)!;
	case let e: missing_value =>
		errorln("missing value", e: str);
		print_help(os::stderr)!;
	case let e: argument_error =>
		errorln("bad argument", e: str);
		print_help(os::stderr)!;
	case let e: si::error =>
		errorln(si::strerror(e));
	};
};

export fn main() void = {
	const opts = match (parse_options()) {
	case void =>
		return;
	case let err: error =>
		print_error(err);
		return;
	case let opts: options =>
		yield opts;
	};

	match (run(opts)) {
	case let err: si::error =>
		print_error(err);
	case void =>
		void;
	};
};
