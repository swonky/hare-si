use fmt;
use si;
use strconv;
use time;


export fn bench(
	name: str,
	f: *fn() void,
	iterations: uint,
) void = {
	assert(iterations > 0);

	const start = time::now(time::clock::MONOTONIC);
	for (let i = 0u; i < iterations; i += 1) {
		f();
	};
	const elapsed = time::diff(start, time::now(time::clock::MONOTONIC));

	const avg = elapsed / iterations: i64;
	const throughput = iterations: f64 * 1.0e9 / elapsed: f64;

	fmt::printf("{}:\n", name)!;
	fmt::printf("\tIterations: {}\n", iterations)!;
	fmt::printf("\tTotal:      {} ms\n", elapsed / time::MILLISECOND)!;
	fmt::printf("\tAverage:    {} ns/op\n", avg)!;
	fmt::printf("\tThroughput: {:.2} ops/s\n", throughput)!;
};

fn strf() void = {
	const s = si::strf(si::SPEED_OF_LIGHT, "m/s", 3, si::notation::FIXED, si::encoding::ASCII)!;
	defer free(s);
	assert(s == "299792458.000 m/s");
};

fn f64_strf() void = {
	const s = strconv::ftosf(299792458.0)!;
	assert(s == "299792458");
};

export fn main() void = {
	bench("dynamic", &strf, 10000);
	bench("f64", &f64_strf, 10000);
};
