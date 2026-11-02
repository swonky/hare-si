#!/bin/sh
# Generates module documentation and publishes it to both
# GitHub Pages (main: docs/index.html) and
# Codeberg Pages (pages: index.html).
# Requires haredoc.

set -eu

WORKTREE=/tmp/pages

cleanup() {
    if git worktree list --porcelain | grep -Fqx "worktree $WORKTREE"; then
        git worktree remove --force "$WORKTREE" || {
            echo "Warning: failed to remove worktree $WORKTREE" >&2
            return 1
        }
    fi
}

trap cleanup EXIT
trap 'exit 1' HUP INT TERM

mkdir -p docs
haredoc -Fhtml si > docs/haredoc.html

git worktree add "$WORKTREE" pages

cp -a docs/*.html "$WORKTREE/"

git -C "$WORKTREE" add -A
git -C "$WORKTREE" commit -m "Update documentation"
git -C "$WORKTREE" push origin pages
