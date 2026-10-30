

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
	ASTRONOMICAL_UNIT,
	BECQUEREL,
	BEL,
	CANDELA,
	COULOMB,
	DALTON,
	DAY,
	DEGREE,
	DEGREE_CELSIUS,
	ELECTRONVOLT,
	FARAD,
	GRAM,
	GRAY,
	HECTARE,
	HENRY,
	HERTZ,
	HOUR,
	JOULE,
	KATAL,
	KELVIN,
	LITRE,
	LUMEN,
	LUX,
	METRE,
	MINUTE,
	MOLE,
	NEPER,
	NEWTON,
	OHM,
	PASCAL,
	RADIAN,
	SECOND,
	SIEMENS,
	SIEVERT,
	STERADIAN,
	TESLA,
	TONNE,
	VOLT,
	WATT,
	WEBER,
};

def sym_ampere               = "A";
def sym_astronomical_unit    = "au";
def sym_becquerel            = "Bq";
def sym_bel                  = "B";
def sym_candela              = "cd";
def sym_coulomb              = "C";
def sym_dalton               = "Da";
def sym_day                  = "d";
def sym_degree_ascii         = "deg";
def sym_degree_celsius_ascii = "degC";
def sym_degree_celsius_utf8  = "°C";
def sym_degree_utf8          = "°";
def sym_electronvolt         = "eV";
def sym_farad                = "F";
def sym_gram                 = "g";
def sym_gray                 = "Gy";
def sym_hectare              = "ha";
def sym_henry                = "H";
def sym_hertz                = "Hz";
def sym_hour                 = "h";
def sym_joule                = "J";
def sym_katal                = "kat";
def sym_kelvin               = "K";
def sym_litre                = "L";
def sym_lumen                = "lm";
def sym_lux                  = "lx";
def sym_metre                = "m";
def sym_minute               = "min";
def sym_mole                 = "mol";
def sym_neper                = "Np";
def sym_newton               = "N";
def sym_ohm_ascii            = "ohm";
def sym_ohm_utf8             = "Ω";
def sym_pascal               = "Pa";
def sym_radian               = "rad";
def sym_second               = "s";
def sym_siemens              = "S";
def sym_sievert              = "Sv";
def sym_steradian            = "sr";
def sym_tesla                = "T";
def sym_tonne                = "t";
def sym_volt                 = "V";
def sym_watt                 = "W";
def sym_weber                = "Wb";

def name_ampere              = "ampere";
def name_astronomical_unit   = "astronomical_unit";
def name_becquerel           = "becquerel";
def name_bel                 = "bel";
def name_candela             = "candela";
def name_coulomb             = "coulomb";
def name_dalton              = "dalton";
def name_day                 = "day";
def name_degree              = "degree";
def name_degree_celsius      = "degree Celsius";
def name_electronvolt        = "electronvolt";
def name_farad               = "farad";
def name_gram                = "gram";
def name_gray                = "gray";
def name_hectare             = "hectare";
def name_henry               = "henry";
def name_hertz               = "hertz";
def name_hour                = "hour";
def name_joule               = "joule";
def name_katal               = "katal";
def name_kelvin              = "kelvin";
def name_litre               = "litre";
def name_lumen               = "lumen";
def name_lux                 = "lux";
def name_metre               = "metre";
def name_minute              = "minute";
def name_mole                = "mole";
def name_neper               = "neper";
def name_newton              = "newton";
def name_ohm                 = "ohm";
def name_pascal              = "pascal";
def name_radian              = "radian";
def name_second              = "second";
def name_siemens             = "siemens";
def name_sievert             = "sievert";
def name_steradian           = "steradian";
def name_tesla               = "tesla";
def name_tonne               = "tonne";
def name_volt                = "volt";
def name_watt                = "watt";
def name_weber               = "weber";

