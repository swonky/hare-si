// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

use math;

@test fn equal() void = {
	assert(equal(DIMENSIONLESS, DIMENSIONLESS));
	assert(equal(METRE.dim, METRE.dim));
	assert(equal(SECOND.dim, MINUTE.dim));
	assert(!equal(METRE.dim, SECOND.dim));
	assert(!equal(LENGTH, MASS));
	assert(!equal(LENGTH, AREA));
};

@test fn isclose() void = {
	const a = quantity { unit = METRE, value = 1.0 };
	const b = quantity { unit = CENTIMETRE, value = 100.0 };

	assert(isclose(a, b)!);
	assert(isclose(b, a)!);
	assert(isclose(a, a)!);

	const not_close = quantity { unit = METRE, value = 1.1 };
	assert(!(isclose(a, not_close)!));
	assert(isclose(a, not_close, 0.2)!);

	const mismatch = isclose(a, quantity { unit = SECOND, value = 1.0, });
	assert(mismatch is dimension_mismatch);

	const zero = quantity { unit = METRE, value = 0.0 };
	assert(isclose(zero, zero)!);

};

@test fn scale() void = {
	const cm = scale(METRE, prefix_kind::CENTI);
	assert(equal(cm.dim, CENTIMETRE.dim));
	assert(math::isclosef64(cm.scale, CENTIMETRE.scale));

	const kg = scale(GRAM, prefix_kind::KILO);
	assert(equal(kg.dim, KILOGRAM.dim));
	assert(math::isclosef64(kg.scale, KILOGRAM.scale));

	const micro = scale(PASCAL, prefix_kind::MICRO);
	assert(equal(micro.dim, PASCAL.dim));
	assert(math::isclosef64(micro.scale, 1.0e-6));

	const giga = scale(AMPERE, prefix_kind::GIGA);
	assert(equal(giga.dim, AMPERE.dim));
	assert(math::isclosef64(giga.scale, 1.0e9));

	const doubled = scale(METRE, 2.0);
	assert(equal(doubled.dim, METRE.dim));
	assert(math::isclosef64(doubled.scale, 2.0));

	const fractional = scale(CENTIMETRE, 0.5);
	assert(equal(fractional.dim, CENTIMETRE.dim));
	assert(math::isclosef64(fractional.scale, 0.005));

	const zero = scale(METRE, 0.0);
	assert(equal(zero.dim, METRE.dim));
	assert(math::isclosef64(zero.scale, 0.0));

	const negative = scale(METRE, -2.0);
	assert(equal(negative.dim, METRE.dim));
	assert(math::isclosef64(negative.scale, -2.0));
};

@test fn mulu() void = {
	const result = mulu(NEWTON, METRE);
	assert(equal(result.dim, TORQUE));
	assert(!equal(result.dim, SURFACE_TENSION));
	assert(math::isclosef64(result.scale, 1.0));

	const squared = mulu(METRE, METRE);
	assert(equal(squared.dim, AREA));
	assert(math::isclosef64(squared.scale, 1.0));

	const mAh = mulu(MILLIAMPERE, HOUR);
	assert(equal(mAh.dim, ELECTRIC_CHARGE));
	assert(math::isclosef64(mAh.scale, 3.6));
};

@test fn divu() void = {
	const result = divu(METRE, SECOND);
	assert(equal(result.dim, METRE_PER_SECOND.dim));
	assert(math::isclosef64(result.scale, 1.0));

	const dimensionless = divu(METRE, METRE);
	assert(equal(dimensionless.dim, DIMENSIONLESS));
	assert(math::isclosef64(dimensionless.scale, 1.0));

	const scaled = divu(CENTIMETRE, MILLISECOND);
	assert(equal(scaled.dim, METRE_PER_SECOND.dim));
	assert(math::isclosef64(scaled.scale, 10.0));
};

@test fn add() void = {
	const a = quantity { unit = METRE, value = 3.0 };
	const b = quantity { unit = CENTIMETRE, value = 200.0 };

	const same = add(a, a) as quantity;
	assert(isclose(same, quantity { unit = METRE, value = 6.0 })!);

	const converted = add(a, b) as quantity;
	assert(isclose(converted, quantity { unit = METRE, value = 5.0 })!);

	const scalar = add(a, 2.0) as quantity;
	assert(isclose(scalar, quantity { unit = METRE, value = 5.0 })!);

	const mismatch = add(a, quantity {
		unit = SECOND,
		value = 2.0,
	});
	assert(mismatch is dimension_mismatch);
};

@test fn sub() void = {
	const a = quantity { unit = METRE, value = 3.0 };
	const b = quantity { unit = CENTIMETRE, value = 200.0 };

	const same = sub(a, a) as quantity;
	assert(isclose(same, quantity { unit = METRE, value = 0.0 })!);

	const converted = sub(a, b) as quantity;
	assert(isclose(converted, quantity { unit = METRE, value = 1.0 })!);

	const scalar = sub(a, 2.0) as quantity;
	assert(isclose(scalar, quantity { unit = METRE, value = 1.0 })!);

	const mismatch = sub(a, quantity {
		unit = SECOND,
		value = 2.0,
	});
	assert(mismatch is dimension_mismatch);
};

