

// Unit prefix decimal exponents
type prefix = enum i8 {
	YOTTA,
	ZETTA,
	EXA,
	PETA,
	TERA,
	GIGA,
	MEGA,
	KILO,
	HECTO,
	DECA,
	DECI,
	CENTI,
	MILLI,
	MICRO,
	NANO,
	PICO,
	FEMTO,
	ATTO,
	ZEPTO,
	YOCTO,
};

def prefix_scale: [_]f64 = [
	1.0e24,  // YOTTA
	1.0e21,  // ZETTA
	1.0e18,  // EXA
	1.0e15,  // PETA
	1.0e12,  // TERA
	1.0e9,   // GIGA
	1.0e6,   // MEGA
	1.0e3,   // KILO
	1.0e2,   // HECTO
	1.0e1,   // DECA
	1.0e-1,  // DECI
	1.0e-2,  // CENTI
	1.0e-3,  // MILLI
	1.0e-6,  // MICRO
	1.0e-9,  // NANO
	1.0e-12, // PICO
	1.0e-15, // FEMTO
	1.0e-18, // ATTO
	1.0e-21, // ZEPTO
	1.0e-24, // YOCTO
];

def prefix_names: [_]str = [
	"yotta",
	"zetta",
	"exa",
	"peta",
	"tera",
	"giga",
	"mega",
	"kilo",
	"hecto",
	"deca",
	"deci",
	"centi",
	"milli",
	"micro",
	"nano",
	"pico",
	"femto",
	"atto",
	"zepto",
	"yocto",
];

def prefix_symbols_ascii: [_]rune = [
	'Y',
	'Z',
	'E',
	'P',
	'T',
	'G',
	'M',
	'k',
	'h',
	'd',
	'c',
	'm',
	'u',
	'n',
	'p',
	'f',
	'a',
	'z',
	'y',
];

def prefix_symbols_utf8: [_]rune = [
	'Y',
	'Z',
	'E',
	'P',
	'T',
	'G',
	'M',
	'k',
	'h',
	'd',
	'c',
	'm',
	'μ',
	'n',
	'p',
	'f',
	'a',
	'z',
	'y',
];

type base_unit = enum {
	KILOGRAM,
	METRE,
	SECOND,
	AMPERE,
	KELVIN,
	MOLE,
	CANDELA,
};

type base_dimension = enum size {
	MASS, 
	LENGTH,
	TIME,
	CURRENT,
	TEMPERATURE,
	SUBSTANCE,
	LUMINOSITY,
};

type unit_kind = enum int {
	AMPERE,
	BECQUEREL,
	CANDELA,
	COULOMB,
	DEGREE_CELSIUS,
	FARAD,
	GRAM,
	GRAY,
	HENRY,
	HERTZ,
	JOULE,
	KATAL,
	KELVIN,
	LUMEN,
	LUX,
	METRE,
	MOLE,
	NEWTON,
	OHM,
	PASCAL,
	RADIAN,
	SECOND,
	SIEMENS,
	SIEVERT,
	STERADIAN,
	TESLA,
	VOLT,
	WATT,
	WEBER,
};

def sym_ampere               = "A";
def sym_becquerel            = "Bq";
def sym_candela              = "cd";
def sym_coulomb              = "C";
def sym_degree_celsius_utf8  = "°C";
def sym_degree_celsius_ascii = "degC";
def sym_farad                = "F";
def sym_gram                 = "g";
def sym_gray                 = "Gy";
def sym_henry                = "H";
def sym_hertz                = "Hz";
def sym_joule                = "J";
def sym_katal                = "kat";
def sym_kelvin               = "K";
def sym_lumen                = "lm";
def sym_lux                  = "lx";
def sym_metre                = "m";
def sym_mole                 = "mol";
def sym_newton               = "N";
def sym_ohm_utf8             = "Ω";
def sym_ohm_ascii            = "ohm";
def sym_pascal               = "Pa";
def sym_radian               = "rad";
def sym_second               = "s";
def sym_siemens              = "S";
def sym_sievert              = "Sv";
def sym_steradian            = "sr";
def sym_tesla                = "T";
def sym_volt                 = "V";
def sym_watt                 = "W";
def sym_weber                = "Wb";