def symbols_utf8: [_]str = [
	sym_ampere,
	sym_astronomical_unit,
	sym_becquerel,
	sym_bel,
	sym_candela,
	sym_coulomb,
	sym_dalton,
	sym_day,
	sym_degree_utf8,
	sym_degree_celsius_utf8,
	sym_electronvolt,
	sym_farad,
	sym_gram,
	sym_gray,
	sym_hectare,
	sym_henry,
	sym_hertz,
	sym_hour,
	sym_joule,
	sym_katal,
	sym_kelvin,
	sym_litre,
	sym_lumen,
	sym_lux,
	sym_metre,
	sym_minute,
	sym_mole,
	sym_neper,
	sym_newton,
	sym_ohm_utf8,
	sym_pascal,
	sym_radian,
	sym_second,
	sym_siemens,
	sym_sievert,
	sym_steradian,
	sym_tesla,
	sym_tonne,
	sym_volt,
	sym_watt,
	sym_weber,
];

def symbols_ascii: [_]str = [
	sym_ampere,
	sym_astronomical_unit,
	sym_becquerel,
	sym_bel,
	sym_candela,
	sym_coulomb,
	sym_dalton,
	sym_day,
	sym_degree_ascii,
	sym_degree_celsius_ascii,
	sym_electronvolt,
	sym_farad,
	sym_gram,
	sym_gray,
	sym_hectare,
	sym_henry,
	sym_hertz,
	sym_hour,
	sym_joule,
	sym_katal,
	sym_kelvin,
	sym_litre,
	sym_lumen,
	sym_lux,
	sym_metre,
	sym_minute,
	sym_mole,
	sym_neper,
	sym_newton,
	sym_ohm_ascii,
	sym_pascal,
	sym_radian,
	sym_second,
	sym_siemens,
	sym_sievert,
	sym_steradian,
	sym_tesla,
	sym_tonne,
	sym_volt,
	sym_watt,
	sym_weber,
];

def unit_names: [_]str = [
	name_ampere,
	name_astronomical_unit,
	name_becquerel,
	name_bel,
	name_candela,
	name_coulomb,
	name_dalton,
	name_day,
	name_degree,
	name_degree_celsius,
	name_electronvolt,
	name_farad,
	name_gram,
	name_gray,
	name_hectare,
	name_henry,
	name_hertz,
	name_hour,
	name_joule,
	name_katal,
	name_kelvin,
	name_litre,
	name_lumen,
	name_lux,
	name_metre,
	name_minute,
	name_mole,
	name_neper,
	name_newton,
	name_ohm,
	name_pascal,
	name_radian,
	name_second,
	name_siemens,
	name_sievert,
	name_steradian,
	name_tesla,
	name_tonne,
	name_volt,
	name_watt,
	name_weber,
];