@test fn mulq() void = {
	const a = quantity { unit = METRE, value = 3.0 };
	const b = quantity { unit = METRE, value = 2.0 };

	const product = mulq(a, b);
	assert(isclose(product, quantity { unit = SQUARE_METRE, value = 6.0 })!);

	const scalar = mulq(a, 2.0);
	assert(isclose(scalar, quantity { unit = METRE, value = 6.0 })!);

	const zero = mulq(a, 0.0);
	assert(isclose(zero, quantity { unit = METRE, value = 0.0 })!);

	const squared = mulq(a, a);
	assert(isclose(squared, quantity { unit = SQUARE_METRE, value = 9.0 })!);
};

@test fn divq() void = {
	const a = quantity { unit = METRE, value = 6.0 };
	const b = quantity { unit = SECOND, value = 2.0 };

	const quotient = divq(a, b);
	assert(isclose(quotient, quantity {
		unit = METRE_PER_SECOND,
		value = 3.0,
	})!);

	const scalar = divq(a, 2.0);
	assert(isclose(scalar, quantity {
		unit = METRE,
		value = 3.0,
	})!);

	const inf = divq(a, 0.0);
	assert(math::isinf(inf.value));
	assert(!math::isnan(inf.value));

	const nan = divq(
		quantity { unit = METRE, value = 0.0 },
		0.0,
	);
	assert(math::isnan(nan.value));

	const inf_qty = divq(a, quantity {
		unit = SECOND,
		value = 0.0,
	});
	assert(math::isinf(inf_qty.value));
	assert(equal(inf_qty.unit.dim, METRE_PER_SECOND.dim));
};

@test fn powd() void = {
	assert(equal(powd(LENGTH, 2), AREA));
	// assert(equal(powd(LENGTH, 0), DIMENSIONLESS));
	assert(equal(powd(LENGTH, 1), LENGTH));
	assert(equal(powd(TIME, -1), FREQUENCY));
	assert(equal(powd(DIMENSIONLESS, 5), DIMENSIONLESS));
	assert(equal(powd(DIMENSIONLESS, -5), DIMENSIONLESS));
	assert(equal(powd(FREQUENCY, -1), SECOND.dim));
};

@test fn powu() void = {
	const squared = powu(METRE, 2);
	assert(equal(squared.dim, SQUARE_METRE.dim));
	assert(math::isclosef64(squared.scale, SQUARE_METRE.scale));

	const pow0 = powu(METRE, 0);
	assert(equal(pow0.dim, DIMENSIONLESS));
	assert(math::isclosef64(pow0.scale, 1.0));

	const reciprocal = powu(METRE, -1);
	assert(equal(reciprocal.dim, WAVENUMBER));
	assert(math::isclosef64(reciprocal.scale, 1.0));

	const pow1 = powu(METRE, 1);
	assert(equal(pow1.dim, METRE.dim));
	assert(math::isclosef64(pow1.scale, METRE.scale));

	const cm2 = powu(CENTIMETRE, 2);
	assert(equal(cm2.dim, SQUARE_METRE.dim));
	assert(math::isclosef64(cm2.scale, 0.0001));

	const cm_neg1 = powu(CENTIMETRE, -1);
	assert(equal(cm_neg1.dim, WAVENUMBER));
	assert(math::isclosef64(cm_neg1.scale, 100.0));

	const scalar = powu(DIMENSIONLESS_UNIT, 3);
	assert(equal(scalar.dim, DIMENSIONLESS));
	assert(math::isclosef64(scalar.scale, 1.0));
};

@test fn isinf() void = {
	const finite = quantity { unit = METRE, value = 3.0 };
	const inf_value = quantity { unit = METRE, value = math::INF };
	const inf_scale = quantity {
		unit = DIMENSIONLESS_UNIT,
		value = math::INF,
	};
	const neg_inf_value = quantity { unit = METRE, value = -math::INF };
	const neg_inf_scale = quantity {
		unit = DIMENSIONLESS_UNIT,
		value = -math::INF,
	};

	assert(!isinf(finite));
	assert(isinf(inf_value));
	assert(isinf(inf_scale));
	assert(isinf(neg_inf_value));
	assert(isinf(neg_inf_scale));
};

@test fn isnan() void = {
	const finite = quantity { unit = METRE, value = 3.0 };
	const nan_value = quantity { unit = METRE, value = math::NAN };
	const nan_scale = quantity { 
		unit = unit { dim = DIMENSIONLESS, scale = math::NAN },
		value = 1.0,
	};
	const neg_nan = quantity { unit = METRE, value = -math::NAN };

	assert(!isnan(finite));
	assert(isnan(nan_value));
	assert(isnan(nan_scale));
	assert(isnan(neg_nan));
};

@test fn powq() void = {
	const input = quantity {
		unit = METRE,
		value = 3.0,
	};

	const pow2 = powq(input, 2);
	assert(isclose(pow2, quantity { unit = SQUARE_METRE, value = 9.0, })!);

	const pow0 = powq(input, 0);
	assert(isclose(pow0, quantity { unit = DIMENSIONLESS_UNIT, value = 1.0, })!);

	const pow_neg1 = powq(input, -1);
	assert(isclose(
		pow_neg1, quantity { unit = RECIPROCAL_METRE, value = 1.0 / 3.0, })!);

	const pow1 = powq(input, 1);
	assert(isclose(pow1, quantity { unit = METRE, value = 3.0, })!);

	const scalar = powq( quantity { unit = DIMENSIONLESS_UNIT, value = 2.0 }, 3,);
	assert(isclose(scalar, quantity { unit = DIMENSIONLESS_UNIT, value = 8.0, })!);
};
