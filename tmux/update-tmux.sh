#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/VerdantLeaf/voltage-theme/main/tmux/.tmux.conf"
DEST="$HOME/.tmux.verdantleaf.conf"
HOOK='source-file -q ~/.tmux.verdantleaf.conf'

# tmux reads ~/.tmux.conf; use the XDG config only if that's the one you have.
RC="$HOME/.tmux.conf"
XDG_RC="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
if [ ! -f "$RC" ] && [ -f "$XDG_RC" ]; then RC="$XDG_RC"; fi

TMP=$(mktemp)
trap 'rm -f "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP"
[ -s "$TMP" ] || { echo "Download was empty, keeping existing $DEST" >&2; exit 1; }

mv "$TMP" "$DEST"
grep -qF '.tmux.verdantleaf.conf' "$RC" 2>/dev/null || printf '\n%s\n' "$HOOK" >> "$RC"

echo "Updated $DEST. In a running tmux, run: tmux source-file $DEST"