def units: [_]unit = [
	ampere,
	astronomical_unit,
	becquerel,
	bel,
	candela,
	coulomb,
	dalton,
	day,
	degree,
	degree_celsius,
	electronvolt,
	farad,
	gram,
	gray,
	hectare,
	henry,
	hertz,
	hour,
	joule,
	katal,
	kelvin,
	litre,
	lumen,
	lux,
	metre,
	minute,
	mole,
	neper,
	newton,
	ohm,
	pascal,
	radian,
	second,
	siemens,
	sievert,
	steradian,
	tesla,
	tonne,
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

// Reciprocal base dimensions
def reciprocal_mass        = dimension { mass        = -1, ...};
def wavenumber             = dimension { length      = -1, ...};
def reciprocal_time        = dimension { time        = -1, ...};
def reciprocal_current     = dimension { current     = -1, ...};
def reciprocal_temperature = dimension { temperature = -1, ...};
def reciprocal_substance   = dimension { substance   = -1, ...};
def reciprocal_luminosity  = dimension { luminosity  = -1, ...};

// Derived dimensions with named symbols
def absorbed_dose         = dimension { length     = 2,  time       = -2, ...                                 };
def activity              = dimension { time       = -1, ...                                                  };
def capacitance           = dimension { mass       = -1, length     = -2, time    = 4,  current     = 2,  ... };
def catalytic_activity    = dimension { time       = -1, substance  = 1,  ...                                 };
def conductance           = dimension { mass       = -1, length     = -2, time    = 3,  current     = 2,  ... };
def dose_equivalent       = dimension { length     = 2,  time       = -2, ...                                 };
def electric_charge       = dimension { time       = 1,  current    = 1,  ...                                 };
def electric_potential    = dimension { mass       = 1,  length     = 2,  time    = -3, current     = -1, ... };
def energy                = dimension { mass       = 1,  length     = 2,  time    = -2, ...                   };
def force                 = dimension { mass       = 1,  length     = 1,  time    = -2, ...                   };
def frequency             = dimension { time       = -1, ...                                                  };
def illuminance           = dimension { length     = -2, luminosity = 1,  ...                                 };
def inductance            = dimension { mass       = 1,  length     = 2,  time    = -2, current     = -2, ... };
def luminous_flux         = dimension { luminosity = 1,  ...                                                  };
def magnetic_flux         = dimension { mass       = 1,  length     = 2,  time    = -2, current     = -1, ... };
def magnetic_flux_density = dimension { mass       = 1,  time       = -2, current = -1, ...                   };
def power                 = dimension { mass       = 1,  length     = 2,  time    = -3, ...                   };
def pressure              = dimension { mass       = 1,  length     = -1, time    = -2, ...                   };
def resistance            = dimension { mass       = 1,  length     = 2,  time    = -3, current     = -2, ... };

// Derived dimensions with compound units
def acceleration            = dimension { length     = 1,  time   = -2, ...                              };
def action                  = dimension { mass       = 1,  length = 2,  time = -1, ...                   };
def area                    = dimension { length     = 2,  ...                                           };
def concentration           = dimension { substance  = 1,  length = -3, ...                              };
def current_density         = dimension { current    = 1,  length = -2, ...                              };
def density                 = dimension { mass       = 1,  length = -3, ...                              };
def entropy                 = dimension { mass       = 1,  length = 2,  time = -2, temperature = -1, ... };
def luminance               = dimension { luminosity = 1,  length = -2, ...                              };
def luminous_efficacy       = dimension { mass       = -1, length = -2, time = 3,  luminosity  = 1,  ... };
def magnetic_field_strength = dimension { current    = 1,  length = -1, ...                              };
def specific_volume         = dimension { mass       = -1, length = 3,  ...                              };
def surface_density         = dimension { mass       = 1,  length = -2, ...                              };
def velocity                = dimension { length     = 1,  time   = -1, ...                              };
def volume                  = dimension { length     = 3,  ...                                           };

// Base units
def ampere              = unit { dim = current,                scale = 1.0               };
def candela             = unit { dim = luminosity,             scale = 1.0               };
def kelvin              = unit { dim = temperature,            scale = 1.0               };
def kilogram            = unit { dim = mass,                   scale = 1.0               };
def metre               = unit { dim = length,                 scale = 1.0               };
def mole                = unit { dim = substance,              scale = 1.0               };
def second              = unit { dim = time,                   scale = 1.0               };

// Reciprocal base units
def reciprocal_ampere   = unit { dim = reciprocal_current,     scale = 1.0               };
def reciprocal_candela  = unit { dim = reciprocal_luminosity,  scale = 1.0               };
def reciprocal_kelvin   = unit { dim = reciprocal_temperature, scale = 1.0               };
def reciprocal_kilogram = unit { dim = reciprocal_mass,        scale = 1.0               };
def reciprocal_metre    = unit { dim = wavenumber,             scale = 1.0               };
def reciprocal_mole     = unit { dim = reciprocal_substance,   scale = 1.0               };
def reciprocal_second   = unit { dim = reciprocal_time,        scale = 1.0               };

// Derived units
def becquerel           = unit { dim = activity,               scale = 1.0               };
def coulomb             = unit { dim = electric_charge,        scale = 1.0               };
def degree_celsius      = unit { dim = temperature,            scale = 1.0               };
def farad               = unit { dim = capacitance,            scale = 1.0               };
def gram                = unit { dim = mass,                   scale = 1e-3              };
def gray                = unit { dim = absorbed_dose,          scale = 1.0               };
def henry               = unit { dim = inductance,             scale = 1.0               };
def hertz               = unit { dim = frequency,              scale = 1.0               };
def joule               = unit { dim = energy,                 scale = 1.0               };
def katal               = unit { dim = catalytic_activity,     scale = 1.0               };
def lumen               = unit { dim = luminous_flux,          scale = 1.0               };
def lux                 = unit { dim = illuminance,            scale = 1.0               };
def newton              = unit { dim = force,                  scale = 1.0               };
def ohm                 = unit { dim = resistance,             scale = 1.0               };
def pascal              = unit { dim = pressure,               scale = 1.0               };
def radian              = unit { dim = dimensionless,          scale = 1.0               };
def siemens             = unit { dim = conductance,            scale = 1.0               };
def sievert             = unit { dim = dose_equivalent,        scale = 1.0               };
def steradian           = unit { dim = dimensionless,          scale = 1.0               };
def tesla               = unit { dim = magnetic_flux_density,  scale = 1.0               };
def volt                = unit { dim = electric_potential,     scale = 1.0               };
def watt                = unit { dim = power,                  scale = 1.0               };
def weber               = unit { dim = magnetic_flux,          scale = 1.0               };

// Non-SI
def astronomical_unit   = unit { dim = length,                 scale = 149597870700.0    };
def bel                 = unit { dim = dimensionless,          scale = 1.0               };
def dalton              = unit { dim = mass,                   scale = 1.66053906892e-27 };
def day                 = unit { dim = time,                   scale = 86400.0           };
def degree              = unit { dim = dimensionless,          scale = 1.0               };
def electronvolt        = unit { dim = energy,                 scale = 1.602176634e-19   };
def hectare             = unit { dim = area,                   scale = 10000.0           };
def hour                = unit { dim = time,                   scale = 3600.0            };
def litre               = unit { dim = volume,                 scale = 0.001             };
def minute              = unit { dim = time,                   scale = 60.0              };
def neper               = unit { dim = dimensionless,          scale = 1.0               };
def tonne               = unit { dim = mass,                   scale = 1000.0            };

// Coherent derived units
def ampere_per_metre          = unit { dim = magnetic_field_strength, scale = 1.0 };
def ampere_per_square_metre   = unit { dim = current_density,         scale = 1.0 };
def candela_per_square_metre  = unit { dim = luminance,               scale = 1.0 };
def cubic_metre               = unit { dim = volume,                  scale = 1.0 };
def cubic_metre_per_kilogram  = unit { dim = specific_volume,         scale = 1.0 };
def kilogram_per_cubic_metre  = unit { dim = density,                 scale = 1.0 };
def kilogram_per_square_metre = unit { dim = surface_density,         scale = 1.0 };
def lumen_per_watt            = unit { dim = luminous_efficacy,       scale = 1.0 };
def metre_per_second          = unit { dim = velocity,                scale = 1.0 };
def metre_per_second_squared  = unit { dim = acceleration,            scale = 1.0 };
def mole_per_cubic_metre      = unit { dim = concentration,           scale = 1.0 };
def square_metre              = unit { dim = area,                    scale = 1.0 };

// Non-coherent derived units
def joule_per_kelvin = unit { dim = entropy, scale = 1.0 };
def joule_second = unit { dim = action, scale = 1.0 };

// Constants
def speed_of_light                   = quantity { unit = metre_per_second,  value = 299792458.0     };
def boltzmann                        = quantity { unit = joule_per_kelvin,  value = 1.380649e-23    };
def planck                           = quantity { unit = joule_second,      value = 6.62607015e-34  };
def elementary_charge                = quantity { unit = coulomb,           value = 1.602176634e-19 };
def avogadro                         = quantity { unit = reciprocal_mole,   value = 6.02214076e23   };
def hyperfine_transition_caesium_133 = quantity { unit = hertz,             value = 9192631770.0    };
def luminous_efficacy_540_THz        = quantity { unit = lumen_per_watt,    value = 683.0           };

def symbol_lookup: [_]symbol = [
	symbol { repr = "A",    kind = unit_kind::AMPERE            },
	symbol { repr = "B",    kind = unit_kind::BEL               },
	symbol { repr = "Bq",   kind = unit_kind::BECQUEREL         },
	symbol { repr = "C",    kind = unit_kind::COULOMB           },
	symbol { repr = "Da",   kind = unit_kind::DALTON            },
	symbol { repr = "F",    kind = unit_kind::FARAD             },
	symbol { repr = "Gy",   kind = unit_kind::GRAY              },
	symbol { repr = "H",    kind = unit_kind::HENRY             },
	symbol { repr = "Hz",   kind = unit_kind::HERTZ             },
	symbol { repr = "J",    kind = unit_kind::JOULE             },
	symbol { repr = "K",    kind = unit_kind::KELVIN            },
	symbol { repr = "L",    kind = unit_kind::LITRE             },
	symbol { repr = "N",    kind = unit_kind::NEWTON            },
	symbol { repr = "Np",   kind = unit_kind::NEPER             },
	symbol { repr = "Pa",   kind = unit_kind::PASCAL            },
	symbol { repr = "S",    kind = unit_kind::SIEMENS           },
	symbol { repr = "Sv",   kind = unit_kind::SIEVERT           },
	symbol { repr = "T",    kind = unit_kind::TESLA             },
	symbol { repr = "V",    kind = unit_kind::VOLT              },
	symbol { repr = "W",    kind = unit_kind::WATT              },
	symbol { repr = "Wb",   kind = unit_kind::WEBER             },
	symbol { repr = "au",   kind = unit_kind::ASTRONOMICAL_UNIT },
	symbol { repr = "cd",   kind = unit_kind::CANDELA           },
	symbol { repr = "d",    kind = unit_kind::DAY               },
	symbol { repr = "deg",  kind = unit_kind::DEGREE            },
	symbol { repr = "degC", kind = unit_kind::DEGREE_CELSIUS    },
	symbol { repr = "eV",   kind = unit_kind::ELECTRONVOLT      },
	symbol { repr = "g",    kind = unit_kind::GRAM              },
	symbol { repr = "h",    kind = unit_kind::HOUR              },
	symbol { repr = "ha",   kind = unit_kind::HECTARE           },
	symbol { repr = "kat",  kind = unit_kind::KATAL             },
	symbol { repr = "l",    kind = unit_kind::LITRE             },
	symbol { repr = "lm",   kind = unit_kind::LUMEN             },
	symbol { repr = "lx",   kind = unit_kind::LUX               },
	symbol { repr = "m",    kind = unit_kind::METRE             },
	symbol { repr = "min",  kind = unit_kind::MINUTE            },
	symbol { repr = "mol",  kind = unit_kind::MOLE              },
	symbol { repr = "ohm",  kind = unit_kind::OHM               },
	symbol { repr = "rad",  kind = unit_kind::RADIAN            },
	symbol { repr = "s",    kind = unit_kind::SECOND            },
	symbol { repr = "sr",   kind = unit_kind::STERADIAN         },
	symbol { repr = "t",    kind = unit_kind::TONNE             },
	symbol { repr = "°",    kind = unit_kind::DEGREE            },
	symbol { repr = "°C",   kind = unit_kind::DEGREE_CELSIUS    },
	symbol { repr = "Ω",    kind = unit_kind::OHM               },
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
