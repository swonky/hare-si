// marshal
//
//
use fmt;
use io;

fn unit_to_json(out: io::handle, u: unit) (void | io::error) = {
	fmt::fprintf(out,
		"{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}",
		u.dim.mass,
		u.dim.length,
		u.dim.time,
		u.dim.current,
		u.dim.temperature,
		u.dim.substance,
		u.dim.luminosity,
		u.scale,
	)?;
};

fn quantity_to_json(out: io::handle, q: quantity) (void | io::error) = {
	fmt::fprintf(out,
		"{{\"value\":{},\"unit\":{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}}}",
		q.value,
		q.unit.dim.mass,
		q.unit.dim.length,
		q.unit.dim.time,
		q.unit.dim.current,
		q.unit.dim.temperature,
		q.unit.dim.substance,
		q.unit.dim.luminosity,
		q.unit.scale,
	)?;
};

// Marshals quantity and unit values to JSON.
export fn encode_json(out: io::handle, obj: (quantity | unit)) (void | io::error) = {
	match (obj) {
	case let q: quantity =>
		quantity_to_json(out, q)?;
	case let u: unit =>
		unit_to_json(out, u)?;
	};
};
