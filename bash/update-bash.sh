#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/VerdantLeaf/voltage-theme/main/bash/.bashrc"
DEST="$HOME/.bashrc.verdantleaf"
HOOK='[ -f ~/.bashrc.verdantleaf ] && . ~/.bashrc.verdantleaf'

TMP=$(mktemp)
trap 'rm -f "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP"
[ -s "$TMP" ] || { echo "Download was empty, keeping existing $DEST" >&2; exit 1; }

mv "$TMP" "$DEST"
grep -qF '.bashrc.verdantleaf' "$HOME/.bashrc" 2>/dev/null || printf '\n%s\n' "$HOOK" >> "$HOME/.bashrc"

echo "Updated $DEST. Run: source ~/.bashrc"
