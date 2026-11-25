# Contributing

Bug fixes, new language token rules and palette tweaks are all welcome: open a PR against `main`.
This is the theme I use every day and it needs to look good to me, so I can't promise that a change
will be accepted, or that it will stay forever.

## Repository layout

| Path | Contents |
|---|---|
| `vscode/` | VS Code extension |
| `vim/` | Vim and Neovim colorscheme and installer |
| `nano/` | nano theme and installer |
| `bash/` | Personal `.bashrc` and update scripts |
| `docs/palette.md` | The palette, documented in one place |
| `img/` | Logo, previews and color swatches |

## Making changes

If you add or change a color, update [`docs/palette.md`](docs/palette.md) too, including a swatch
in `img/swatches/` for any new hex value.

### VS Code

The theme is [`vscode/themes/voltage-color-theme.json`](vscode/themes/voltage-color-theme.json).

To test your build:

```bash
cd vscode
npx @vscode/vsce package
code --install-extension voltage-theme-<version>.vsix
```

### Vim and Neovim

Everything is in `vim/colors/voltage.vim`.

- Write colors once, as hex, in the palette block at the top. The 256-color fallback is computed
  from them, so never hard-code a cterm value.
- Add new language groups next to the existing per-language blocks, and their Treesitter/LSP
  equivalents in the `has('nvim')` section so Neovim and Vim stay in step.

To test, run `./vim/install.sh` (`--uninstall` to remove).

### nano

Interface colors are in `nano/voltage.nanorc`; languages are in `nano/syntax/*.nanorc`.

- nano older than 6.0 can't take hex colors, so use xterm-256 indices, picking the one nearest the
  palette hex.
- If you introduce a new index, add it to the `NAMES` table in `nano/install.sh`, which maps indices
  to color names for older nano.
- A backslash is literal inside a POSIX bracket expression: write `[][(){}]`, not `[\[\](){}]`.

To test, run `./nano/install.sh` (`--uninstall` to remove).

## Releasing (maintainers)

VS Code, Vim/Neovim and nano are released independently. To release one, bump its version, add a
matching `## X.Y.Z` section to its changelog, and merge to `main`.

| Stream | Version | Changelog | Workflow | Tag and asset |
|---|---|---|---|---|
| VS Code | `version` in `vscode/package.json` | `vscode/CHANGELOG.md` | [`release.yml`](.github/workflows/release.yml) | `vX.Y.Z`, `.vsix` |
| Vim/Neovim | `vim/VERSION` | `vim/CHANGELOG.md` | [`release-vim.yml`](.github/workflows/release-vim.yml) | `vim-vX.Y.Z`, `.tar.gz` |
| nano | `nano/VERSION` | `nano/CHANGELOG.md` | [`release-nano.yml`](.github/workflows/release-nano.yml) | `nano-vX.Y.Z`, `.tar.gz` |

- The changelog section becomes the GitHub Release notes, so write it for users.
- Without a version bump nothing is released. This lets changes be batched, and a workflow does
  nothing if its version has already been released.
- Only VS Code releases are marked "latest".
- Use patch for visual tweaks and small additions such as new token rules, minor for larger features
  such as a new language's full token set, and major for breaking changes to packaging or
  installation.
