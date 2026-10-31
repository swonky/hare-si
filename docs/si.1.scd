si(1) ["(C) 2026" ["General Commands Manual"]]

# NAME

si - parse, convert, and format physical quantities using SI units

# SYNOPSIS

*si* [OPTIONS] VALUE++
*si* --completions SHELL++
*si* --version++
*si* --help

# DESCRIPTION

*si* is a command-line utility for parsing, converting, and formatting physical quantities expressed using the International System of Units (SI).

A quantity consists of a numeric value followed by a unit expression. 
Unit expressions support multiplication, division, exponentiation, and grouping using ASCII infix notation.

Quantities can be converted to a specified target unit, with dimensional compatibility checked during conversion.
Output can be formatted in several representations, including UTF-8 encoded symbols, plain text, JSON, and LaTeX.

Numeric output supports configurable decimal precision and notation, including general, fixed-point, scientific, and E-notation.

# OPTIONS

*-n*, *--notation* NOTATION
	Set numeric notation. Supported values are *general*, *fixed*, *scientific*, *e*, and *E*.

*-o*, *--output* FORMAT
	Set output format. Supported values are *pretty*, *plain*, *json*, and *latex*.

*-p*, *--precision* INTEGER
	Set decimal precision (default: 3).

*-u*, *--unit* UNIT
	Convert the quantity to the specified target unit representation.

*-s*, *--strict*
	Enforce strict parsing rules for quantities.

*-c*, *--completions* SHELL
	Generate shell completions for Bash or Zsh.

*-v*, *--version*
	Display version information.

*-h*, *--help*
	Display help information.

# UNIT FORMAT EXPRESSIONS

Unit expressions use ASCII infix notation.
```
*	Multiplication
/	Division
^	Exponentiation
-	Negative exponent
+	Positive exponent
()	Grouping
```

# AUTHORS

Written by Tom Spencer.
