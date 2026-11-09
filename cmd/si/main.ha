// SPDX-License-Identifier: MIT
// (C) 2026 Tom Spencer <tcs.git@pm.me>

use fmt;
use io;
use os;
use si;
use strconv;
use strings;
use unix::tty;
use memio;



type options = struct {
	input:       str,
	encoding:    si::encoding,
	precision:   (void | uint),
	notation:    si::notation,
	unit:        (void | str),
	strict:      bool,
	base:        bool,
	completions: (void | shell),
	version:     bool,
	help:        bool,
};

type shell = enum u8 { BASH, ZSH };
type arg_handler = *fn(_: *options, _: str) (void | error);
type bool_handler = *fn(_: *options) (void | error);

type flag = struct {
	key: str,
	help: str,
	handler: (arg_handler | bool_handler),
	value: (void | str),
	possible: (void | []str),
};

def all_completions: [_]str = [
	BASH_COMPLETIONS,
	ZSH_COMPLETIONS,
];

def all_flags: [_]flag = [
	flag {
		key = "base",
		help = "Formats the outputted quantity in SI base units",
		handler = &handle_base,
		value = void,
		possible = void,
	},
	flag {
		key = "completions",
		help = "Print shell completion script",
		handler = &handle_completion,
		value = void,
		possible = ["bash", "zsh"],
	},
	flag {
		key = "encoding",
		help = "Specify output format",
		handler = &handle_encoding,
		value = "ENCODING",
		possible = ["utf", "ascii", "json"],
	},
	flag {
		key = "help",
		help = "Display this help",
		handler = &handle_help,
		value = void,
		possible = void,
	},
	flag {
		key = "notation",
		help = "Specify numeric notation",
		handler = &handle_notation,
		value = "NUMBER",
		possible = ["general", "fixed", "scientific", "e", "E"],
	},
	flag {
		key = "precision",
		help = "Specify decimal precision",
		handler = &handle_precision,
		value = "NUMBER",
		possible = void,
	},
	flag {
		key = "strict",
		help = "Enables restricted parsing syntax",
		handler = &handle_strict,
		value = void,
		possible = void,
	},
	flag {
		key = "unit",
		help = "Specify output unit",
		handler = &handle_unit,
		value = "EXPRESSION",
		possible = void,
	},
	flag {
		key = "version",
		help = "Display version information",
		handler = &handle_version,
		value = void,
		possible = void,
	},
];

fn get_flag(key: str) (flag | invalid_flag) = {
	if (strings::hasprefix(key, "--")) {
		const trimmed = strings::trimprefix(key, "--");
		for (let f .. all_flags) {
			if (f.key == trimmed) return f;
		};
		return key: invalid_flag;
	};
	if (strings::hasprefix(key, "-")){
		const trimmed = strings::trimprefix(key, "-");
		for (let f .. all_flags) {
			if (strings::hasprefix(f.key, trimmed)) return f;
		};
	};
	return key: invalid_flag;
};

fn join_args(args: []str) (str | error) = {
	static let buf: [1024]u8 = [0...];
	let stream = &memio::fixed(buf);

	for (let a .. args) {
		const bytes = strings::toutf8(a);
		io::write(stream, bytes)?;
		memio::appendrune(stream, ' ')?;
	};

	return memio::string(stream)?;
};

fn dispatch(args: []str) (options | error) = {
	
	const nargs = len(args);

	if (nargs == 0) {
		return "no arguments provided": argument_error;
	};


	let opts = options {
		input = "",
		encoding = si::encoding::UTF8,
		precision = void,
		notation = si::notation::GENERAL,
		unit = void,
		strict = false,
		base = false,
		completions = void,
		version = false,
		help = false,
	};

	let i = 1z;
	for (i < nargs-1z; i+=1z) {
		if (args[i] == "--") {
			i += 1z;
			if (i >= nargs) {
				return "input expression": missing_value;
			};
			opts.input = join_args(args[i..])?;
			return opts;
		};
		const parts = strings::cut(args[i], "=");
		const f = get_flag(parts.0)?;
		
		match (f.handler) {
		case let h: arg_handler =>
			if (parts.1 != "") {
				h(&opts, parts.1)?;
				continue;
			};
			i += 1z;
			if (i >= nargs) {
				return parts.0: missing_value;
			};
			h(&opts, args[i])?;
		case let h: bool_handler =>
			h(&opts)?;
		};
	};

	if (i >= nargs) {
		return "input expression": missing_value;
	};

	opts.input = args[nargs-1];
	return opts;
};

fn handle_help(opts: *options) (void | error) = { opts.help = true; };

fn handle_version(opts: *options) (void | error) = { opts.version = true; };

fn handle_base(opts: *options) (void | error) = { opts.base = true; };

fn handle_strict(opts: *options) (void | error) = { opts.strict = true; };

fn handle_unit(opts: *options, input: str) (void | error) = {
	opts.unit = input;
};

fn handle_completion(opts: *options, input: str) (void | error) = { 
	opts.completions = switch (input) {
	case "bash" => yield shell::BASH;
	case "zsh"  => yield shell::ZSH;
	case        => return input: unsupported_shell;
	};
};	

fn handle_precision(opts: *options, input: str) (void | error) = {
	const n = strconv::stoi(input)?;

	if (n < 0) {
		return "precision must be non-negative": argument_error;
	};

	opts.precision = n: uint;
};

fn handle_notation(opts: *options, input: str) (void | error) = {
	const notation = switch (input) {
	case "general" =>
		yield si::notation::GENERAL;
	case "fixed" =>
		yield si::notation::FIXED;
	case "scientific" =>
		yield si::notation::SCIENTIFIC;
	case "e" =>
		yield si::notation::E_LOWER;
	case "E" =>
		yield si::notation::E_UPPER;
	case =>
		return "invalid notation": argument_error;
	};
	opts.notation = notation;
};

fn handle_encoding(opts: *options, input: str) (void | error) = {
	opts.encoding = switch (input) {
	case "ascii" =>
		yield si::encoding::ASCII;
	case "utf" =>
		yield si::encoding::UTF8;
	case "json" =>
		yield si::encoding::JSON;
	case =>
		return input: unsupported_output;
	};
};

fn run(opts: options) (void | error) = {

	if (opts.help) {
		print_help(os::stdout)?;
		return;
	};

	if (opts.version) {
		print_version(opts)?;
		return;
	};

	match (opts.completions) {
	case let sh: shell =>
		fmt::print(all_completions[sh: size])?;
		return;
	case =>
		void;
	};

	if (opts.base && opts.unit is str) {
		return "--base and --unit cannot both be set": argument_error;
	};

        const qty = si::strp(opts.input)?;

	if (opts.encoding == si::encoding::JSON) {
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
		opts.encoding,
	)?;
};


export fn main() void = {
	const opts = match (dispatch(os::args)) {
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
