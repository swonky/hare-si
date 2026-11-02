type symbol = struct {
	kind: (unit_kind | prefix_kind),
	repr: str,
};


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
def sym_kilogram             = "kg";
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
def name_astronomical_unit   = "astronomical unit";
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
def name_kilogram            = "kilogram";
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

def symbols_base: [_]str = [
	"kg",
	sym_metre,
	sym_second,
	sym_ampere,
	sym_kelvin,
	sym_mole,
	sym_candela,
];

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

def base_names: [_]str = [
	name_kilogram,
	name_metre,
	name_second,
	name_ampere,
	name_kelvin,
	name_mole,
	name_candela,
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
];

// Dimensionless
export def DIMENSIONLESS = dimension { ... };

// Base dimensions
export def MASS                    = dimension { mass        = 1,  ... };
export def LENGTH                  = dimension { length      = 1,  ... };
export def TIME                    = dimension { time        = 1,  ... };
export def CURRENT                 = dimension { current     = 1,  ... };
export def TEMPERATURE             = dimension { temperature = 1,  ... };
export def SUBSTANCE               = dimension { substance   = 1,  ... };
export def LUMINOSITY              = dimension { luminosity  = 1,  ... };

// ReciprocAL BASE DIMENSIONS
export def RECIPROCAL_MASS         = dimension { mass        = -1, ... };
export def WAVENUMBER              = dimension { length      = -1, ... };
export def FREQUENCY               = dimension { time        = -1, ... };
export def RECIPROCAL_CURRENT      = dimension { current     = -1, ... };
export def RECIPROCAL_TEMPERATURE  = dimension { temperature = -1, ... };
export def RECIPROCAL_SUBSTANCE    = dimension { substance   = -1, ... };
export def RECIPROCAL_LUMINOSITY   = dimension { luminosity  = -1, ... };

// Derived DIMENSIONS WITH NAMED SYmbols
export def ABSORBED_DOSE           = dimension { length      = 2,  time       = -2, ...                                 };
export def ACTIVITY                = dimension { time        = -1, ...                                                  };
export def CAPACITANCE             = dimension { mass        = -1, length     = -2, time    = 4,  current     = 2,  ... };
export def CATALYTIC_ACTIVITY      = dimension { time        = -1, substance  = 1,  ...                                 };
export def CONDUCTANCE             = dimension { mass        = -1, length     = -2, time    = 3,  current     = 2,  ... };
export def DOSE_EQUIVALENT         = dimension { length      = 2,  time       = -2, ...                                 };
export def ELECTRIC_CHARGE         = dimension { time        = 1,  current    = 1,  ...                                 };
export def ELECTRIC_POTENTIAL      = dimension { mass        = 1,  length     = 2,  time    = -3, current     = -1, ... };
export def ENERGY                  = dimension { mass        = 1,  length     = 2,  time    = -2, ...                   };
export def FORCE                   = dimension { mass        = 1,  length     = 1,  time    = -2, ...                   };
export def ILLUMINANCE             = dimension { length      = -2, luminosity = 1,  ...                                 };
export def INDUCTANCE              = dimension { mass        = 1,  length     = 2,  time    = -2, current     = -2, ... };
export def LUMINOUS_FLUX           = dimension { luminosity  = 1,  ...                                                  };
export def MAGNETIC_FLUX           = dimension { mass        = 1,  length     = 2,  time    = -2, current     = -1, ... };
export def MAGNETIC_FLUX_DENSITY   = dimension { mass        = 1,  time       = -2, current = -1, ...                   };
export def POWER                   = dimension { mass        = 1,  length     = 2,  time    = -3, ...                   };
export def PRESSURE                = dimension { mass        = 1,  length     = -1, time    = -2, ...                   };
export def RESISTANCE              = dimension { mass        = 1,  length     = 2,  time    = -3, current     = -2, ... };

