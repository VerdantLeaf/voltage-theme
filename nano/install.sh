#!/usr/bin/env bash
# Install (or uninstall) the Voltage theme for nano.
#
#   ./install.sh              install / update
#   ./install.sh --uninstall  remove
#
# Files are copied to ${XDG_CONFIG_HOME:-~/.config}/nano/voltage and a marked
# block of `include` lines is added to your nanorc. Re-running is safe: the
# block is replaced, never duplicated. Nothing else in your nanorc is touched.
set -euo pipefail

BEGIN="# >>> voltage theme >>>"
END="# <<< voltage theme <<<"

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/nano/voltage"

# nano reads ~/.nanorc if present, otherwise $XDG_CONFIG_HOME/nano/nanorc.
if [[ -f "$HOME/.nanorc" ]]; then
  RC="$HOME/.nanorc"
elif [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/nano/nanorc" ]]; then
  RC="${XDG_CONFIG_HOME:-$HOME/.config}/nano/nanorc"
else
  RC="$HOME/.nanorc"
fi

strip_block() {
  [[ -f "$RC" ]] || return 0
  local tmp
  tmp="$(mktemp)"
  # drops the block and the blank separator line(s) just before it
  awk -v b="$BEGIN" -v e="$END" '
    $0==b { skip=1; held=""; next }
    $0==e { skip=0; next }
    skip  { next }
    /^$/  { held = held "\n"; next }
    { printf "%s%s\n", held, $0; held="" }
    END   { printf "%s", held }
  ' "$RC" > "$tmp"
  cat "$tmp" > "$RC"   # keep the original file's permissions/symlink
  rm -f "$tmp"
}

if [[ "${1:-}" == "--uninstall" ]]; then
  strip_block
  rm -rf "$DEST"
  echo "Voltage removed from nano ($RC cleaned, $DEST deleted)."
  exit 0
elif [[ $# -gt 0 ]]; then
  echo "usage: $0 [--uninstall]" >&2
  exit 2
fi

[[ -f "$SRC/voltage.nanorc" && -d "$SRC/syntax" ]] || { echo "voltage.nanorc/syntax not found next to install.sh" >&2; exit 1; }

# nano >= 6.0 understands xterm-256 color indices, which is how the theme files
# are written. Older nano (e.g. 5.6 on RHEL 9) only knows named colors, so the
# indices are rewritten to the nearest name while copying.
# Override with VOLTAGE_NANO_COLORS=index|named.
MODE="${VOLTAGE_NANO_COLORS:-}"
if [[ -z "$MODE" ]]; then
  MAJOR="$(nano --version 2>/dev/null | sed -n '1s/.*version \([0-9]\+\)\..*/\1/p')"
  if [[ -n "$MAJOR" && "$MAJOR" -lt 6 ]]; then MODE=named; else MODE=index; fi
fi

# index -> nearest named color (nano 5.x palette)
NAMES='45=lagoon 47=mint 232=black 233=black 24=lagoon 75=lightblue 243=lightblack 79=cyan 110=lightblue 107=green 117=lightcyan 251=white 182=mauve 170=purple 178=yellow 196=lightred 205=pink 215=peach 220=lightyellow 222=peach 231=lightwhite'

convert() {
  if [[ "$MODE" == named ]]; then
    awk -v map="$NAMES" '
      BEGIN { n = split(map, kv, " "); for (i = 1; i <= n; i++) { split(kv[i], p, "="); m[p[1]] = p[2] } }
      # color/icolor <spec> "regex"   |   set <x>color <spec>
      /^i?color[ \t]/ || /^set [a-z]+color[ \t]/ {
        f = ($1 == "set") ? 3 : 2
        k = split($f, parts, ",")
        for (i = 1; i <= k; i++) if (parts[i] in m) parts[i] = m[parts[i]]
        spec = parts[1]; for (i = 2; i <= k; i++) spec = spec "," parts[i]
        # rebuild the line, keeping everything after the spec untouched
        pre = $0; sub(/^[ \t]*/, "", pre)
        out = ""; rest = $0
        for (i = 1; i < f; i++) { match(rest, /^[ \t]*[^ \t]+/); out = out substr(rest, 1, RLENGTH); rest = substr(rest, RLENGTH + 1) }
        match(rest, /^[ \t]*[^ \t]+/); out = out " " spec; rest = substr(rest, RLENGTH + 1)
        print out rest; next
      }
      { print }
    ' "$1" > "$2"
  else
    cp "$1" "$2"
  fi
}

rm -rf "$DEST"
mkdir -p "$DEST/syntax"
UI="$(mktemp)"
convert "$SRC/voltage.nanorc" "$UI"
for f in "$SRC"/syntax/*.nanorc; do convert "$f" "$DEST/syntax/$(basename "$f")"; done

strip_block
{
  # blank separator only if the file already has content
  [[ -s "$RC" ]] && echo
  echo "$BEGIN"
  # `set` is not allowed in included files, so the interface colors go inline
  grep -E '^set ' "$UI"
  echo "include \"$DEST/syntax/*.nanorc\""
  echo "$END"
} >> "$RC"
rm -f "$UI"

echo "Voltage installed for nano."
echo "  files:  $DEST"
echo "  config: $RC"
echo "  colors: $MODE (nano ${MAJOR:-?})"
echo "Tip: use a 256-color terminal (TERM=xterm-256color) with background #0d1117."
