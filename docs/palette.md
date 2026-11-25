# Voltage Palette

The editor background is `#0d1117`.

## General

| | Element | Hex |
|---|---|---|
| ![#00ff41](../img/swatches/00ff41.svg) | Strings | `#00ff41` |
| ![#ff6b9d](../img/swatches/ff6b9d.svg) | Numbers / control flow (`if`, `for`, etc.) / struct & signal member access | `#ff6b9d` |
| ![#4fc1ff](../img/swatches/4fc1ff.svg) | Types (`size_t`, classes) | `#4fc1ff` |
| ![#ffa657](../img/swatches/ffa657.svg) | Declaration keywords (`const`, `int`, `void`) | `#ffa657` |
| ![#00d4ff](../img/swatches/00d4ff.svg) | Function declarations | `#00d4ff` |
| ![#82e2ff](../img/swatches/82e2ff.svg) | Function calls | `#82e2ff` |
| ![#ffdd88](../img/swatches/ffdd88.svg) | Function parameters | `#ffdd88` |
| ![#ffffff](../img/swatches/ffffff.svg) | Local variables | `#ffffff` |
| ![#ffcc00](../img/swatches/ffcc00.svg) | Enums & macros | `#ffcc00` |
| ![#da70d6](../img/swatches/da70d6.svg) | Language constants (`True`, `False`, `None`, `...`) | `#da70d6` |
| ![#ffaa44](../img/swatches/ffaa44.svg) | Markdown code (inline & fenced) | `#ffaa44` |
| ![#7cb668](../img/swatches/7cb668.svg) | Comments | `#7cb668` |
| ![#FF0000](../img/swatches/ff0000.svg) | TODO / FIXME tags | `#FF0000` |
| ![#ff3333](../img/swatches/ff3333.svg) | Cursor | `#ff3333` |

Bracket pair colors cycle through:

| ![#ffd700](../img/swatches/ffd700.svg) gold `#ffd700` | ![#da70d6](../img/swatches/da70d6.svg) orchid `#da70d6` | ![#87ceeb](../img/swatches/87ceeb.svg) sky blue `#87ceeb` | ![#ff6347](../img/swatches/ff6347.svg) tomato `#ff6347` | ![#98fb98](../img/swatches/98fb98.svg) mint `#98fb98` | ![#ffaa44](../img/swatches/ffaa44.svg) light orange `#ffaa44` |
|---|---|---|---|---|---|

In VS Code, the guide lines connecting bracket pairs also need a [setting turned on](../README.md#recommended-settings).

## SystemVerilog

SystemVerilog gets its own token map rather than reusing the general-purpose one above, since the language's declaration/port/instantiation syntax doesn't map cleanly onto it.

| | Element | Hex |
|---|---|---|
| ![#7bafd4](../img/swatches/7bafd4.svg) | Types (`logic`, `bit`, `int`, user-defined types) & module names | `#7bafd4` |
| ![#ffa657](../img/swatches/ffa657.svg) | Port directions (`input`, `output`, `inout`) | `#ffa657` |
| ![#da70d6](../img/swatches/da70d6.svg) | Modifiers (`signed`, `static`, `packed`, ...) & language constants | `#da70d6` |
| ![#ff6b9d](../img/swatches/ff6b9d.svg) | Control flow (`always_ff`, `if`, `else`, `begin`/`end`, `assign`) | `#ff6b9d` |
| ![#ffcc00](../img/swatches/ffcc00.svg) | Operators (`<=`, `&&`, `+`, ...) | `#ffcc00` |
| ![#ffaa44](../img/swatches/ffaa44.svg) | Numeric literals (`1'b0`, `32'hDEADBEEF`) | `#ffaa44` |
| ![#ffffff](../img/swatches/ffffff.svg) | Signals, port signal names, instance names | `#ffffff` |
| ![#daa520](../img/swatches/daa520.svg) | Instantiated port names (`.clk_i(...)`) | `#daa520` |
| ![#cfa3e6](../img/swatches/cfa3e6.svg) | Wired-in signals (`.clk_i(clk)`) | `#cfa3e6` |

Numbers and operators inside bit-select brackets (e.g. `-1:0` in `[WORD_WIDTH-1:0]`) render as plain white rather than their usual colors, so index arithmetic doesn't compete visually with real numeric literals elsewhere in the code.

Module instantiations get a dedicated trio so a `.port(signal)` binding reads as two distinct colors instead of one blur — the port name (dark goldenrod) and the wired-in signal (lavender) are deliberately different from every other token color in the file.

## JSON, YAML & TOML

| | Element | Hex |
|---|---|---|
| ![#00d4ff](../img/swatches/00d4ff.svg) | Keys | `#00d4ff` |
| ![#6fe09f](../img/swatches/6fe09f.svg) | Strings (softer than the main string green, so long values don't overpower keys) | `#6fe09f` |
| ![#ffa657](../img/swatches/ffa657.svg) | TOML table names | `#ffa657` |
| ![#ffffff](../img/swatches/ffffff.svg) | YAML block scalars | `#ffffff` |

## Language-specific notes

- **C/C++**: struct/object member access (e.g. `x` in `threadIdx.x`) is colored separately from the base identifier.
- **Tcl**: commands match function color, variables are white, flags/options are orange, control keywords are pink-red.
- **Python**: `and` / `or` / `not` are gold (`#ffcc00`), matching enums and macros.

## Terminal editors

- **Vim & Neovim** use these hex values directly in a 24-bit color terminal, and the nearest 256-color values otherwise. Plain Vim can't color parameters or declarations separately; Neovim with Treesitter/LSP can.
- **nano** uses the nearest 256-color values (e.g. `#ffa657` and `#ffaa44` both become 215), reduced further to named colors before nano 6.0. It can't distinguish parameters from locals or find function declarations.
