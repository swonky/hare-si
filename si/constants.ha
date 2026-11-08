// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

// Constant quantity definitions

// The speed of light in vacuum, an exact defining constant of the SI. 
// Its SI unit is [[METRE_PER_SECOND]].
export def SPEED_OF_LIGHT = quantity { 
	unit = METRE_PER_SECOND, value = 299792458.0,
};

// The Boltzmann constant, an exact defining constant of the SI relating
// thermal energy to thermodynamic temperature.
// Its SI unit is [[JOULE_PER_KELVIN]].
export def BOLTZMANN = quantity {
	unit = JOULE_PER_KELVIN, value = 1.380649e-23
};

// The Planck constant, an exact defining constant of the SI relating the
// energy of a photon to its frequency.
// Its SI unit is [[JOULE_SECOND]].
export def PLANCK = quantity {
	unit = JOULE_SECOND, value = 6.62607015e-34
};

// The elementary charge, an exact defining constant of the SI corresponding
// to the magnitude of the electric charge of a proton.
// Its SI unit is [[COULOMB]].
export def ELEMENTARY_CHARGE = quantity {
	unit = COULOMB, value = 1.602176634e-19
};

// The Avogadro constant, an exact defining constant of the SI representing the
// number of elementary entities in one mole.
// Its SI unit is [[RECIPROCAL_MOLE]].
export def AVOGADRO = quantity {
	unit = RECIPROCAL_MOLE, value = 6.02214076e23
};

// The caesium-133 hyperfine transition frequency, which defines the SI second.
// Its SI unit is [[HERTZ]].
export def HYPERFINE_TRANSITION_CAESIUM_133 = quantity {
	unit = HERTZ, value = 9192631770.0
};

// The luminous efficacy of monochromatic radiation at 540 THz, an exact
// defining constant of the SI for [[LUMINOUS_EFFICACY]].
// Its SI unit is [[LUMEN_PER_WATT]].
export def LUMINOUS_EFFICACY_540_THZ = quantity {
	unit = LUMEN_PER_WATT, value = 683.0
};
