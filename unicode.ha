fn is_space(c: rune) bool = {
	return switch (c) {
	case ' ', '\t',
	     '\u00A0', // NO-BREAK SPACE
	     '\u1680', // OGHAM SPACE MARK
	     '\u2000', // EN QUAD
	     '\u2001', // EM QUAD
	     '\u2002', // EN SPACE
	     '\u2003', // EM SPACE
	     '\u2004', // THREE-PER-EM SPACE
	     '\u2005', // FOUR-PER-EM SPACE
	     '\u2006', // SIX-PER-EM SPACE
	     '\u2007', // FIGURE SPACE
	     '\u2008', // PUNCTUATION SPACE
	     '\u2009', // THIN SPACE
	     '\u200A', // HAIR SPACE
	     '\u202F', // NARROW NO-BREAK SPACE
	     '\u205F', // MEDIUM MATHEMATICAL SPACE
	     '\u3000' => true; // IDEOGRAPHIC SPACE
	case => false;
	};
};

fn is_digit(c: rune) bool =
	(c: u32) >= ('0': u32) && (c: u32) <= ('9': u32);

fn is_alpha(c: rune) bool =
	((c: u32) >= ('a': u32) && (c: u32) <= ('z': u32))
	|| ((c: u32) >= ('A': u32) && (c: u32) <= ('Z': u32))
	|| c == 'µ' || c == 'μ' || c == 'Ω';