def name_ampere              = "ampere";
def name_becquerel           = "becquerel";
def name_candela             = "candela";
def name_coulomb             = "coulomb";
def name_degree_celsius      = "degree Celsius";
def name_farad               = "farad";
def name_gram                = "gram";
def name_gray                = "gray";
def name_henry               = "henry";
def name_hertz               = "hertz";
def name_joule               = "joule";
def name_katal               = "katal";
def name_kelvin              = "kelvin";
def name_lumen               = "lumen";
def name_lux                 = "lux";
def name_metre               = "metre";
def name_mole                = "mole";
def name_newton              = "newton";
def name_ohm                 = "ohm";
def name_pascal              = "pascal";
def name_radian              = "radian";
def name_second              = "second";
def name_siemens             = "siemens";
def name_sievert             = "sievert";
def name_steradian           = "steradian";
def name_tesla               = "tesla";
def name_volt                = "volt";
def name_watt                = "watt";
def name_weber               = "weber";

def symbols_utf8: [_]str = [
	sym_ampere,
	sym_becquerel,
	sym_candela,
	sym_coulomb,
	sym_degree_celsius_utf8,
	sym_farad,
	sym_gram,
	sym_gray,
	sym_henry,
	sym_hertz,
	sym_joule,
	sym_katal,
	sym_kelvin,
	sym_lumen,
	sym_lux,
	sym_metre,
	sym_mole,
	sym_newton,
	sym_ohm_utf8,
	sym_pascal,
	sym_radian,
	sym_second,
	sym_siemens,
	sym_sievert,
	sym_steradian,
	sym_tesla,
	sym_volt,
	sym_watt,
	sym_weber,
];

def symbols_ascii: [_]str = [
	sym_ampere,
	sym_becquerel,
	sym_candela,
	sym_coulomb,
	sym_degree_celsius_ascii,
	sym_farad,
	sym_gram,
	sym_gray,
	sym_henry,
	sym_hertz,
	sym_joule,
	sym_katal,
	sym_kelvin,
	sym_lumen,
	sym_lux,
	sym_metre,
	sym_mole,
	sym_newton,
	sym_ohm_ascii,
	sym_pascal,
	sym_radian,
	sym_second,
	sym_siemens,
	sym_sievert,
	sym_steradian,
	sym_tesla,
	sym_volt,
	sym_watt,
	sym_weber,
];

def unit_names: [_]str = [
	name_ampere,
	name_becquerel,
	name_candela,
	name_coulomb,
	name_degree_celsius,
	name_farad,
	name_gram,
	name_gray,
	name_henry,
	name_hertz,
	name_joule,
	name_katal,
	name_kelvin,
	name_lumen,
	name_lux,
	name_metre,
	name_mole,
	name_newton,
	name_ohm,
	name_pascal,
	name_radian,
	name_second,
	name_siemens,
	name_sievert,
	name_steradian,
	name_tesla,
	name_volt,
	name_watt,
	name_weber,
];

def units: [_]unit = [
	ampere,
	becquerel,
	candela,
	coulomb,
	degree_celsius,
	farad,
	gram,
	gray,
	henry,
	hertz,
	joule,
	katal,
	kelvin,
	lumen,
	lux,
	metre,
	mole,
	newton,
	ohm,
	pascal,
	radian,
	second,
	siemens,
	sievert,
	steradian,
	tesla,
	volt,
	watt,
	weber,
];


// Dimensionless
def dimensionless = dimension { ... };

// Returns true if unit is dimensionless
// fn is_dimensionless(u: unit) bool = u.dim.mass == 0 && u.dim.length == 0 && u.dim.time == 0
// 	&& u.dim.current == 0 && u.dim.temperature == 0 && u.dim.substance == 0 && u.dim.luminosity == 0;

// Base dimensions
def mass        = dimension { mass        = 1, ...};
def length      = dimension { length      = 1, ...};
def time        = dimension { time        = 1, ...};
def current     = dimension { current     = 1, ...};
def temperature = dimension { temperature = 1, ...};
def substance   = dimension { substance   = 1, ...};
def luminosity  = dimension { luminosity  = 1, ...};

