# Voltage

A high-contrast, vibrant dark theme with clear semantic distinctions between declarations, types, parameters, struct/signal access, and control flow.

<p align="center">
  <img src="media/logo.png" width="180" alt="Voltage logo"/>
</p>

No dimming, no washed-out "filter" look — dark background, rich color variety, and syntax highlighting tuned for C/CUDA, SystemVerilog, Tcl, and Python.

## Preview

<p align="center">
  <img src="media/preview-sv.png" width="600" alt="Voltage theme preview — SystemVerilog"/>
</p>

## Install

`Ctrl+Shift+P` → "Preferences: Color Theme" → **Voltage**

For rainbow bracket-pair guides, also add this to your own `settings.json` — themes can set bracket *colors* but not this editor behavior toggle:

```json
{
  "editor.guides.bracketPairs": true
}
```

Voltage doesn't bundle file icons, but if you have [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme) installed, these are the folder/file tint colors used alongside Voltage:

```json
{
  "workbench.iconTheme": "material-icon-theme",
  "material-icon-theme.folders.color": "#F56600",
  "material-icon-theme.files.color": "#522DB0"
}
```

## Palette & full documentation

See the [project repository](https://github.com/VerdantLeaf/voltage-theme) for the full color palette, language-specific notes, and the bash dotfiles this repo also ships.

## License

MIT
