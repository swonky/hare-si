// Dimensions

// The dimensionless dimension, with all SI base dimension exponents equal to
// zero.
export def DIMENSIONLESS = dimension { ... };

// The SI base dimension of mass.
export def MASS = dimension { mass = 1, ... };

// The SI base dimension of length.
export def LENGTH = dimension { length = 1, ... };

// The SI base dimension of time.
export def TIME = dimension { time = 1, ... };

// The SI base dimension of electric current.
export def CURRENT = dimension { current = 1, ... };

// The SI base dimension of thermodynamic temperature.
export def TEMPERATURE = dimension { temperature = 1, ... };

// The SI base dimension of amount of substance.
export def SUBSTANCE = dimension { substance = 1, ... };

// The SI base dimension of luminous intensity.
export def LUMINOSITY = dimension { luminosity = 1, ... };

// The reciprocal of the SI base dimension of mass.
export def RECIPROCAL_MASS = dimension { mass = -1, ... };

// The SI derived dimension of spatial frequency, expressed as the reciprocal
// of length.
export def WAVENUMBER = dimension { length = -1, ... };

// The SI derived dimension of frequency.
// Its SI unit is [[HERTZ]].
export def FREQUENCY = dimension { time = -1, ... };

// The reciprocal of the SI base dimension of electric current.
export def RECIPROCAL_CURRENT = dimension { current = -1, ... };

// The reciprocal of the SI base dimension of thermodynamic temperature.
export def RECIPROCAL_TEMPERATURE = dimension { temperature = -1, ... };

// The reciprocal of the SI base dimension of amount of substance.
export def RECIPROCAL_SUBSTANCE = dimension { substance = -1, ... };

// The reciprocal of the SI base dimension of luminous intensity.
export def RECIPROCAL_LUMINOSITY = dimension { luminosity = -1, ... };

// The SI derived dimension of absorbed dose.
// Its SI unit is [[GRAY]].
export def ABSORBED_DOSE = dimension { length = 2, time = -2, ... };

// The SI derived dimension of radioactive activity.
// Its SI unit is [[BECQUEREL]].
export def ACTIVITY = dimension { time = -1, ... };

// The SI derived dimension of capacitance.
// Its SI unit is [[FARAD]].
export def CAPACITANCE = dimension {
	mass = -1,
	length = -2,
	time = 4,
	current = 2,
	...
};

// The SI derived dimension of catalytic activity.
// Its SI unit is [[KATAL]].
export def CATALYTIC_ACTIVITY = dimension { time = -1, substance = 1, ... };

// The SI derived dimension of electrical conductance.
// Its SI unit is [[SIEMENS]].
export def CONDUCTANCE = dimension {
	mass = -1,
	length = -2,
	time = 3,
	current = 2,
	...
};

// The SI derived dimension of dose equivalent.
// Its SI unit is [[SIEVERT]].
export def DOSE_EQUIVALENT = dimension { length = 2, time = -2, ... };

// The SI derived dimension of electric charge.
// Its SI unit is [[COULOMB]].
export def ELECTRIC_CHARGE = dimension { time = 1, current = 1, ... };

// The SI derived dimension of electric potential.
// Its SI unit is [[VOLT]].
export def ELECTRIC_POTENTIAL = dimension {
	mass = 1,
	length = 2,
	time = -3,
	current = -1,
	...
};

// The SI derived dimension of energy.
// Its SI unit is [[JOULE]].
export def ENERGY = dimension { mass = 1, length = 2, time = -2, ... };

// The SI derived dimension of exposure to ionising radiation.
// Its SI unit is [[COULOMB_PER_KILOGRAM]].
export def EXPOSURE = dimension { mass = -1, time = 1, current = 1, ... };

// The SI derived dimension of force. 
// Its SI unit is [[NEWTON]].
export def FORCE = dimension { mass = 1, length = 1, time = -2, ... };

// The SI derived dimension of illuminance.
// Its SI unit is [[LUX]].
export def ILLUMINANCE = dimension { length = -2, luminosity = 1, ... };

// The SI derived dimension of inductance.
// Its SI unit is [[HENRY]].
export def INDUCTANCE = dimension {
	mass = 1,
	length = 2,
	time = -2,
	current = -2,
	...
};

// The SI derived dimension of luminous flux.
// Its SI unit is [[LUMEN]].
export def LUMINOUS_FLUX = dimension { luminosity = 1, ... };

// The SI derived dimension of magnetic flux.
// Its SI unit is [[WEBER]].
export def MAGNETIC_FLUX = dimension {
	mass = 1,
	length = 2,
	time = -2,
	current = -1,
	...
};

// The SI derived dimension of magnetic flux density.
// Its SI unit is [[TESLA]].
export def MAGNETIC_FLUX_DENSITY = dimension {
	mass = 1,
	time = -2,
	current = -1,
	...
};

// The SI derived dimension of power.
// Its SI unit is [[WATT]].
export def POWER = dimension { mass = 1, length = 2, time = -3, ... };

// The SI derived dimension of pressure.
// Its SI unit is [[PASCAL]].
export def PRESSURE = dimension { mass = 1, length = -1, time = -2, ... };

// The SI derived dimension of electrical resistance.
// Its SI unit is [[OHM]].
export def RESISTANCE = dimension {
	mass = 1,
	length = 2,
	time = -3,
	current = -2,
	...
};

// Derived dimensions with compound units

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

// The SI derived dimension of dynamic viscosity. Its SI unit is [[PASCAL_SECOND]].
export def DYNAMIC_VISCOSITY = dimension {
    mass = 1, length = -1, time = -1, ...
};

// The SI derived dimension of kinematic viscosity. Its SI unit is [[SQUARE_METRE_PER_SECOND]].
export def KINEMATIC_VISCOSITY = dimension {
    length = 2, time = -1, ...
};
