use fmt;
use io;
use memio;
use os;
use strings;
use si;

type palette = enum size { SECTION_HEADING, COMMAND_NAME, OPTION_NAME, OPTION_ARGUMENT, RESET };

def with_color = ["\x1b[1;36m", "\x1b[1;32m", "\x1b[1;33m", "\x1b[2m", "\x1b[0m" ];
def without_color = ["", "", "", "", "" ];

let NO_COLOR = false;

def NONE = "";


def HELP = `
A utility for parsing, converting, and formatting quantities using the International System of Units (SI).

Report issues: <https://codeberg.org/swonky/hare-si>

{0}Usage:{4}
  {1}si{4} [{2}OPTIONS{4}] [{2}--{4}] {3}<VALUE>{4}
  {1}si{4} [{2}ACTION{4}]

{0}Arguments:{4}
  {3}<VALUE>{4}                          Quantity to evaluate, including its unit expression.

{0}Options:{4}
`;

fn print_help(out: io::handle) (void | io::error) = {
	const pal = if (NO_COLOR) without_color else with_color;

	fmt::fprintf(out, "\n{} v{}\n", os::args[0], SEM_VERSION)?;
	fmt::fprintf(
		out,
		HELP,
		pal[palette::SECTION_HEADING],
		pal[palette::COMMAND_NAME],
		pal[palette::OPTION_NAME],
		pal[palette::OPTION_ARGUMENT],
		pal[palette::RESET],
	)?;


	for (let f .. all_flags) {

		let possible: str = @undefined;

		possible = match (f.possible) {
		case let strs: []str =>
			const a = strings::join(", ", strs...)?;
			const b = fmt::asprintf(" ({})", a)?;
			free(a);
			defer free(possible);
			yield b;
		case void =>
			yield "";
		};

		let value = match (f.value) {
		case let s: str => yield fmt::asprintf("--{}{} <{}>", f.long, pal[palette::OPTION_ARGUMENT], s)?;
		case void => yield fmt::asprintf("--{}{}", f.long, pal[palette::OPTION_ARGUMENT])?;
		};
		
		fmt::fprintf(out, "   {0}", pal[palette::OPTION_NAME])?;

		let short = match (f.short) {
		case let s: str =>
			fmt::fprintf(out, "-{}, ", s)?;
		case void => void;
		};

		value = strings::rpad(value, ' ', 32)?;

		fmt::fprint(out, value)!;
		fmt::fprintf(out, "{}", pal[palette::RESET])!;
		fmt::fprintf(out, "{}.", f.help)!;
		fmt::fprintf(out, "{}", pal[palette::OPTION_ARGUMENT])!;
		fmt::fprintf(out, "{}", possible)!;
		fmt::fprintf(out, "{}", pal[palette::RESET])!;
		fmt::fprintln(out)!;

	};

	fmt::fprintln(out)?;
	fmt::fprintf(out, "{}Actions:{}\n",
		pal[palette::COMMAND_NAME],
		pal[palette::OPTION_NAME],
	)?;
	

	for (let f .. all_actions) {

		let possible: str = @undefined;


		possible = match (f.possible) {
		case let strs: []str =>
			const a = strings::join(", ", strs...)?;
			const b = fmt::asprintf(" ({})", a)?;
			// free(a);
			// defer free(possible);
			yield b;
		case void =>
			yield "";
		};
	

		let value = match (f.value) {
		case let s: str => yield fmt::asprintf("+{}{} <{}>", f.long, pal[palette::OPTION_ARGUMENT], s)?;
		case void => yield fmt::asprintf("+{}{}", f.long, pal[palette::OPTION_ARGUMENT])?;
		};


		fmt::fprintf(out, "   {0}", pal[palette::OPTION_NAME])!;

		let short = match (f.short) {
		case let s: str =>
			fmt::fprintf(out, "+{}, ", s)!;
		case void => void;
		};

		value = strings::rpad(value, ' ', 32)?;

		fmt::fprint(out, value)!;
		fmt::fprintf(out, "{}", pal[palette::RESET])!;
		fmt::fprintf(out, "{}.", f.help)!;
		fmt::fprintf(out, "{}", pal[palette::OPTION_ARGUMENT])!;
		fmt::fprintf(out, "{}", possible)!;
		fmt::fprintf(out, "{}", pal[palette::RESET])!;
		fmt::fprintln(out)!;
	};
};

fn print_schema(out: io::handle) (void | io::error) = {
	fmt::fprintln(out, si::JSON_SCHEMA)?;
};
fn print_version(opts: options) (void | io::error) = {
	if (opts.encoding == si::encoding::JSON) {
		fmt::printf(
			"{{\"version\":\"{}\",\"git_version\":\"{}\"}}\n",
			SEM_VERSION,
			GIT_VERSION,
		)!;
		return;
	};
	fmt::printf("si {}-{}\n", SEM_VERSION, GIT_VERSION)?;
};

