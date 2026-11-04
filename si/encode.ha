// marshal
//
//
use fmt;
use io;
use memio;

fn unit_to_json(out: io::handle, u: unit) (size | io::error) = fmt::fprintf(out,
	"{{\"dim\":{{\"kg\":{},\"m\":{},\"s\":{},\"A\":{},\"K\":{},\"mol\":{},\"cd\":{}}},\"scale\":{}}}",
	u.dim.mass,
	u.dim.length,
	u.dim.time,
	u.dim.current,
	u.dim.temperature,
	u.dim.substance,
	u.dim.luminosity,
	u.scale,
);

fn quantity_to_json(out: io::handle, q: quantity) (size | io::error) = fmt::fprintf(out,
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
);

// Writes JSON encoded representation of a quantity or unit.
export fn encodejson(h: io::handle, obj: (quantity | unit)) (size | error) = match (obj) {
	case let q: quantity =>
		yield quantity_to_json(h, q)?;
	case let u: unit =>
		yield unit_to_json(h, u)?;
};

// Returns JSON encoded string representation of a quantity or unit.
export fn tojson(obj: (quantity | unit)) (str | error) = {
	let stream = memio::dynamic();
	encodejson(&stream, obj)?;
	let result = memio::string(&stream)?;
	return result;
};
