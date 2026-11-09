use os;
use fmt;

export fn main() void = {
	for (let a .. os::args) {
		fmt::println(a)!;
	};
};
