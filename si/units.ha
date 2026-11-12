// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

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


export type unit_kind = enum int {
	NONE,
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
	GAUSS,
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

def EMPTY = "";
def sym_kilogram = "kg";

def sym_none = "";
def sym_angstrom_ascii = "AU";
def sym_angstrom_utf8 = "Å";
def sym_ampere = "A";
def sym_astronomical_unit = "au";
def sym_becquerel = "Bq";
def sym_bel = "B";
def sym_candela = "cd";
def sym_coulomb = "C";
def sym_dalton = "Da";
def sym_day = "d";
def sym_degree_ascii = "deg";
def sym_degree_celsius_ascii = "degC";
def sym_degree_celsius_utf8 = "°C";
def sym_degree_utf8 = "°";
def sym_electronvolt = "eV";
def sym_farad = "F";
def sym_gauss = "G";
def sym_gram = "g";
def sym_gray = "Gy";
def sym_hectare = "ha";
def sym_henry = "H";
def sym_hertz = "Hz";
def sym_hour = "h";
def sym_joule = "J";
def sym_katal = "kat";
def sym_kelvin = "K";
def sym_litre = "L";
def sym_lumen = "lm";
def sym_lux = "lx";
def sym_metre = "m";
def sym_minute = "min";
def sym_mole = "mol";
def sym_neper = "Np";
def sym_newton = "N";
def sym_ohm_ascii = "ohm";
def sym_ohm_utf8 = "Ω";
def sym_pascal = "Pa";
def sym_radian = "rad";
def sym_second = "s";
def sym_siemens = "S";
def sym_sievert = "Sv";
def sym_steradian = "sr";
def sym_tesla = "T";
def sym_tonne = "t";
def sym_volt = "V";
def sym_watt = "W";
def sym_weber = "Wb";

def name_angstrom = "angstrom";
def name_ampere = "ampere";
def name_astronomical_unit = "astronomical unit";
def name_becquerel = "becquerel";
def name_bel = "bel";
def name_candela = "candela";
def name_coulomb = "coulomb";
def name_dalton = "dalton";
def name_day = "day";
def name_degree = "degree";
def name_degree_celsius = "degree Celsius";
def name_electronvolt = "electronvolt";
def name_farad = "farad";
def name_gauss = "gauss";
def name_gram = "gram";
def name_gray = "gray";
def name_hectare = "hectare";
def name_henry = "henry";
def name_hertz = "hertz";
def name_hour = "hour";
def name_joule = "joule";
def name_katal = "katal";
def name_kelvin = "kelvin";
def name_kilogram = "kilogram";
def name_litre = "litre";
def name_lumen = "lumen";
def name_lux = "lux";
def name_metre = "metre";
def name_minute = "minute";
def name_mole = "mole";
def name_neper = "neper";
def name_newton = "newton";
def name_ohm = "ohm";
def name_pascal = "pascal";
def name_radian = "radian";
def name_second = "second";
def name_siemens = "siemens";
def name_sievert = "sievert";
def name_steradian = "steradian";
def name_tesla = "tesla";
def name_tonne = "tonne";
def name_volt = "volt";
def name_watt = "watt";
def name_weber = "weber";

def symbols_base: [_]str = [
	sym_kilogram,
	sym_metre,
	sym_second,
	sym_ampere,
	sym_kelvin,
	sym_mole,
	sym_candela,
];

def symbols_utf8: [_]str = [
	EMPTY,
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
	sym_gauss,
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
	EMPTY,
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
	sym_gauss,
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
	EMPTY,
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
	name_gauss,
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
	DIMENSIONLESS_UNIT,
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
	GAUSS,
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

export type symbol_entry = struct {
	kind: symbol_kind,
	name: str,
	sym_ascii: str,
	sym_utf: str,
	sym_alt: []str,
};

export fn all_symbols() ([]symbol_entry | nomem) = {
	let table: []symbol_entry = [];
	for (let i = 0z; i < len(units); i+=1z) {
		const entry = symbol_entry{
			kind = i: unit_kind,
			name = unit_names[i],
			sym_ascii = symbols_ascii[i],
			sym_utf = symbols_utf8[i],
			sym_alt = symbols_for_kind(i: unit_kind)?,
		};
		append(table, entry)?;
	};
	for (let i = 0z; i < len(prefix_scale); i+=1z) {
		const entry = symbol_entry{
			kind = i: prefix_kind,
			name = prefix_names[i],
			sym_ascii = prefix_symbols_ascii[i],
			sym_utf = prefix_symbols_utf8[i],
			sym_alt = symbols_for_kind(i: prefix_kind)?,
		};
		append(table, entry)?;
	};
	return table;
};

fn symbols_for_kind(kind: (unit_kind | prefix_kind)) ([]str | nomem) = {
	let symbols: []str = [];
	match (kind) {
	case let k: unit_kind =>
		for (let i = 0z; i < len(symbol_lookup); i += 1) {
			if (symbol_lookup[i].kind as unit_kind == k) {
				append(symbols, symbol_lookup[i].repr)?;
			};
		};
	case let k: prefix_kind =>
		for (let i = 0z; i < len(prefix_lookup); i += 1) {
			if (prefix_lookup[i].kind as prefix_kind == k) {
				append(symbols, prefix_lookup[i].repr)?;
			};
		};
	};
	return symbols;
};

export def DIMENSIONLESS_UNIT = unit { dim = DIMENSIONLESS, scale = 1.0 };

// Base units

export def AMPERE = unit { dim = CURRENT, scale = 1.0 };
export def CANDELA = unit { dim = LUMINOSITY, scale = 1.0 };
export def KELVIN = unit { dim = TEMPERATURE, scale = 1.0 };
export def KILOGRAM = unit { dim = MASS, scale = 1.0 };
export def METRE = unit { dim = LENGTH, scale = 1.0 };
export def MOLE = unit { dim = SUBSTANCE, scale = 1.0 };
export def SECOND = unit { dim = TIME, scale = 1.0 };

// Reciprocal base units

export def RECIPROCAL_AMPERE = unit { dim = RECIPROCAL_CURRENT, scale = 1.0 };
export def RECIPROCAL_CANDELA = unit { dim = RECIPROCAL_LUMINOSITY, scale = 1.0 };
export def RECIPROCAL_KELVIN = unit { dim = RECIPROCAL_TEMPERATURE, scale = 1.0 };
export def RECIPROCAL_KILOGRAM = unit { dim = RECIPROCAL_MASS, scale = 1.0 };
export def RECIPROCAL_METRE = unit { dim = WAVENUMBER, scale = 1.0 };
export def RECIPROCAL_MOLE = unit { dim = RECIPROCAL_SUBSTANCE, scale = 1.0 };
export def HERTZ = unit { dim = FREQUENCY, scale = 1.0 };

// Derived units

export def BECQUEREL = unit { dim = ACTIVITY, scale = 1.0 };
export def COULOMB = unit { dim = ELECTRIC_CHARGE, scale = 1.0 };
export def DEGREE_CELSIUS = unit { dim = TEMPERATURE, scale = 1.0 };
export def FARAD = unit { dim = CAPACITANCE, scale = 1.0 };
export def GRAY = unit { dim = ABSORBED_DOSE, scale = 1.0 };
export def HENRY = unit { dim = INDUCTANCE, scale = 1.0 };
export def JOULE = unit { dim = ENERGY, scale = 1.0 };
export def KATAL = unit { dim = CATALYTIC_ACTIVITY, scale = 1.0 };
export def LUMEN = unit { dim = LUMINOUS_FLUX, scale = 1.0 };
export def LUX = unit { dim = ILLUMINANCE, scale = 1.0 };
export def NEWTON = unit { dim = FORCE, scale = 1.0 };
export def OHM = unit { dim = RESISTANCE, scale = 1.0 };
export def PASCAL = unit { dim = PRESSURE, scale = 1.0 };
export def RADIAN = unit { dim = DIMENSIONLESS, scale = 1.0 };
export def SIEMENS = unit { dim = CONDUCTANCE, scale = 1.0 };
export def SIEVERT = unit { dim = DOSE_EQUIVALENT, scale = 1.0 };
export def STERADIAN = unit { dim = DIMENSIONLESS, scale = 1.0 };
export def TESLA = unit { dim = MAGNETIC_FLUX_DENSITY, scale = 1.0 };
export def VOLT = unit { dim = ELECTRIC_POTENTIAL, scale = 1.0 };
export def WATT = unit { dim = POWER, scale = 1.0 };
export def WEBER = unit { dim = MAGNETIC_FLUX, scale = 1.0 };

// Non-SI

// The astronomical unit is a non-SI unit of length that approximately equates
// to the average distance between the Sun and the Earth. As of 2012, it is
// standardised to a fixed length in metres. See [[METRE]].
export def ASTRONOMICAL_UNIT = unit { dim = LENGTH, scale = 1.495978707e11 };

// The bel is a non-SI relative logarithmic unit commonly used in acoustics, 
// telecommunications, and signal processing to express ratios of power quantities.
// This unit is dimensionless and does not support conversion.
// See also: [[NEPER]].
export def BEL = unit { dim = DIMENSIONLESS, scale = 1.0 };

// The dalton
export def DALTON = unit { dim = MASS, scale = 1.66053906892e-27 };

// The degree
export def DEGREE = unit { dim = DIMENSIONLESS, scale = 1.7453292519943295e-2 };

// The electronvolt
export def ELECTRONVOLT = unit { dim = ENERGY, scale = 1.602176634e-19 };

// The litre is a non-SI metric unit of volume in common general use.
// See [[CUBIC_METRE]].
export def LITRE = unit { dim = VOLUME, scale = 1.0e-3 };

// The neper is a non-SI relative logarithmic unit used in acoustics,
// telecommunications, and signal processing to express ratios of field
// quantities.
// This unit is dimensionless and does not support conversion.
// See also: [[BEL]].
export def NEPER = unit { dim = DIMENSIONLESS, scale = 1.0 };

// The tonne is a non-SI metric unit of mass still in common general use.
// Not to be confused with the ton units used in Imperial or Customary systems. 
// See [[KILOGRAM]].
export def TONNE = unit { dim = MASS, scale = 1.0e3 };

// The angstrom is a non-SI unit of length still widely used in the natural
// sciences and technology to express atomic-scale lengths. See [[METRE]].
export def ANGSTROM = unit { dim = LENGTH, scale = 1.0e-10 };

// The standard atmosphere is widely used in chemistry, physics, and
// engineering as a reference pressure. See [[PASCAL]].
export def ATMOSPHERE = unit { dim = PRESSURE, scale = 1.01325e5 };

// The bar is a metric unit of pressure commonly used in meteorology and
// acoustics. Not to be confused with the CGS unit 'Barye'.
export def BAR = unit { dim = PRESSURE, scale = 1.0e5 };

// The barn is commonly used in nuclear and particle physics to express 
// cross-sectional areas of atomic nuclei and subatomic interactions.
export def BARN = unit { dim = AREA, scale = 1.0e-28 };

// The calorie is non-SI unit commonly used in thermodynamics, chemistry, and
// nutritional science to express energy. See [[JOULE]].
export def CALORIE = unit { dim = ENERGY, scale = 4.184e0 };

// The curie is a non-SI unit historically used in nuclear physics to express
// radioactivity. See [[BECQUEREL]].
export def CURIE = unit { dim = ACTIVITY, scale = 3.7e10 };

// The day is a non-SI unit of time. See [[SECOND]].
export def DAY = unit { dim = TIME, scale = 8.64e4 };

// The dyne is a CGS unit used in mechanics and fluid dynamics to express force.
// See [[NEWTON]].
export def DYNE = unit { dim = FORCE, scale = 1.0e-5 };

// The erg is a CGS unit commonly used in classical mechanics, astrophysics, and
// other areas of physics to express energy.
// The SI counterpart unit is the [[JOULE]].
export def ERG = unit { dim = ENERGY, scale = 1.0e-7 };

// The gal is a CGS unit commonly used in geophysics and gravimetry to express
// acceleration.
// The SI counterpart unit is the [[METRE_PER_SECOND_SQUARED]]
export def GAL = unit { dim = ACCELERATION, scale = 1.0e-2 };

// The gauss is a CGS unit commonly used in physics and engineering to express
// magnetic flux density.
// The SI counterpart unit is the [[TESLA]]
export def GAUSS = unit { dim = MAGNETIC_FLUX_DENSITY, scale = 1.0e-4 };

// The hectare is non-SI metric unit commonly used to express areas of land.
// The SI counterpart unit is the [[SQUARE_METRE]]
export def HECTARE = unit { dim = AREA, scale = 10000.0 };

// The hour is non-SI unit of time.
// The SI counterpart unit is the [[SECOND]]
export def HOUR = unit { dim = TIME, scale = 3.6e3 };

// The maxwell is a CGS electromagnetic unit used to express magnetic flux.
// The SI counterpart unit is the [[WEBER]]
export def MAXWELL = unit { dim = MAGNETIC_FLUX, scale = 1.0e-8 };

// The minute is non-SI unit of time.
// The SI counterpart unit is the [[SECOND]]
export def MINUTE = unit { dim = TIME, scale = 6.0e1 };

// Millimetres of mercury are widely used in medicine and meteorology to express
// pressure.
// The SI counterpart unit is the [[PASCAL]]
export def MILLIMETRES_OF_MERCURY = unit { dim = PRESSURE, scale = 1.33322e2 };

// The oersted is a CGS electromagnetic unit used to express magnetic field
// strength.
// The SI counterpart unit is the [[HENRY]].
export def OERSTED = unit {
	dim = MAGNETIC_FIELD_STRENGTH, scale = 7.957747155e1,
};

// The poise is a CGS unit commonly used in rheology and fluid mechanics to
// express dynamic viscosity.
export def POISE = unit { dim = DYNAMIC_VISCOSITY, scale = 1.0e-1 };

// The roentgen is a non-SI unit historically used in radiology and radiation
// protection to express [[EXPOSURE]].
// The SI counterpart unit is the [[COULOMB_PER_KILOGRAM]].
export def ROENTGEN = unit { dim = EXPOSURE, scale = 2.58e-4 };

// The rad is a non-SI unit historically used in radiobiology and radiation
// dosimetry to express absorbed dose.
// The SI counterpart unit is the [[GRAY]].
export def RAD = unit { dim = ABSORBED_DOSE, scale = 1.0e-2 };

// The rem (or Roentgen equivalent man) is a non-SI unit historically used in
// radiation protection to express equivalent dose.
// The SI counterpart unit is the [[SIEVERT]].
export def REM = unit { dim = DOSE_EQUIVALENT, scale = 1.0e-2 };

// The stokes is a CGS unit commonly used in fluid mechanics to express
// viscosity.
// The SI counterpart unit is the [[SQUARE_METRE_PER_SECOND]].
export def STOKES = unit { dim = KINEMATIC_VISCOSITY, scale = 1.0e-4 };

// The torr is non-SI unit historically used in physics.
// The SI counterpart unit is the [[PASCAL]].
export def TORR = unit { dim = PRESSURE, scale = 1.33322368421e2 };


// The gram is a scaled SI unit of mass.
// The corresponding unscaled SI unit is the [[KILOGRAM]].
export def GRAM = unit { dim = MASS, scale = 1.0e-3 };

// The kilometre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def KILOMETRE = unit { dim = LENGTH, scale = 1.0e3 };

// The centimetre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def CENTIMETRE = unit { dim = LENGTH, scale = 1.0e-2 };

// The millimetre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def MILLIMETRE = unit { dim = LENGTH, scale = 1.0e-3 };

// The micrometre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def MICROMETRE = unit { dim = LENGTH, scale = 1.0e-6 };

// The micron is an alternative name for the [[MICROMETRE]].
export def MICRON = MICROMETRE;

// The nanometre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def NANOMETRE = unit { dim = LENGTH, scale = 1.0e-9 };

// The picometre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def PICOMETRE = unit { dim = LENGTH, scale = 1.0e-12 };

// The milliampere is a scaled SI unit of electric current.
// The corresponding unscaled SI unit is the [[AMPERE]].
export def MILLIAMPERE = unit { dim = CURRENT, scale = 1.0e-3 };

// The microampere is a scaled SI unit of electric current.
// The corresponding unscaled SI unit is the [[AMPERE]].
export def MICROAMPERE = unit { dim = CURRENT, scale = 1.0e-6 };

// The millisecond is a scaled SI unit of time.
// The corresponding unscaled SI unit is the [[SECOND]].
export def MILLISECOND = unit { dim = TIME, scale = 1.0e-3 };

// The microsecond is a scaled SI unit of time.
// The corresponding unscaled SI unit is the [[SECOND]].
export def MICROSECOND = unit { dim = TIME, scale = 1.0e-6 };

// The nanosecond is a scaled SI unit of time.
// The corresponding unscaled SI unit is the [[SECOND]].
export def NANOSECOND = unit { dim = TIME, scale = 1.0e-9 };
// Coherent derived units

// The milligram is a scaled SI unit of mass.
// The corresponding unscaled SI unit is the [[KILOGRAM]].
export def MILLIGRAM = unit { dim = MASS, scale = 1.0e-6 };

// The microgram is a scaled SI unit of mass.
// The corresponding unscaled SI unit is the [[KILOGRAM]].
export def MICROGRAM = unit { dim = MASS, scale = 1.0e-9 };

// The decimetre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def DECIMETRE = unit { dim = LENGTH, scale = 1.0e-1 };

// The decametre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def DECAMETRE = unit { dim = LENGTH, scale = 1.0e1 };

// The hectometre is a scaled SI unit of length.
// The corresponding unscaled SI unit is the [[METRE]].
export def HECTOMETRE = unit { dim = LENGTH, scale = 1.0e2 };

// The square kilometre is a scaled SI unit of area.
// The corresponding unscaled SI unit is the [[SQUARE_METRE]].
export def SQUARE_KILOMETRE = unit { dim = AREA, scale = 1.0e6 };

// The square centimetre is a scaled SI unit of area.
// The corresponding unscaled SI unit is the [[SQUARE_METRE]].
export def SQUARE_CENTIMETRE = unit { dim = AREA, scale = 1.0e-4 };

// The square millimetre is a scaled SI unit of area.
// The corresponding unscaled SI unit is the [[SQUARE_METRE]].
export def SQUARE_MILLIMETRE = unit { dim = AREA, scale = 1.0e-6 };

// The cubic centimetre is a scaled SI unit of volume.
// The corresponding unscaled SI unit is the [[CUBIC_METRE]].
export def CUBIC_CENTIMETRE = unit { dim = VOLUME, scale = 1.0e-6 };

// The cubic millimetre is a scaled SI unit of volume.
// The corresponding unscaled SI unit is the [[CUBIC_METRE]].
export def CUBIC_MILLIMETRE = unit { dim = VOLUME, scale = 1.0e-9 };

// The kilopascal is a scaled SI unit of pressure.
// The corresponding unscaled SI unit is the [[PASCAL]].
export def KILOPASCAL = unit { dim = PRESSURE, scale = 1.0e3 };

// The megapascal is a scaled SI unit of pressure.
// The corresponding unscaled SI unit is the [[PASCAL]].
export def MEGAPASCAL = unit { dim = PRESSURE, scale = 1.0e6 };

// The gigapascal is a scaled SI unit of pressure.
// The corresponding unscaled SI unit is the [[PASCAL]].
export def GIGAPASCAL = unit { dim = PRESSURE, scale = 1.0e9 };

// The hectopascal is a scaled SI unit of pressure.
// The corresponding unscaled SI unit is the [[PASCAL]].
export def HECTOPASCAL = unit { dim = PRESSURE, scale = 1.0e2 };

// The millipascal is a scaled SI unit of pressure.
// The corresponding unscaled SI unit is the [[PASCAL]].
export def MILLIPASCAL = unit { dim = PRESSURE, scale = 1.0e-3 };

// The kilonewton is a scaled SI unit of force.
// The corresponding unscaled SI unit is the [[NEWTON]].
export def KILONEWTON = unit { dim = FORCE, scale = 1.0e3 };

// The meganewton is a scaled SI unit of force.
// The corresponding unscaled SI unit is the [[NEWTON]].
export def MEGANEWTON = unit { dim = FORCE, scale = 1.0e6 };

// The millinewton is a scaled SI unit of force.
// The corresponding unscaled SI unit is the [[NEWTON]].
export def MILLINEWTON = unit { dim = FORCE, scale = 1.0e-3 };

// The kilojoule is a scaled SI unit of energy.
// The corresponding unscaled SI unit is the [[JOULE]].
export def KILOJOULE = unit { dim = ENERGY, scale = 1.0e3 };

// The megajoule is a scaled SI unit of energy.
// The corresponding unscaled SI unit is the [[JOULE]].
export def MEGAJOULE = unit { dim = ENERGY, scale = 1.0e6 };

// The gigajoule is a scaled SI unit of energy.
// The corresponding unscaled SI unit is the [[JOULE]].
export def GIGAJOULE = unit { dim = ENERGY, scale = 1.0e9 };

// The millijoule is a scaled SI unit of energy.
// The corresponding unscaled SI unit is the [[JOULE]].
export def MILLIJOULE = unit { dim = ENERGY, scale = 1.0e-3 };

// The milliwatt is a scaled SI unit of power.
// The corresponding unscaled SI unit is the [[WATT]].
export def MILLIWATT = unit { dim = POWER, scale = 1.0e-3 };

// The kilowatt is a scaled SI unit of power.
// The corresponding unscaled SI unit is the [[WATT]].
export def KILOWATT = unit { dim = POWER, scale = 1.0e3 };

// The megawatt is a scaled SI unit of power.
// The corresponding unscaled SI unit is the [[WATT]].
export def MEGAWATT = unit { dim = POWER, scale = 1.0e6 };

// The gigawatt is a scaled SI unit of power.
// The corresponding unscaled SI unit is the [[WATT]].
export def GIGAWATT = unit { dim = POWER, scale = 1.0e9 };

// The kilohertz is a scaled SI unit of frequency.
// The corresponding unscaled SI unit is the [[HERTZ]].
export def KILOHERTZ = unit { dim = FREQUENCY, scale = 1.0e3 };

// The megahertz is a scaled SI unit of frequency.
// The corresponding unscaled SI unit is the [[HERTZ]].
export def MEGAHERTZ = unit { dim = FREQUENCY, scale = 1.0e6 };

// The gigahertz is a scaled SI unit of frequency.
// The corresponding unscaled SI unit is the [[HERTZ]].
export def GIGAHERTZ = unit { dim = FREQUENCY, scale = 1.0e9 };

// The millicoulomb is a scaled SI unit of electric charge.
// The corresponding unscaled SI unit is the [[COULOMB]].
export def MILLICOULOMB = unit { dim = ELECTRIC_CHARGE, scale = 1.0e-3 };

// The microcoulomb is a scaled SI unit of electric charge.
// The corresponding unscaled SI unit is the [[COULOMB]].
export def MICROCOULOMB = unit { dim = ELECTRIC_CHARGE, scale = 1.0e-6 };

// The millivolt is a scaled SI unit of electric potential.
// The corresponding unscaled SI unit is the [[VOLT]].
export def MILLIVOLT = unit { dim = ELECTRIC_POTENTIAL, scale = 1.0e-3 };

// The kilovolt is a scaled SI unit of electric potential.
// The corresponding unscaled SI unit is the [[VOLT]].
export def KILOVOLT = unit { dim = ELECTRIC_POTENTIAL, scale = 1.0e3 };

// The kiloohm is a scaled SI unit of electrical resistance.
// The corresponding unscaled SI unit is the [[OHM]].
export def KILOOHM = unit { dim = RESISTANCE, scale = 1.0e3 };

// The megaohm is a scaled SI unit of electrical resistance.
// The corresponding unscaled SI unit is the [[OHM]].
export def MEGAOHM = unit { dim = RESISTANCE, scale = 1.0e6 };

// The milliohm is a scaled SI unit of electrical resistance.
// The corresponding unscaled SI unit is the [[OHM]].
export def MILLIOHM = unit { dim = RESISTANCE, scale = 1.0e-3 };

// The microfarad is a scaled SI unit of capacitance.
// The corresponding unscaled SI unit is the [[FARAD]].
export def MICROFARAD = unit { dim = CAPACITANCE, scale = 1.0e-6 };

// The nanofarad is a scaled SI unit of capacitance.
// The corresponding unscaled SI unit is the [[FARAD]].
export def NANOFARAD = unit { dim = CAPACITANCE, scale = 1.0e-9 };

// The picofarad is a scaled SI unit of capacitance.
// The corresponding unscaled SI unit is the [[FARAD]].
export def PICOFARAD = unit { dim = CAPACITANCE, scale = 1.0e-12 };

// The millitesla is a scaled SI unit of magnetic flux density.
// The corresponding unscaled SI unit is the [[TESLA]].
export def MILLITESLA = unit { dim = MAGNETIC_FLUX_DENSITY, scale = 1.0e-3 };

// The microtesla is a scaled SI unit of magnetic flux density.
// The corresponding unscaled SI unit is the [[TESLA]].
export def MICROTESLA = unit { dim = MAGNETIC_FLUX_DENSITY, scale = 1.0e-6 };

// The milliweber is a scaled SI unit of magnetic flux.
// The corresponding unscaled SI unit is the [[WEBER]].
export def MILLIWEBER = unit { dim = MAGNETIC_FLUX, scale = 1.0e-3 };

// The millipascal-second is a scaled SI unit of dynamic viscosity.
// The corresponding unscaled SI unit is the [[PASCAL_SECOND]].
export def MILLIPASCAL_SECOND = unit { dim = DYNAMIC_VISCOSITY, scale = 1.0e-3 };

// The square millimetre per second is a scaled SI unit of kinematic viscosity.
// The corresponding unscaled SI unit is the [[SQUARE_METRE_PER_SECOND]].
export def SQUARE_MILLIMETRE_PER_SECOND = unit {
    dim = KINEMATIC_VISCOSITY,
    scale = 1.0e-6,
};

export def AMPERE_PER_METRE = unit { dim = MAGNETIC_FIELD_STRENGTH, scale = 1.0 };
export def AMPERE_PER_SQUARE_METRE = unit { dim = CURRENT_DENSITY, scale = 1.0 };
export def CANDELA_PER_SQUARE_METRE = unit { dim = LUMINANCE, scale = 1.0 };
export def CUBIC_METRE = unit { dim = VOLUME, scale = 1.0 };
export def CUBIC_METRE_PER_KILOGRAM = unit { dim = SPECIFIC_VOLUME, scale = 1.0 };

// The kilogram per cubic metre is the SI unit for [[DENSITY]].
export def KILOGRAM_PER_CUBIC_METRE = unit { dim = DENSITY, scale = 1.0 };
export def KILOGRAM_PER_SQUARE_METRE = unit { dim = SURFACE_DENSITY, scale = 1.0 };
export def LUMEN_PER_WATT = unit { dim = LUMINOUS_EFFICACY, scale = 1.0 };
export def METRE_PER_SECOND = unit { dim = VELOCITY, scale = 1.0 };
export def METRE_PER_SECOND_SQUARED = unit { dim = ACCELERATION, scale = 1.0 };
export def MOLE_PER_CUBIC_METRE = unit { dim = CONCENTRATION, scale = 1.0 };

// The reciprocal metre is the coherent SI unit of [[RECIPROCAL_LENGTH]].
export def SQUARE_METRE = unit { dim = AREA, scale = 1.0 };

// The reciprocal square metre is the coherent SI unit of
// [[SPATIAL_FREQUENCY_2D]].
export def RECIPROCAL_SQUARE_METRE = unit {
	dim = SPATIAL_FREQUENCY_2D,
	scale = 1.0
};

// The reciprocal cubic metre is the coherent SI unit of
// [[SPATIAL_FREQUENCY_3D]].
export def RECIPROCAL_CUBIC_METRE = unit {
	dim = SPATIAL_FREQUENCY_3D,
	scale = 1.0
};

export def COULOMB_PER_METRE = unit {
	dim = LINEAR_CHARGE_DENSITY,
	scale = 1.0
};

export def COULOMB_PER_SQUARE_METRE = unit {
	dim = SURFACE_CHARGE_DENSITY,
	scale = 1.0
};

export def COULOMB_PER_CUBIC_METRE = unit {
	dim = VOLUME_CHARGE_DENSITY,
	scale = 1.0
};

export def COULOMB_PER_KILOGRAM = unit { dim = EXPOSURE, scale = 1.0 };

// The pascal-second is the coherent SI unit of [[DYNAMIC_VISCOSITY]].
export def PASCAL_SECOND = unit { dim = DYNAMIC_VISCOSITY, scale = 1.0 };

// The newton-metre is the coherent SI unit of [[TORQUE]].
export def NEWTON_METRE = unit { dim = TORQUE, scale = 1.0 };

// The newton per metre is the coherent SI unit of [[SURFACE_TENSION]].
export def NEWTON_PER_METRE = unit { dim = SURFACE_TENSION, scale = 1.0 };

// The square metre per second is the coherent SI unit of [[KINEMATIC_VISCOSITY]].
export def SQUARE_METRE_PER_SECOND = unit { dim = KINEMATIC_VISCOSITY, scale = 1.0 };

// The joule per kelvin is the coherent SI unit of [[ENTROPY]].
export def JOULE_PER_KELVIN = unit { dim = ENTROPY, scale = 1.0 };

// The joule-second is the coherent SI unit of [[ACTION]].
export def JOULE_SECOND = unit { dim = ACTION, scale = 1.0 };



def symbol_lookup: [_]symbol = [
	symbol { repr = "A", kind = unit_kind::AMPERE },
	symbol { repr = "B", kind = unit_kind::BEL },
	symbol { repr = "Bq", kind = unit_kind::BECQUEREL },
	symbol { repr = "C", kind = unit_kind::COULOMB },
	symbol { repr = "Da", kind = unit_kind::DALTON },
	symbol { repr = "F", kind = unit_kind::FARAD },
	symbol { repr = "G", kind = unit_kind::GAUSS },
	symbol { repr = "Gy", kind = unit_kind::GRAY },
	symbol { repr = "H", kind = unit_kind::HENRY },
	symbol { repr = "Hz", kind = unit_kind::HERTZ },
	symbol { repr = "J", kind = unit_kind::JOULE },
	symbol { repr = "K", kind = unit_kind::KELVIN },
	symbol { repr = "L", kind = unit_kind::LITRE },
	symbol { repr = "N", kind = unit_kind::NEWTON },
	symbol { repr = "Np", kind = unit_kind::NEPER },
	symbol { repr = "Pa", kind = unit_kind::PASCAL },
	symbol { repr = "S", kind = unit_kind::SIEMENS },
	symbol { repr = "Sv", kind = unit_kind::SIEVERT },
	symbol { repr = "T", kind = unit_kind::TESLA },
	symbol { repr = "V", kind = unit_kind::VOLT },
	symbol { repr = "W", kind = unit_kind::WATT },
	symbol { repr = "Wb", kind = unit_kind::WEBER },
	symbol { repr = "au", kind = unit_kind::ASTRONOMICAL_UNIT },
	symbol { repr = "cd", kind = unit_kind::CANDELA },
	symbol { repr = "d", kind = unit_kind::DAY },
	symbol { repr = "deg", kind = unit_kind::DEGREE },
	symbol { repr = "degC", kind = unit_kind::DEGREE_CELSIUS },
	symbol { repr = "eV", kind = unit_kind::ELECTRONVOLT },
	symbol { repr = "g", kind = unit_kind::GRAM },
	symbol { repr = "h", kind = unit_kind::HOUR },
	symbol { repr = "ha", kind = unit_kind::HECTARE },
	symbol { repr = "kat", kind = unit_kind::KATAL },
	symbol { repr = "l", kind = unit_kind::LITRE },
	symbol { repr = "lm", kind = unit_kind::LUMEN },
	symbol { repr = "lx", kind = unit_kind::LUX },
	symbol { repr = "m", kind = unit_kind::METRE },
	symbol { repr = "min", kind = unit_kind::MINUTE },
	symbol { repr = "mol", kind = unit_kind::MOLE },
	symbol { repr = "ohm", kind = unit_kind::OHM },
	symbol { repr = "rad", kind = unit_kind::RADIAN },
	symbol { repr = "s", kind = unit_kind::SECOND },
	symbol { repr = "sr", kind = unit_kind::STERADIAN },
	symbol { repr = "t", kind = unit_kind::TONNE },
	symbol { repr = "°", kind = unit_kind::DEGREE },
	symbol { repr = "°C", kind = unit_kind::DEGREE_CELSIUS },
	symbol { repr = "Ω", kind = unit_kind::OHM },
	symbol { repr = "Ω", kind = unit_kind::OHM },
];
