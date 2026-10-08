#!/usr/bin/env bash
# Install (or uninstall) the Voltage colorscheme for Vim and/or Neovim.
#
#   ./install.sh                 install for every editor found (vim, nvim)
#   ./install.sh --vim           Vim only
#   ./install.sh --nvim          Neovim only
#   ./install.sh --uninstall     remove from both
#
# Copies colors/voltage.vim into the editor's colors directory and adds a marked
# block to your vimrc / init file that turns on truecolor and selects the scheme.
# Re-running replaces the block; nothing else in your config is touched.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEME="$SRC/colors/voltage.vim"
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"
TAG_BEGIN="voltage theme >>>"
TAG_END="voltage theme <<<"

DO_VIM=0; DO_NVIM=0; UNINSTALL=0; EXPLICIT=0
for a in "$@"; do
  case "$a" in
    --vim) DO_VIM=1; EXPLICIT=1 ;;
    --nvim) DO_NVIM=1; EXPLICIT=1 ;;
    --uninstall) UNINSTALL=1 ;;
    *) echo "usage: $0 [--vim] [--nvim] [--uninstall]" >&2; exit 2 ;;
  esac
done

# Remove a marked block. $1=file $2=comment leader ('"' for vimscript, '--' for lua)
strip_block() {
  local f="$1" c="$2" tmp
  [[ -f "$f" ]] || return 0
  tmp="$(mktemp)"
  # drops the block and the blank separator line(s) just before it
  awk -v b="$c >>> $TAG_BEGIN" -v e="$c <<< $TAG_END" '
    $0==b { skip=1; held=""; next }
    $0==e { skip=0; next }
    skip  { next }
    /^$/  { held = held "\n"; next }
    { printf "%s%s\n", held, $0; held="" }
    END   { printf "%s", held }
  ' "$f" > "$tmp"
  cat "$tmp" > "$f"
  rm -f "$tmp"
}

# Append the block. $1=file $2=comment leader $3=body
add_block() {
  local f="$1" c="$2" body="$3"
  mkdir -p "$(dirname "$f")"
  strip_block "$f" "$c"
  {
    [[ -s "$f" ]] && echo
    echo "$c >>> $TAG_BEGIN"
    echo "$body"
    echo "$c <<< $TAG_END"
  } >> "$f"
}

VIMSCRIPT='if has("termguicolors") && &term !=# "linux"
  if !has("nvim")
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif
syntax enable
set background=dark
silent! colorscheme voltage'

LUA='vim.opt.termguicolors = true
vim.opt.background = "dark"
pcall(vim.cmd.colorscheme, "voltage")'

vim_rc() {
  if [[ -f "$HOME/.vimrc" ]]; then echo "$HOME/.vimrc"
  elif [[ -f "$HOME/.vim/vimrc" ]]; then echo "$HOME/.vim/vimrc"
  else echo "$HOME/.vimrc"; fi
}

if (( UNINSTALL )); then
  rm -f "$HOME/.vim/colors/voltage.vim" "$CFG/nvim/colors/voltage.vim"
  strip_block "$(vim_rc)" '"'
  strip_block "$CFG/nvim/init.vim" '"'
  strip_block "$CFG/nvim/init.lua" '--'
  echo "Voltage removed from Vim and Neovim."
  exit 0
fi

[[ -f "$SCHEME" ]] || { echo "colors/voltage.vim not found next to install.sh" >&2; exit 1; }

if (( ! EXPLICIT )); then
  command -v vim  >/dev/null 2>&1 || [[ -d "$HOME/.vim" ]]  && DO_VIM=1
  command -v nvim >/dev/null 2>&1 || [[ -d "$CFG/nvim" ]]   && DO_NVIM=1
  if (( ! DO_VIM && ! DO_NVIM )); then
    echo "Neither vim nor nvim found. Re-run with --vim or --nvim to install anyway." >&2
    exit 1
  fi
fi

if (( DO_VIM )); then
  mkdir -p "$HOME/.vim/colors"
  cp "$SCHEME" "$HOME/.vim/colors/voltage.vim"
  RC="$(vim_rc)"
  add_block "$RC" '"' "$VIMSCRIPT"
  echo "Vim:    $HOME/.vim/colors/voltage.vim  (config: $RC)"
fi

if (( DO_NVIM )); then
  mkdir -p "$CFG/nvim/colors"
  cp "$SCHEME" "$CFG/nvim/colors/voltage.vim"
  if [[ -f "$CFG/nvim/init.lua" ]]; then
    add_block "$CFG/nvim/init.lua" '--' "$LUA"; NRC="$CFG/nvim/init.lua"
  else
    add_block "$CFG/nvim/init.vim" '"' "$VIMSCRIPT"; NRC="$CFG/nvim/init.vim"
  fi
  echo "Neovim: $CFG/nvim/colors/voltage.vim  (config: $NRC)"
fi

echo "Voltage installed. It enables truecolor; use a terminal that supports 24-bit color"
echo "and set its background to #0d1117 for the exact look."
