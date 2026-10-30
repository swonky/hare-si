// SPDX-License-Identifier: MPL-2.0
// (c) Hare authors <https://harelang.org>

// Returns the number of runes in the string 's'.
use strings;

export fn count(s: str) size = {
	let n: size = 0;
	for (let c .. strings::toutf8(s)) {
		if (c & 0xc0 != 0x80) {
			n += 1;
		};
	};
	return n;
};

@test fn count() void = {
	assert(count("") == 0);
	assert(count("1") == 1);
	assert(count("Bär") == 3);
	assert(count("こんにちは") == 5);
};