// Derived DIMENSIONS WITH COMPOUND units
export def ACCELERATION            = dimension { length      = 1,  time       = -2, ...                                 };
export def ACTION                  = dimension { mass        = 1,  length     = 2,  time    = -1, ...                   };
export def AREA                    = dimension { length      = 2,  ...                                                  };
export def CONCENTRATION           = dimension { substance   = 1,  length     = -3, ...                                 };
export def CURRENT_DENSITY         = dimension { current     = 1,  length     = -2, ...                                 };
export def DENSITY                 = dimension { mass        = 1,  length     = -3, ...                                 };
export def ENTROPY                 = dimension { mass        = 1,  length     = 2,  time    = -2, temperature = -1, ... };
export def LUMINANCE               = dimension { luminosity  = 1,  length     = -2, ...                                 };
export def LUMINOUS_EFFICACY       = dimension { mass        = -1, length     = -2, time    = 3,  luminosity  = 1,  ... };
export def MAGNETIC_FIELD_STRENGTH = dimension { current     = 1,  length     = -1, ...                                 };
export def SPECIFIC_VOLUME         = dimension { mass        = -1, length     = 3,  ...                                 };
export def SURFACE_DENSITY         = dimension { mass        = 1,  length     = -2, ...                                 };
export def VELOCITY                = dimension { length      = 1,  time       = -1, ...                                 };
export def VOLUME                  = dimension { length      = 3,  ...                                                  };

// Base units
export def AMPERE                           = unit     { dim  = CURRENT,                 scale = 1.0                    };
export def CANDELA                          = unit     { dim  = LUMINOSITY,              scale = 1.0                    };
export def KELVIN                           = unit     { dim  = TEMPERATURE,             scale = 1.0                    };
export def KILOGRAM                         = unit     { dim  = MASS,                    scale = 1.0                    };
export def METRE                            = unit     { dim  = LENGTH,                  scale = 1.0                    };
export def MOLE                             = unit     { dim  = SUBSTANCE,               scale = 1.0                    };
export def SECOND                           = unit     { dim  = TIME,                    scale = 1.0                    };

// Reciprocal base units
export def RECIPROCAL_AMPERE                = unit     { dim  = RECIPROCAL_CURRENT,      scale = 1.0                    };
export def RECIPROCAL_CANDELA               = unit     { dim  = RECIPROCAL_LUMINOSITY,   scale = 1.0                    };
export def RECIPROCAL_KELVIN                = unit     { dim  = RECIPROCAL_TEMPERATURE,  scale = 1.0                    };
export def RECIPROCAL_KILOGRAM              = unit     { dim  = RECIPROCAL_MASS,         scale = 1.0                    };
export def RECIPROCAL_METRE                 = unit     { dim  = WAVENUMBER,              scale = 1.0                    };
export def RECIPROCAL_MOLE                  = unit     { dim  = RECIPROCAL_SUBSTANCE,    scale = 1.0                    };
export def HERTZ                            = unit     { dim  = FREQUENCY,               scale = 1.0                    };

// Derived units
export def BECQUEREL                        = unit     { dim  = ACTIVITY,                scale = 1.0                    };
export def COULOMB                          = unit     { dim  = ELECTRIC_CHARGE,         scale = 1.0                    };
export def DEGREE_CELSIUS                   = unit     { dim  = TEMPERATURE,             scale = 1.0                    };
export def FARAD                            = unit     { dim  = CAPACITANCE,             scale = 1.0                    };
export def GRAM                             = unit     { dim  = MASS,                    scale = 1e-3                   };
export def GRAY                             = unit     { dim  = ABSORBED_DOSE,           scale = 1.0                    };
export def HENRY                            = unit     { dim  = INDUCTANCE,              scale = 1.0                    };
export def JOULE                            = unit     { dim  = ENERGY,                  scale = 1.0                    };
export def KATAL                            = unit     { dim  = CATALYTIC_ACTIVITY,      scale = 1.0                    };
export def LUMEN                            = unit     { dim  = LUMINOUS_FLUX,           scale = 1.0                    };
export def LUX                              = unit     { dim  = ILLUMINANCE,             scale = 1.0                    };
export def NEWTON                           = unit     { dim  = FORCE,                   scale = 1.0                    };
export def OHM                              = unit     { dim  = RESISTANCE,              scale = 1.0                    };
export def PASCAL                           = unit     { dim  = PRESSURE,                scale = 1.0                    };
export def RADIAN                           = unit     { dim  = DIMENSIONLESS,           scale = 1.0                    };
export def SIEMENS                          = unit     { dim  = CONDUCTANCE,             scale = 1.0                    };
export def SIEVERT                          = unit     { dim  = DOSE_EQUIVALENT,         scale = 1.0                    };
export def STERADIAN                        = unit     { dim  = DIMENSIONLESS,           scale = 1.0                    };
export def TESLA                            = unit     { dim  = MAGNETIC_FLUX_DENSITY,   scale = 1.0                    };
export def VOLT                             = unit     { dim  = ELECTRIC_POTENTIAL,      scale = 1.0                    };
export def WATT                             = unit     { dim  = POWER,                   scale = 1.0                    };
export def WEBER                            = unit     { dim  = MAGNETIC_FLUX,           scale = 1.0                    };

