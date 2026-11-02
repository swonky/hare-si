#!/bin/sh
# Generates module documentation and publishes it to both
# GitHub Pages (main: docs/index.html) and
# Codeberg Pages (pages: index.html).
# Requires haredoc.

set -eu

mkdir -p docs
haredoc -Fhtml si > docs/haredoc.html

git worktree add /tmp/pages pages

cp -a docs/*.html /tmp/pages/

git -C /tmp/pages add -A
git -C /tmp/pages commit -m "Update documentation"
git -C /tmp/pages push origin pages

git worktree remove /tmp/pages
