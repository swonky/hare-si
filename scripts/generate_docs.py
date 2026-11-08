#!/usr/bin/env python3
"""Converts haredoc's plain-text export into markdown.

Maybe I wouldn't have to resort to python if there was a single documentation
generation or conversion tool in the world that actually followed the specs they
claim to follow.
"""

from __future__ import annotations

import re
import sys
import textwrap
from typing import Literal

type definition = Literal["Types", "Definitions", "Errors", "Constants", "Functions"]

keywords: dict[str, definition] = {
    "def": "Definitions",
    "const": "Constants",
    "fn": "Functions",
}

REFERENCE_RE = re.compile(r"\[\[([A-Za-z_][A-Za-z0-9_]*)\]\]")
SECTION_RE = re.compile(r"^\s*===\s*(.*?)\s*===\s*$")

DECLARATION_RE = re.compile(
    r"^(?:export\s+)?(def|type|const|fn)\s+([A-Za-z_][A-Za-z0-9_]*)\b"
)

GROUP_ORDER: list[definition] = [
    "Types",
    "Definitions",
    "Errors",
    "Constants",
    "Functions",
]


def comment_start_before(lines: list[str], declaration_line: int) -> int:
    index = declaration_line - 1
    while index >= 0 and not lines[index].strip():
        index -= 1

    last_line = index
    while index >= 0 and lines[index].lstrip().startswith("//"):
        index -= 1

    if last_line >= 0 and lines[last_line].lstrip().startswith("//"):
        return index + 1
    return declaration_line


def render_comment_block(lines: list[str], identifiers: set[str]) -> str:

    rendered: list[str] = []
    i = 0

    lines = [
        line[2:].removeprefix(" ") if line.startswith("//") else ""
        for line in map(str.strip, lines)
    ]

    while i < len(lines):
        if not lines[i].startswith(("\t", "    ")):
            rendered.append(lines[i])
            i += 1
            continue

        block: list[str] = []

        while i < len(lines):
            if lines[i].startswith(("\t", "    ")):
                block.append(lines[i].expandtabs(4))
                i += 1
            elif not lines[i].strip():
                block.append("")
                i += 1
            else:
                break

        rendered.append("```hare")
        rendered.extend(textwrap.dedent("\n".join(block)).splitlines())
        rendered.append("```")

    return REFERENCE_RE.sub(
        lambda m: f"[{m[1]}](#{m[1].lower()})" if m[1] in identifiers else m[0],
        "\n".join(rendered).strip(),
    )


def convert(source: str) -> str:
    lines = source.splitlines()

    raw_declarations: list[tuple[int, str, definition]] = []
    phase = "types"

    for index, line in enumerate(lines):
        found = DECLARATION_RE.match(line)
        if not found:
            continue

        kind, name = found.groups()

        assert isinstance(kind, str)
        assert isinstance(name, str)

        match kind:
            case "def":
                phase = "definitions"
            case "type":
                if phase in ("definitions", "errors"):
                    phase = "errors"
                else:
                    phase = "types"
            case "const":
                phase = "constants"
            case "fn":
                phase = "functions"
            case _:
                raise ValueError(f"bad kind: {kind}")

        if kind == "type":
            group = "Types" if phase == "types" else "Errors"
        else:
            group = keywords[kind]

        raw_declarations.append((index, name, group))

    identifiers = {name for _, name, _ in raw_declarations}

    if not raw_declarations:
        return render_comment_block(lines, identifiers) + "\n"

    first_doc_start = comment_start_before(lines, raw_declarations[0][0])
    preamble = render_comment_block(lines[:first_doc_start], identifiers)

    present_groups: list[definition] = []
    for _, _, group in raw_declarations:
        if group not in present_groups:
            present_groups.append(group)
        group: definition = "Types"

    present_groups.sort(key=GROUP_ORDER.index)

    output: list[str] = [
        "# Documentation",
        "",
        "## Contents",
        "",
        "- [Introduction](#Introduction)",
    ]

    for group in present_groups:
        output.append(f"- [{group}](#{group.lower()})")

    output.extend(["", "## Introduction", ""])

    if preamble:
        output.extend([preamble, ""])

    previous_group = None

    for position, (start, name, group) in enumerate(raw_declarations):
        doc_start = comment_start_before(lines, start)

        if position + 1 < len(raw_declarations):
            next_start = raw_declarations[position + 1][0]
            code_end = comment_start_before(lines, next_start)
        else:
            code_end = len(lines)

        documentation = render_comment_block(lines[doc_start:start], identifiers)
        code = "\n".join(lines[start:code_end]).strip("\n")

        if group != previous_group:
            output.extend([f"## {group}", ""])
            previous_group = group

        output.extend([f"### {name}", ""])

        if documentation:
            output.extend([documentation, ""])

        output.extend(["```hare", code, "```", ""])

    return "\n".join(output).rstrip() + "\n"


if __name__ == "__main__":
    _ = sys.stdout.write(convert(sys.stdin.read()))
