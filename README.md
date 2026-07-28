# Voltage

A high-contrast, vibrant dark theme for VS Code (built on top of **GitHub Dark Default**), plus my personal `.bashrc`.

No dimming, no washed-out "filter" look — dark background, rich color variety, and clear semantic distinctions between declarations, types, parameters, struct/signal access, and control flow.

<p align="center">
  <img src="img/voltage-logo.svg" width="220" alt="Voltage logo"/>
</p>

## What's in this repo

- `settings.json` — the full VS Code color scheme (token colors + workbench colors)
- `.bashrc` — personal shell config
- `img/` — logo and preview images referenced in this README

## Installation

1. Install the **GitHub Dark Default** theme in VS Code (this is a set of overrides on top of it, not a standalone theme).
2. Copy the contents of `settings.json` into your VS Code `settings.json` (`Ctrl+Shift+P` → "Preferences: Open User Settings (JSON)").
   - If you already have settings in there, merge the keys rather than overwriting the whole file.

For `.bashrc`, just grab what you need and drop it into `~/.bashrc` — not meant to be dropped in wholesale.

## Color palette

| Element                                                                    | Hex       |                                                          |
| -------------------------------------------------------------------------- | --------- | -------------------------------------------------------- |
| Strings                                                                    | `#00ff41` | ![#00ff41](https://placehold.co/15x15/00ff41/00ff41.png) |
| Numbers / control flow (`if`, `for`, etc.) / struct & signal member access | `#ff6b9d` | ![#ff6b9d](https://placehold.co/15x15/ff6b9d/ff6b9d.png) |
| Types (`size_t`, classes, SV `logic`/`input`)                              | `#4fc1ff` | ![#4fc1ff](https://placehold.co/15x15/4fc1ff/4fc1ff.png) |
| Declaration keywords (`const`, `int`, `void`)                              | `#ffa657` | ![#ffa657](https://placehold.co/15x15/ffa657/ffa657.png) |
| Function declarations                                                      | `#00d4ff` | ![#00d4ff](https://placehold.co/15x15/00d4ff/00d4ff.png) |
| Function calls                                                             | `#82e2ff` | ![#82e2ff](https://placehold.co/15x15/82e2ff/82e2ff.png) |
| Function parameters                                                        | `#ffdd88` | ![#ffdd88](https://placehold.co/15x15/ffdd88/ffdd88.png) |
| Local variables                                                            | `#ffffff` | ![#ffffff](https://placehold.co/15x15/ffffff/ffffff.png) |
| Enums & macros                                                             | `#ffcc00` | ![#ffcc00](https://placehold.co/15x15/ffcc00/ffcc00.png) |
| Comments                                                                   | `#7cb668` | ![#7cb668](https://placehold.co/15x15/7cb668/7cb668.png) |
| TODO / FIXME tags                                                          | `#FF0000` | ![#FF0000](https://placehold.co/15x15/FF0000/FF0000.png) |
| Cursor                                                                     | `#ff3333` | ![#ff3333](https://placehold.co/15x15/ff3333/ff3333.png) |

Bracket pair colors cycle through gold, orchid, sky blue, tomato, mint, and light orange.

## Preview

**C / CUDA and SystemVerilog:**

<p align="center">
  <img src="img/preview-c-sv.svg" width="700" alt="Voltage theme preview — C/CUDA and SystemVerilog"/>
</p>

**Tcl:**

<p align="center">
  <img src="img/preview-tcl.svg" width="700" alt="Voltage theme preview — Tcl"/>
</p>

**Python:**

<p align="center">
  <img src="img/preview-python.svg" width="700" alt="Voltage theme preview — Python"/>
</p>

> These previews are hand-built mockups approximating the real editor rendering, not actual screenshots — useful for a quick look, but worth swapping in real screenshots from your own setup if you want pixel-perfect accuracy.

## Language-specific notes

- **C/C++**: struct/object member access (e.g. `x` in `threadIdx.x`) is colored separately from the base identifier.
- **SystemVerilog**: port declarations (`input`, `output`, `logic`) follow the type/parameter color scheme; struct field access matches the C struct-access color; plain signals default to white.
- **Tcl**: commands match function color, variables are white, flags/options are orange, control keywords are pink-red.
- **Python**: `and` / `or` / `not` in conditionals get their own color (see `settings.json` for the current mapping).

## Why keep this in a repo?

VS Code settings usually sync automatically when signed into a personal GitHub account, so this is partly redundant day-to-day. It's here for the cases where that's not true — machines where you're logged into a different account, shared/lab machines, or anywhere you're not signed in at all. `.bashrc` isn't covered by Settings Sync at all, so it's worth keeping here regardless.

## Notes

This is a living theme — colors get adjusted as new languages or edge cases come up. Check the commit history for the latest tweaks.
