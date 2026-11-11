// SPDX-License-Identifier: MPL-2.0
// (C) 2026 Tom Spencer <tcs.git@pm.me>

// marshal
//
//
use fmt;
use io;
use memio;

fn json_number(
	out: io::handle, 
	k: str,
	v: (int | f64),
	comma: bool,
) (size | io::error) = {
	return fmt::fprintf(out, "\"{0}\": {1}", k, v);
};

fn json_string(
	out: io::handle,
	k: str,
	s: (int | f64),
	comma: bool,
) (size | io::error) = {
	return fmt::fprintf(out, "\"{0}\": {1}", k, s,  if (comma) "," else "" );
};

fn dimension_to_json(out: io::handle, d: dimension) (size | io::error) = {
	let count = 0z;
	count += fmt::fprint(out, "{")?;
	count += json_number(out, "mass", d.mass, true)?;
	count += json_number(out, "length", d.length, true)?;
	count += json_number(out, "time", d.time, true)?;
	count += json_number(out, "current", d.current, true)?;
	count += json_number(out, "temperature", d.temperature, true)?;
	count += json_number(out, "substance", d.substance, true)?;
	count += json_number(out, "luminosity", d.luminosity, false)?;
	count += fmt::fprint(out, "}")?;
	return count;
};

fn unit_to_json(out: io::handle, u: unit) (size | io::error) = {
	let count = 0z;
	count += fmt::fprint(out, "{")?;
	count += dimension_to_json(out, u.dim)?;
	count += fmt::fprint(out, ",")?;
	count += json_number(out, "scale", u.scale, false)?;
	count += fmt::fprint(out, "}")?;
	return count;
};

fn quantity_to_json(out: io::handle, q: quantity) (size | io::error) = {
	let count = 0z;
	count += fmt::fprint(out, "{")?;
	count += unit_to_json(out, q.unit)?;
	count += fmt::fprint(out, ",")?;
	count += json_number(out, "value", q.value, false)?;
	count += fmt::fprint(out, "}")?;
	return count;
};

// Writes JSON encoded representation of a quantity or unit.
export fn encodejson(h: io::handle, obj: (quantity | unit | dimension)) (size | error) = match (obj) {
	case let q: quantity =>
		yield quantity_to_json(h, q)?;
	case let u: unit =>
		yield unit_to_json(h, u)?;
	case let d: dimension =>
		yield dimension_to_json(h, d)?;
};

// Returns JSON encoded string representation of a quantity or unit.
export fn tojson(obj: (quantity | unit)) (str | error) = {
	let stream = memio::dynamic();
	encodejson(&stream, obj)?;
	let result = memio::string(&stream)?;
	return result;
};

export def JSON_SCHEMA = `
{
	"$schema": "https://json-schema.org/draft/2020-12/schema",
	"$defs": {
	"dimension": {
		"type": "object",
		"properties": {
			"mass": { "type": "integer" },
			"length": { "type": "integer" },
			"time": { "type": "integer" },
			"current": { "type": "integer" },
			"temperature": { "type": "integer" },
			"substance": { "type": "integer" },
			"luminosity": { "type": "integer" }
		},
		"required": [
			"mass",
			"length",
			"time",
			"current",
			"temperature",
			"substance",
			"luminosity"
		],
		"additionalProperties": false
	},
	"unit": {
		"type": "object",
		"properties": {
			"dim": { "$ref": "#/$defs/dimension" },
			"scale": { "type": "number" }
		},
		"required": ["dim", "scale"],
		"additionalProperties": false
	}
	"quantity": {
		"type": "object",
		"properties": {
			"unit": { "$ref": "#/$defs/unit" },
			"value": { "type": "number" }
		},
		"required": ["unit", "value"],
		"additionalProperties": false
	},
}`;
