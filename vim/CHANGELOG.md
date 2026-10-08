# Changelog

## 1.0.0

- Initial Vim and Neovim release: one `voltage` colorscheme for both, using the exact Voltage hex palette (with a derived 256-color fallback).
- Language-specific coloring for C/C++/CUDA, Python, SystemVerilog, Tcl, shell, JSON, YAML, TOML and Markdown; function-call and member-access coloring for C-family, Python and SystemVerilog.
- Neovim: Treesitter and LSP semantic-token groups, so declarations, calls, parameters and members get their own colors.
- `install.sh` installs for Vim and/or Neovim and adds the setup to your vimrc / init file automatically (`--uninstall` removes it).