// Non-SI
export def ASTRONOMICAL_UNIT                = unit     { dim  = LENGTH,                  scale = 1.495978707e11         };
export def BEL                              = unit     { dim  = DIMENSIONLESS,           scale = 1.0                    };
export def DALTON                           = unit     { dim  = MASS,                    scale = 1.66053906892e-27      };
export def DAY                              = unit     { dim  = TIME,                    scale = 8.64e4                 };
export def DEGREE                           = unit     { dim  = DIMENSIONLESS,           scale = 1.7453292519943295e-2  };
export def ELECTRONVOLT                     = unit     { dim  = ENERGY,                  scale = 1.602176634e-19        };
export def HECTARE                          = unit     { dim  = AREA,                    scale = 10000.0                };
export def HOUR                             = unit     { dim  = TIME,                    scale = 3.6e3                  };
export def LITRE                            = unit     { dim  = VOLUME,                  scale = 1.0e-3                 };
export def MINUTE                           = unit     { dim  = TIME,                    scale = 6.0e1                  };
export def NEPER                            = unit     { dim  = DIMENSIONLESS,           scale = 1.0                    };
export def TONNE                            = unit     { dim  = MASS,                    scale = 1.0e3                  };

// Coherent derived units
export def AMPERE_PER_METRE                 = unit     { dim  = MAGNETIC_FIELD_STRENGTH, scale = 1.0                    };
export def AMPERE_PER_SQUARE_METRE          = unit     { dim  = CURRENT_DENSITY,         scale = 1.0                    };
export def CANDELA_PER_SQUARE_METRE         = unit     { dim  = LUMINANCE,               scale = 1.0                    };
export def CUBIC_METRE                      = unit     { dim  = VOLUME,                  scale = 1.0                    };
export def CUBIC_METRE_PER_KILOGRAM         = unit     { dim  = SPECIFIC_VOLUME,         scale = 1.0                    };
export def KILOGRAM_PER_CUBIC_METRE         = unit     { dim  = DENSITY,                 scale = 1.0                    };
export def KILOGRAM_PER_SQUARE_METRE        = unit     { dim  = SURFACE_DENSITY,         scale = 1.0                    };
export def LUMEN_PER_WATT                   = unit     { dim  = LUMINOUS_EFFICACY,       scale = 1.0                    };
export def METRE_PER_SECOND                 = unit     { dim  = VELOCITY,                scale = 1.0                    };
export def METRE_PER_SECOND_SQUARED         = unit     { dim  = ACCELERATION,            scale = 1.0                    };
export def MOLE_PER_CUBIC_METRE             = unit     { dim  = CONCENTRATION,           scale = 1.0                    };
export def SQUARE_METRE                     = unit     { dim  = AREA,                    scale = 1.0                    };

// Non-coherent derived units
export def JOULE_PER_KELVIN                 = unit     { dim  = ENTROPY,                 scale = 1.0                    };
export def JOULE_SECOND                     = unit     { dim  = ACTION,                  scale = 1.0                    };

// Constants
export def SPEED_OF_LIGHT                   = quantity { unit = METRE_PER_SECOND,        value = 299792458.0            };
export def BOLTZMANN                        = quantity { unit = JOULE_PER_KELVIN,        value = 1.380649e-23           };
export def PLANCK                           = quantity { unit = JOULE_SECOND,            value = 6.62607015e-34         };
export def ELEMENTARY_CHARGE                = quantity { unit = COULOMB,                 value = 1.602176634e-19        };
export def AVOGADRO                         = quantity { unit = RECIPROCAL_MOLE,         value = 6.02214076e23          };
export def HYPERFINE_TRANSITION_CAESIUM_133 = quantity { unit = HERTZ,                   value = 9192631770.0           };
export def LUMINOUS_EFFICACY_540_THZ        = quantity { unit = LUMEN_PER_WATT,          value = 683.0                  };

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


