// SPDX-License-Identifier: MIT
// (C) 2026 Tom Spencer <tcs.git@pm.me>

export def QUETTA: f64 = 1.0e30;
export def RONNA:  f64 = 1.0e27;
export def YOTTA:  f64 = 1.0e24;
export def ZETTA:  f64 = 1.0e21;
export def EXA:    f64 = 1.0e18;
export def PETA:   f64 = 1.0e15;
export def TERA:   f64 = 1.0e12;
export def GIGA:   f64 = 1.0e9;
export def MEGA:   f64 = 1.0e6;
export def KILO:   f64 = 1.0e3;
export def HECTO:  f64 = 1.0e2;
export def DECA:   f64 = 1.0e1;
export def NONE:   f64 = 1.0;
export def DECI:   f64 = 1.0e-1;
export def CENTI:  f64 = 1.0e-2;
export def MILLI:  f64 = 1.0e-3;
export def MICRO:  f64 = 1.0e-6;
export def NANO:   f64 = 1.0e-9;
export def PICO:   f64 = 1.0e-12;
export def FEMTO:  f64 = 1.0e-15;
export def ATTO:   f64 = 1.0e-18;
export def ZEPTO:  f64 = 1.0e-21;
export def YOCTO:  f64 = 1.0e-24;
export def RONTO:  f64 = 1.0e-27;
export def QUECTO: f64 = 1.0e-30;

def name_quetta = "quetta";
def name_ronna = "ronna";
def name_yotta = "yotta";
def name_zetta = "zetta";
def name_exa   = "exa";
def name_peta  = "peta";
def name_tera  = "tera";
def name_giga  = "giga";
def name_mega  = "mega";
def name_kilo  = "kilo";
def name_hecto = "hecto";
def name_deca  = "deca";
def name_none  = "";
def name_deci  = "deci";
def name_centi = "centi";
def name_milli = "milli";
def name_micro = "micro";
def name_nano  = "nano";
def name_pico  = "pico";
def name_femto = "femto";
def name_atto  = "atto";
def name_zepto = "zepto";
def name_yocto = "yocto";
def name_ronto = "rocto";
def name_quecto = "quecto";

def sym_quetta = "Q";
def sym_ronna = "R";
def sym_yotta = "Y";
def sym_zetta = "Z";
def sym_exa   = "E";
def sym_peta  = "P";
def sym_tera  = "T";
def sym_giga  = "G";
def sym_mega  = "M";
def sym_kilo  = "k";
def sym_hecto = "h";
def sym_deca  = "da";
def sym_deci  = "d";
def sym_centi = "c";
def sym_milli = "m";
def sym_micro = "μ";
def sym_nano  = "n";
def sym_pico  = "p";
def sym_femto = "f";
def sym_atto  = "a";
def sym_zepto = "z";
def sym_yocto = "y";
def sym_ronto = "r";
def sym_quecto = "q";

def sym_micro_ascii = "u";
def sym_mu          = "μ";



// Unit prefix decimal exponents
export type prefix_kind = enum i8 {
	QUETTA, RONNA, YOTTA, ZETTA, EXA, PETA, TERA, GIGA, MEGA, KILO, HECTO, 
	DECA, NONE, DECI, CENTI, MILLI, MICRO, NANO, PICO, FEMTO, ATTO, ZEPTO,
	YOCTO, RONTO, QUECTO,
};

def prefix_scale: [_]f64 = [
	QUETTA, RONNA, YOTTA, ZETTA, EXA, PETA, TERA, GIGA, MEGA, KILO, HECTO,
	DECA, NONE, DECI, CENTI, MILLI, MICRO, NANO, PICO, FEMTO, ATTO, ZEPTO,
	YOCTO, RONTO, QUECTO,
];

def prefix_names: [_]str = [
	name_quetta, name_ronna, name_yotta, name_zetta, name_exa, name_peta,
	name_tera, name_giga, name_mega, name_kilo, name_hecto, name_deca, name_none,
	name_deci, name_centi, name_milli, name_micro, name_nano, name_pico,
	name_femto, name_atto, name_zepto, name_yocto, name_ronto, name_quecto
];

def prefix_symbols_ascii: [_]str = [
	sym_quetta, sym_ronna, sym_yotta, sym_zetta, sym_exa, sym_peta,
	sym_tera, sym_giga, sym_mega, sym_kilo, sym_hecto, sym_deca, sym_none,
	sym_deci, sym_centi, sym_milli, sym_micro_ascii, sym_nano, sym_pico,
	sym_femto, sym_atto, sym_zepto, sym_yocto, sym_ronto, sym_quecto
];

def prefix_symbols_utf8: [_]str = [
	sym_quetta, sym_ronna, sym_yotta, sym_zetta, sym_exa, sym_peta,
	sym_tera, sym_giga, sym_mega, sym_kilo, sym_hecto, sym_deca, sym_none,
	sym_deci, sym_centi, sym_milli, sym_micro, sym_nano, sym_pico,
	sym_femto, sym_atto, sym_zepto, sym_yocto, sym_ronto, sym_quecto
];

def prefix_lookup: [_]symbol = [
	symbol { repr = sym_exa, kind = prefix_kind::EXA },
	symbol { repr = sym_giga, kind = prefix_kind::GIGA },
	symbol { repr = sym_mega, kind = prefix_kind::MEGA },
	symbol { repr = sym_peta, kind = prefix_kind::PETA },
	symbol { repr = sym_quetta, kind = prefix_kind::QUETTA },
	symbol { repr = sym_ronna, kind = prefix_kind::RONNA },
	symbol { repr = sym_tera, kind = prefix_kind::TERA },
	symbol { repr = sym_yotta, kind = prefix_kind::YOTTA },
	symbol { repr = sym_zetta, kind = prefix_kind::ZETTA },
	symbol { repr = sym_atto, kind = prefix_kind::ATTO },
	symbol { repr = sym_centi, kind = prefix_kind::CENTI },
	symbol { repr = sym_deci, kind = prefix_kind::DECI },
	symbol { repr = sym_deca, kind = prefix_kind::DECA },
	symbol { repr = sym_femto, kind = prefix_kind::FEMTO },
	symbol { repr = sym_hecto, kind = prefix_kind::HECTO },
	symbol { repr = sym_kilo, kind = prefix_kind::KILO },
	symbol { repr = sym_milli, kind = prefix_kind::MILLI },
	symbol { repr = sym_nano, kind = prefix_kind::NANO },
	symbol { repr = sym_pico, kind = prefix_kind::PICO },
	symbol { repr = sym_quecto, kind = prefix_kind::QUECTO },
	symbol { repr = sym_ronto, kind = prefix_kind::RONTO },
	symbol { repr = sym_yocto, kind = prefix_kind::YOCTO },
	symbol { repr = sym_zepto, kind = prefix_kind::ZEPTO },
	symbol { repr = sym_micro_ascii, kind = prefix_kind::MICRO },
	symbol { repr = sym_micro, kind = prefix_kind::MICRO },
	symbol { repr = sym_mu, kind = prefix_kind::MICRO },
];
