def name_yotta = "yotta";
def name_zetta = "zetta";
def name_exa = "exa";
def name_peta = "peta";
def name_tera = "tera";
def name_giga = "giga";
def name_mega = "mega";
def name_kilo = "kilo";
def name_hecto = "hecto";
def name_deca = "deca";
def name_deci = "deci";
def name_centi = "centi";
def name_milli = "milli";
def name_micro = "micro";
def name_nano = "nano";
def name_pico = "pico";
def name_femto = "femto";
def name_atto = "atto";
def name_zepto = "zepto";
def name_yocto = "yocto";

def sym_yotta = "Y";
def sym_zetta = "Z";
def sym_exa = "E";
def sym_peta = "P";
def sym_tera = "T";
def sym_giga = "G";
def sym_mega = "M";
def sym_kilo = "k";
def sym_hecto = "h";
def sym_deca = "da";
def sym_deci = "d";
def sym_centi = "c";
def sym_milli = "m";
def sym_micro = "μ";
def sym_nano = "n";
def sym_pico = "p";
def sym_femto = "f";
def sym_atto = "a";
def sym_zepto = "z";
def sym_yocto = "y";

def sym_micro_ascii = "u";
def sym_mu          = "μ";

// Unit prefix decimal exponents
type prefix = enum i8 {
	YOTTA, ZETTA, EXA, PETA, TERA, GIGA, MEGA, KILO, HECTO, DECA, DECI, CENTI,
	MILLI, MICRO, NANO, PICO, FEMTO, ATTO, ZEPTO, YOCTO,
};

def prefix_scale: [_]f64 = [ 
	1.0e24, 1.0e21, 1.0e18, 1.0e15, 1.0e12, 1.0e9, 1.0e6, 1.0e3, 1.0e2, 1.0e1,
	1.0e-1, 1.0e-2, 1.0e-3, 1.0e-6, 1.0e-9, 1.0e-12, 1.0e-15, 1.0e-18, 1.0e-21,
	1.0e-24,];

def prefix_names: [_]str = [
	name_yotta, name_zetta, name_exa, name_peta, name_tera, name_giga, name_mega,
	name_kilo, name_hecto, name_deca, name_deci, name_centi, name_milli, name_micro,
	name_nano, name_pico, name_femto, name_atto, name_zepto, name_yocto,
];

def prefix_symbols_ascii: [_]str = [
	sym_yotta, sym_zetta, sym_exa, sym_peta, sym_tera, sym_giga, sym_mega, sym_kilo,
	sym_hecto, sym_deca, sym_deci, sym_centi, sym_milli, sym_micro_ascii, sym_nano,
	sym_pico, sym_femto, sym_atto, sym_zepto, sym_yocto,
];

def prefix_symbols_utf8: [_]str = [
	sym_yotta, sym_zetta, sym_exa, sym_peta, sym_tera, sym_giga, sym_mega, sym_kilo, 
	sym_hecto, sym_deca, sym_deci, sym_centi, sym_milli, sym_micro, sym_nano, 
	sym_pico, sym_femto, sym_atto, sym_zepto, sym_yocto,
];
