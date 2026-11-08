// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

use math;

fn assert_close(a: f64, b: f64) void = assert(math::isclosef64(a, b));

@test fn test_scale10() void = {
	assert_close(scale10(1.0, 0), 1.0);
	assert_close(scale10(1.0, 1), 10.0);
	assert_close(scale10(1.0, 2), 100.0);
	assert_close(scale10(1.0, 3), 1000.0);

	assert_close(scale10(1.0, -1), 0.1);
	assert_close(scale10(1.0, -2), 0.01);
	assert_close(scale10(1.0, -3), 0.001);

	assert_close(scale10(2.5, 2), 250.0);
	assert_close(scale10(2.5, -2), 0.025);

	assert_close(scale10(-1.0, 2), -100.0);
	assert_close(scale10(-1.0, -2), -0.01);

	assert_close(scale10(0.0, 10), 0.0);
	assert_close(scale10(0.0, -10), 0.0);

	assert_close(scale10(1.0, 10), 1.0e10);
};