// Derived dimensions
def absorbed_dose         = dimension { length     = 2,  time       = -2, ...                             };
def activity              = dimension { time       = -1, ...                                              };
def capacitance           = dimension { mass       = -1, length     = -2, time    = 4,  current = 2,  ... };
def catalytic_activity    = dimension { time       = -1, substance  = 1,  ...                             };
def conductance           = dimension { mass       = -1, length     = -2, time    = 3,  current = 2,  ... };
def dose_equivalent       = dimension { length     = 2,  time       = -2, ...                             };
def electric_charge       = dimension { time       = 1,  current    = 1,  ...                             };
def electric_potential    = dimension { mass       = 1,  length     = 2,  time    = -3, current = -1, ... };
def energy                = dimension { mass       = 1,  length     = 2,  time    = -2, ...               };
def force                 = dimension { mass       = 1,  length     = 1,  time    = -2, ...               };
def frequency             = dimension { time       = -1, ...                                              };
def illuminance           = dimension { length     = -2, luminosity = 1, ...                              };
def inductance            = dimension { mass       = 1,  length     = 2,  time    = -2, current = -2, ... };
def luminous_flux         = dimension { luminosity = 1,  ...                                              };
def magnetic_flux         = dimension { mass       = 1,  length     = 2,  time    = -2, current = -1, ... };
def magnetic_flux_density = dimension { mass       = 1,  time       = -2, current = -1, ...               };
def power                 = dimension { mass       = 1,  length     = 2,  time    = -3, ...               };
def pressure              = dimension { mass       = 1,  length     = -1, time    = -2, ...               };
def resistance            = dimension { mass       = 1,  length     = 2,  time    = -3, current = -2, ... };

def acceleration          = dimension { length     = 1,  time       = -2, ...                             };
def velocity              = dimension { length     = 1,  time       = -1, ...                             };
def area                  = dimension { length     = 2, ...                                               };
def volume                = dimension { length     = 3, ...                                               };

// Base units
def kilogram          = unit { dim = mass,                  scale = 1.0               };
def metre             = unit { dim = length,                scale = 1.0               };
def second            = unit { dim = time,                  scale = 1.0               };
def ampere            = unit { dim = current,               scale = 1.0               };
def kelvin            = unit { dim = temperature,           scale = 1.0               };
def mole              = unit { dim = substance,             scale = 1.0               };
def candela           = unit { dim = luminosity,            scale = 1.0               };

def gram              = unit { dim = mass,                  scale = 1e-3              };

// Derived units
def becquerel         = unit { dim = activity,              scale = 1.0               };
def coulomb           = unit { dim = electric_charge,       scale = 1.0               };
def degree_celsius    = unit { dim = temperature,           scale = 1.0               };
def farad             = unit { dim = capacitance,           scale = 1.0               };
def gray              = unit { dim = absorbed_dose,         scale = 1.0               };
def henry             = unit { dim = inductance,            scale = 1.0               };
def hertz             = unit { dim = frequency,             scale = 1.0               };
def joule             = unit { dim = energy,                scale = 1.0               };
def katal             = unit { dim = catalytic_activity,    scale = 1.0               };
def lumen             = unit { dim = luminous_flux,         scale = 1.0               };
def lux               = unit { dim = illuminance,           scale = 1.0               };
def newton            = unit { dim = force,                 scale = 1.0               };
def ohm               = unit { dim = resistance,            scale = 1.0               };
def pascal            = unit { dim = pressure,              scale = 1.0               };
def radian            = unit { dim = dimensionless,         scale = 1.0               };
def siemens           = unit { dim = conductance,           scale = 1.0               };
def sievert           = unit { dim = dose_equivalent,       scale = 1.0               };
def steradian         = unit { dim = dimensionless,         scale = 1.0               };
def tesla             = unit { dim = magnetic_flux_density, scale = 1.0               };
def volt              = unit { dim = electric_potential,    scale = 1.0               };
def watt              = unit { dim = power,                 scale = 1.0               };
def weber             = unit { dim = magnetic_flux,         scale = 1.0               };

