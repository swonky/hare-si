use fmt;
use memio;

// Enum for specifying shell kind
type shell = enum u8 { BASH, ZSH };

// Generates autocompletion script for bash
fn generate_completions_bash() str = {
	static let buf: [8192]u8 = [0...];
	let out = &memio::fixed(buf);

	fmt::fprint(out,
		"_si() {\n",
		"\tlocal cur prev\n",
		"\tCOMPREPLY=()\n",
		"\tcur=\"${COMP_WORDS[COMP_CWORD]}\"\n",
		"\tprev=\"${COMP_WORDS[COMP_CWORD-1]}\"\n\n",
		"\tcase \"$prev\" in\n",
	)!;

	for (let f .. all_flags) {
		if (f.value is void) {
			continue;
		};

		fmt::fprintf(out, "\t\t-{}|--{})\n", f.short, f.long)!;

		match (f.possible) {
		case let values: []str =>
			fmt::fprint(out, "\t\t\tCOMPREPLY=( $(compgen -W '")!;
			for (let i = 0z; i < len(values); i += 1z) {
				if (i > 0) fmt::fprint(out, " ")!;
				fmt::fprint(out, values[i])!;
			};
			fmt::fprint(out, "' -- \"$cur\") )\n")!;
		case void =>
			void;
		};

		fmt::fprint(out, "\t\t\treturn\n\t\t\t;;\n")!;
	};

	fmt::fprint(out,
		"\tesac\n\n",
		"\tif [[ \"$cur\" == -* ]]; then\n",
		"\t\tCOMPREPLY=( $(compgen -W '",
	)!;

	for (let f .. all_flags) {
		fmt::fprintf(out, "-{} --{} ", f.short, f.long)!;
	};

	fmt::fprint(out,
		"' -- \"$cur\") )\n",
		"\t\treturn\n",
		"\tfi\n",
		"}\n\n",
		"complete -F _si si\n",
	)!;

	return memio::string(out)!;
};

// Generates autocompletion script for z shell
fn generate_completions_zsh() str = {
	static let buf: [8192]u8 = [0...];
	let out = &memio::fixed(buf);

	fmt::fprint(out,
		"#compdef si\n\n",
		"_si() {\n",
		"\t_arguments -s \\\n",
	)!;

	for (let f .. all_flags) {
		fmt::fprintf(out, "\t\t'(-{} --{})'", f.short, f.long)!;

		fmt::fprintf(out, "'-{}[{}]'", f.short, f.help)!;
		fmt::fprint(out, " \\\n")!;

		fmt::fprintf(out, "\t\t'(-{} --{})'", f.short, f.long)!;

		if (f.value is str) {
			fmt::fprintf(out, "'--{}[{}]:{}:", f.long, f.help, f.value)!;

			match (f.possible) {
			case let values: []str =>
				fmt::fprint(out, "(")!;
				for (let i = 0z; i < len(values); i += 1z) {
					if (i > 0) fmt::fprint(out, " ")!;
					fmt::fprint(out, values[i])!;
				};
				fmt::fprint(out, ")")!;
			case void =>
				void;
			};

			fmt::fprint(out, "'")!;
		} else {
			fmt::fprintf(out, "'--{}[{}]'", f.long, f.help)!;
		};

		fmt::fprint(out, " \\\n")!;
	};

	fmt::fprint(out, "}\n\n_si \"$@\"\n")!;

	return memio::string(out)!;
};

fn generate_completions(sh: shell) str = {
	switch (sh) {
	case shell::BASH =>
		return generate_completions_bash();
	case shell::ZSH =>
		return generate_completions_zsh();
	case =>
		return "";
	};
};
