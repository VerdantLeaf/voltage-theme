# Voltage

A high-contrast, vibrant dark theme for VS Code (built on top of **GitHub Dark Default**), plus my personal `.bashrc`.

No dimming, no washed-out "filter" look — dark background, rich color variety, and clear semantic distinctions between declarations, types, parameters, struct/signal access, and control flow.

## What's in this repo

- `settings.json` — the full VS Code color scheme (token colors + workbench colors)
- `.bashrc` — personal shell config

## Installation

1. Install the **GitHub Dark Default** theme in VS Code (this is a set of overrides on top of it, not a standalone theme).
2. Copy the contents of `settings.json` into your VS Code `settings.json` (`Ctrl+Shift+P` → "Preferences: Open User Settings (JSON)").
   - If you already have settings in there, merge the keys rather than overwriting the whole file.
3. Set your color theme to **GitHub Dark Default** if it isn't already.

For `.bashrc`, just grab what you need and drop it into `~/.bashrc` — not meant to be dropped in wholesale.

## Color palette

| Element | Color |
|---|---|
| Strings | Bright green `#00ff41` |
| Numbers / control flow (`if`, `for`, etc.) / struct & signal member access | Pink-red `#ff6b9d` |
| Types (`size_t`, classes, SV `logic`/`input`) | Blue `#4fc1ff` |
| Declaration keywords (`const`, `int`, `void`) | Orange `#ffa657` |
| Function declarations | Cyan `#00d4ff` |
| Function calls | Light cyan `#82e2ff` |
| Function parameters | Light yellow-orange `#ffdd88` |
| Local variables | White `#ffffff` |
| Enums & macros | Golden yellow `#ffcc00` |
| Comments | Green `#7cb668` |
| TODO / FIXME tags | Bold red `#FF0000` |
| Cursor | Red `#ff3333` |

Bracket pair colors cycle through gold, orchid, sky blue, tomato, mint, and light orange.

## Language-specific notes

- **C/C++**: struct/object member access (e.g. `x` in `threadIdx.x`) is colored separately from the base identifier.
- **SystemVerilog**: port declarations (`input`, `output`, `logic`) follow the type/parameter color scheme; struct field access matches the C struct-access color; plain signals default to white.
- **Tcl**: commands match function color, variables are white, flags/options are orange, control keywords are pink-red.

## Notes

This is a living theme — colors get adjusted as new languages or edge cases come up. Check the commit history for the latest tweaks.