// Non-SI
def minute            = unit { dim = time,                  scale = 60.0              };
def hour              = unit { dim = time,                  scale = 3600.0            };
def day               = unit { dim = time,                  scale = 86400.0           };
def astronomical_unit = unit { dim = length,                scale = 149597870700.0    };
def hectare           = unit { dim = area,                  scale = 10000.0           };
def litre             = unit { dim = volume,                scale = 0.001             };
def tonne             = unit { dim = mass,                  scale = 1000.0            };
def dalton            = unit { dim = mass,                  scale = 1.66053906892e-27 };
def electronvolt      = unit { dim = energy,                scale = 1.602176634e-19   };
def neper             = unit { dim = dimensionless,         scale = 1.0               };
def bel               = unit { dim = dimensionless,         scale = 1.0               };

def symbol_lookup: [_]symbol = [
	symbol { repr = "A",    kind = unit_kind::AMPERE         },
	symbol { repr = "Bq",   kind = unit_kind::BECQUEREL      },
	symbol { repr = "C",    kind = unit_kind::COULOMB        },
	symbol { repr = "F",    kind = unit_kind::FARAD          },
	symbol { repr = "Gy",   kind = unit_kind::GRAY           },
	symbol { repr = "H",    kind = unit_kind::HENRY          },
	symbol { repr = "Hz",   kind = unit_kind::HERTZ          },
	symbol { repr = "J",    kind = unit_kind::JOULE          },
	symbol { repr = "K",    kind = unit_kind::KELVIN         },
	symbol { repr = "N",    kind = unit_kind::NEWTON         },
	symbol { repr = "Pa",   kind = unit_kind::PASCAL         },
	symbol { repr = "S",    kind = unit_kind::SIEMENS        },
	symbol { repr = "Sv",   kind = unit_kind::SIEVERT        },
	symbol { repr = "T",    kind = unit_kind::TESLA          },
	symbol { repr = "V",    kind = unit_kind::VOLT           },
	symbol { repr = "W",    kind = unit_kind::WATT           },
	symbol { repr = "Wb",   kind = unit_kind::WEBER          },
	symbol { repr = "cd",   kind = unit_kind::CANDELA        },
	symbol { repr = "degC", kind = unit_kind::DEGREE_CELSIUS },
	symbol { repr = "g",    kind = unit_kind::GRAM           },
	symbol { repr = "kat",  kind = unit_kind::KATAL          },
	symbol { repr = "lm",   kind = unit_kind::LUMEN          },
	symbol { repr = "lx",   kind = unit_kind::LUX            },
	symbol { repr = "m",    kind = unit_kind::METRE          },
	symbol { repr = "mol",  kind = unit_kind::MOLE           },
	symbol { repr = "ohm",  kind = unit_kind::OHM            },
	symbol { repr = "rad",  kind = unit_kind::RADIAN         },
	symbol { repr = "s",    kind = unit_kind::SECOND         },
	symbol { repr = "sr",   kind = unit_kind::STERADIAN      },
	symbol { repr = "°C",   kind = unit_kind::DEGREE_CELSIUS },
	symbol { repr = "Ω",    kind = unit_kind::OHM            },
];


fn lookup_prefix(c: rune) (prefix | void) = return switch (c) {
	case 'Y' => yield prefix::YOTTA;
	case 'Z' => yield prefix::ZETTA;
	case 'E' => yield prefix::EXA;
	case 'P' => yield prefix::PETA;
	case 'T' => yield prefix::TERA;
	case 'G' => yield prefix::GIGA;
	case 'M' => yield prefix::MEGA;
	case 'k' => yield prefix::KILO;
	case 'h' => yield prefix::HECTO;
	case 'd' => yield prefix::DECI;
	case 'c' => yield prefix::CENTI;
	case 'm' => yield prefix::MILLI;
	case 'u', 'μ', 'µ'  => yield prefix::MICRO;
	case 'n' => yield prefix::NANO;
	case 'p' => yield prefix::PICO;
	case 'f' => yield prefix::FEMTO;
	case 'a' => yield prefix::ATTO;
	case 'z' => yield prefix::ZEPTO;
	case 'y' => yield prefix::YOCTO;
	case => void;
};

