# Voltage

A high-contrast, vibrant dark VS Code theme, plus dotfiles for other tools.

No dimming, no washed-out "filter" look — dark background, rich color variety, and clear semantic distinctions between declarations, types, parameters, struct/signal access, and control flow.

<p align="center">
  <img src="img/voltage-logo.svg" width="220" alt="Voltage logo"/>
</p>

## Structure

```
voltage/
├── vscode/
│   ├── package.json
│   └── themes/
│       └── voltage-color-theme.json
├── bash/
│   └── .bashrc
├── docs/
│   └── palette.md
├── img/
│   ├── voltage-logo.svg
│   ├── preview-c.svg
│   ├── preview-sv.svg
│   └── preview-python.svg
├── LICENSE
└── README.md
```

Each tool gets its own top-level folder. The palette itself is documented once, in `docs/palette.md`, rather than duplicated per app.

## Installation

**VS Code:**

Grab the packaged extension from [Releases](https://github.com/VerdantLeaf/voltage-theme/releases) and install it with:

```
code --install-extension voltage-theme-1.0.0.vsix
```

Or install manually from the file: `Ctrl+Shift+P` → "Extensions: Install from VSIX..." → select the `.vsix`.

Then `Ctrl+Shift+P` → "Preferences: Color Theme" → select **Voltage**.

To build the `.vsix` yourself:

```
cd vscode
npx @vscode/vsce package
```

**Recommended settings:**

VS Code themes can only contribute colors — not editor behavior — so the rainbow bracket-pair guides need one setting turned on by hand in your own `settings.json` (colorization itself, `editor.bracketPairColorization.enabled`, is already `true` by default in modern VS Code):

```json
{
  "editor.guides.bracketPairs": true
}
```

**Bash:**
Grab what you need from `bash/.bashrc` and drop it into `~/.bashrc` — not meant to be copied in wholesale.

## Palette

See [`docs/palette.md`](docs/palette.md) for the full color table.

## Preview

**C** — excerpt from [curl](https://github.com/curl/curl):

<p align="center">
  <img src="img/preview-c.svg" width="700" alt="Voltage theme preview — C"/>
</p>

**SystemVerilog:**

<p align="center">
  <img src="img/preview-sv.svg" width="700" alt="Voltage theme preview — SystemVerilog"/>
</p>

**Python** — excerpt from [omlx](https://github.com/jundot/omlx):

<p align="center">
  <img src="img/preview-python.svg" width="700" alt="Voltage theme preview — Python"/>
</p>

> These previews are hand-colored mockups built from real snippets of the projects linked above, not literal editor screenshots — they guarantee accurate, crisp-at-any-size rendering of the palette (including the gold `and`/`or`/`not`/enum/macro color, which none of our own sample snippets happen to exercise much). Swap in your own screenshots if you want the literal editor chrome.

## Language-specific notes

- **C/C++**: struct/object member access (e.g. `x` in `threadIdx.x`) is colored separately from the base identifier.
- **SystemVerilog**: port declarations (`input`, `output`, `logic`) follow the type/parameter color scheme; struct field access matches the C struct-access color; plain signals default to white.
- **Tcl**: commands match function color, variables are white, flags/options are orange, control keywords are pink-red.
- **Python**: `and` / `or` / `not` in conditionals get their own gold color, matching enums/macros.

## License

MIT — see [LICENSE](LICENSE).

## Notes

This is a living theme — colors get adjusted as new languages or edge cases come up. Check the commit history for the latest tweaks.
