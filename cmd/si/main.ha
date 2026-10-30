use fmt;
use os;

use si;

fn run() (void | si::error) = {
	const nargs: size = len(os::args);
	if (nargs <= 1) {
		help();
		return;
	};

	if (os::args[1] == "version") {
		version();
		return;
	};

	const qty = match (si::parse(os::args[1])) {
	case let err: si::no_match =>
		fmt::printf("{}: {}", si::strerror(err), err)?;
		return;
	case let err: si::error =>
		fmt::printf("{}", si::strerror(err))?;
		return;
	case let qty: si::quantity =>
		yield qty;
	};

	switch (nargs) {
	case 2 =>
		si::print(qty)?;
	case 3 =>
		si::print(qty, os::args[2])?;
	case =>
		fmt::println("unexpected number of arguments")?;
	};
};

fn version() void = {
	fmt::printf("si {}-{}\n", si::sem_version, si::git_version)!;
};

fn help() void = {
	fmt::printf("si {}-{}\n", si::sem_version, si::git_version)!;
};

export fn main() void = {
	match (run()) {
	case let err: si::error =>
		fmt::errorln(si::strerror(err))!;
	case void =>
		void;
	};
};
