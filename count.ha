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
