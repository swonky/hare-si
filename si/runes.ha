// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

// Horizontal whitespace
def SPACE_NO_BREAK             : rune = '\u00A0';
def SPACE_THIN                 : rune = '\u2009';
def SPACE_NARROW_NO_BREAK      : rune = '\u202F';
def SPACE_IDEOGRAPHIC          : rune = '\u3000';

def FULL_STOP                  : rune = '\u002E';
def COMMA                      : rune = '\u002C';

def LATIN_LETTER_SMALL_U       : rune = '\u0075';

// Mu variants
def LETTER_MICRO_SIGN          : rune = '\u00B5'; // µ
def LETTER_GREEK_SMALL_MU      : rune = '\u03BC'; // μ

// Omega variants
def LETTER_GREEK_CAPITAL_OMEGA : rune = '\u03A9'; // Ω
def OHM_SIGN                   : rune = '\u2126'; // Ω

// Middle dots and related symbols
def DOT_MIDDLE                 : rune = '\u00B7'; // ·
def DOT_HYPHENATION            : rune = '\u2027'; // ‧
def DOT_BULLET_OPERATOR        : rune = '\u2219'; // ∙
def DOT_OPERATOR               : rune = '\u22C5'; // ⋅
def DOT_LATIN_SINOLOGICAL      : rune = '\uA78F'; // ꞏ

// Superscript digits
def DIGIT_SUPER_ZERO           : rune = '\u2070'; // ⁰
def DIGIT_SUPER_ONE            : rune = '\u00B9'; // ¹
def DIGIT_SUPER_TWO            : rune = '\u00B2'; // ²
def DIGIT_SUPER_THREE          : rune = '\u00B3'; // ³
def DIGIT_SUPER_FOUR           : rune = '\u2074'; // ⁴
def DIGIT_SUPER_FIVE           : rune = '\u2075'; // ⁵
def DIGIT_SUPER_SIX            : rune = '\u2076'; // ⁶
def DIGIT_SUPER_SEVEN          : rune = '\u2077'; // ⁷
def DIGIT_SUPER_EIGHT          : rune = '\u2078'; // ⁸
def DIGIT_SUPER_NINE           : rune = '\u2079'; // ⁹

// Sign operators
def PLUS_SIGN                  : rune = '\u002B'; // +
def SUPERSCRIPT_PLUS_SIGN      : rune = '\u207A'; // ⁺
def HYPHEN_MINUS               : rune = '\u002D'; // -
def HYPHEN                     : rune = '\u2010'; // ‐
def MINUS_SIGN                 : rune = '\u2212'; // −
def SUPERSCRIPT_MINUS          : rune = '\u207B'; // ⁻

// Binary operators
def ASTERISK                   : rune = '\u002A'; // *
def ASTERISK_OPERATOR          : rune = '\u2217'; // ∗
def STAR_OPERATOR              : rune = '\u22C6'; // ⋆
def MULTIPLICATION_SIGN        : rune = '\u00D7'; // ×
def SOLIDUS                    : rune = '\u002F'; // /
def CIRCUMFLEX_ACCENT          : rune = '\u005E'; // ^
def INVISIBLE_TIMES            : rune = '\u2062';

// Brackets
def LEFT_PARENTHESIS           : rune = '\u0028'; // (
def RIGHT_PARENTHESIS          : rune = '\u0029'; // )
def LEFT_CURLY_BRACKET         : rune = '\u007B'; // {
def RIGHT_CURLY_BRACKET        : rune = '\u007D'; // }

def superscript_digits: [_]rune = [
	DIGIT_SUPER_ZERO,
	DIGIT_SUPER_ONE,
	DIGIT_SUPER_TWO,
	DIGIT_SUPER_THREE,
	DIGIT_SUPER_FOUR,
	DIGIT_SUPER_FIVE,
	DIGIT_SUPER_SIX,
	DIGIT_SUPER_SEVEN,
	DIGIT_SUPER_EIGHT,
	DIGIT_SUPER_NINE,
];

