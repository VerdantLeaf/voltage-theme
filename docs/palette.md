# Voltage Palette

| | Element | Hex |
|---|---|---|
| ![#00ff41](../img/swatches/00ff41.svg) | Strings | `#00ff41` |
| ![#ff6b9d](../img/swatches/ff6b9d.svg) | Numbers / control flow (`if`, `for`, etc.) / struct & signal member access | `#ff6b9d` |
| ![#4fc1ff](../img/swatches/4fc1ff.svg) | Types (`size_t`, classes, SV `logic`/`input`) | `#4fc1ff` |
| ![#ffa657](../img/swatches/ffa657.svg) | Declaration keywords (`const`, `int`, `void`) | `#ffa657` |
| ![#00d4ff](../img/swatches/00d4ff.svg) | Function declarations | `#00d4ff` |
| ![#82e2ff](../img/swatches/82e2ff.svg) | Function calls | `#82e2ff` |
| ![#ffdd88](../img/swatches/ffdd88.svg) | Function parameters | `#ffdd88` |
| ![#ffffff](../img/swatches/ffffff.svg) | Local variables | `#ffffff` |
| ![#ffcc00](../img/swatches/ffcc00.svg) | Enums & macros | `#ffcc00` |
| ![#7cb668](../img/swatches/7cb668.svg) | Comments | `#7cb668` |
| ![#FF0000](../img/swatches/ff0000.svg) | TODO / FIXME tags | `#FF0000` |
| ![#ff3333](../img/swatches/ff3333.svg) | Cursor | `#ff3333` |

Bracket pair colors cycle through:

| ![#ffd700](../img/swatches/ffd700.svg) gold `#ffd700` | ![#da70d6](../img/swatches/da70d6.svg) orchid `#da70d6` | ![#87ceeb](../img/swatches/87ceeb.svg) sky blue `#87ceeb` | ![#ff6347](../img/swatches/ff6347.svg) tomato `#ff6347` | ![#98fb98](../img/swatches/98fb98.svg) mint `#98fb98` | ![#ffaa44](../img/swatches/ffaa44.svg) light orange `#ffaa44` |
|---|---|---|---|---|---|

These colors are wired up via `editorBracketHighlight.foreground1-6` in the theme itself, but the vertical guide lines connecting bracket pairs are an editor setting, not a theme color, so they need `"editor.guides.bracketPairs": true` set by hand (see the main [README](../README.md#recommended-settings)).

## Language-specific notes

- **C/C++**: struct/object member access (e.g. `x` in `threadIdx.x`) is colored separately from the base identifier.
- **SystemVerilog**: port declarations (`input`, `output`, `logic`) follow the type/parameter color scheme; struct field access matches the C struct-access color; plain signals default to white.
- **Tcl**: commands match function color, variables are white, flags/options are orange, control keywords are pink-red.
- **Python**: `and` / `or` / `not` in conditionals get their own gold color (`#ffcc00`), matching enums/macros.
