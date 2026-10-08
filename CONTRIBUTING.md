# Contributing

Thanks for considering a change to Voltage. Bug fixes, new language token rules, and
palette tweaks are all welcome — open a PR against `main`. While we are open to and welcome changes and additions, I cannot guarantee that they will be accepted and/or persisted for all time.
At the end of the day, this is the theme that I use everyday, it needs to look good to me.

## Making a theme change

The theme lives at `vscode/themes/voltage-color-theme.json`. If you add or change a
color, also update the swatch table in `docs/palette.md` so the palette stays
documented in one place.

## Changing the nano theme

The nano theme lives in `nano/` (`voltage.nanorc` for the interface and `nano/syntax/*.nanorc` for
languages). nano < 6 can't take hex colors, so the files use xterm-256 color indices — pick the
slot nearest to the palette hex — and `nano/install.sh` has a table that maps those indices to color
names for older nano. If you introduce a new index, add it to that table (`NAMES` in `install.sh`).
Note that inside a POSIX bracket expression a backslash is literal; write `[][(){}]`, not `[\[\](){}]`.

## Changing the Vim/Neovim colorscheme

Everything lives in `vim/colors/voltage.vim`. Colors are written once as hex in the palette block at
the top; the 256-color fallback is computed from them, so never hard-code a cterm value. Add
new language groups next to the existing per-language blocks, and the Treesitter/LSP equivalents
in the `has('nvim')` section so Neovim and Vim stay in step.

## Releasing

Releases are built and published automatically by
[`.github/workflows/release.yml`](.github/workflows/release.yml). The workflow watches for pushes to `main`
that change `vscode/package.json`'s `version` field, and treats a version bump as the
signal to cut a release. Concretely:

1. Bump `version` in [`vscode/package.json`](vscode/package.json) (e.g. `1.0.1` → `1.0.2`).
2. Add a matching `## 1.0.2` section to [`vscode/CHANGELOG.md`](vscode/CHANGELOG.md)
   describing what changed. This becomes the body of the GitHub Release, so write it
   for users, not just contributors.
3. Merge to `main`.

Once that lands, the workflow packages the extension with `vsce package` and publishes
a GitHub Release tagged `vX.Y.Z` with the `.vsix` attached — pulling its release notes
straight from the CHANGELOG section you wrote in step 2.

A few things follow from that:

- **A PR that only changes the theme doesn't trigger a release on its own.** Someone
  still has to decide when a version bump is warranted and include it — either in the
  PR itself, or in a follow-up commit to `main`. This is deliberate, drive-by changes or README updates don't modify the release version, and changes can be batched
  into a larger release update, if needed.
- **The workflow is idempotent.** If `vscode/package.json`'s version already has a
  matching GitHub Release, it's a no-op — pushing unrelated commits to `main` won't
  create duplicate or empty releases.
- **Follow the existing version scheme:** patch (`1.0.x`) for visual tweaks and small
  additions like new token rules, minor (`1.x.0`) for larger feature additions
  (e.g. a new language's full token set), major (`x.0.0`) for breaking changes to how
  the theme is packaged or installed.

### Vim/Neovim releases

Same flow with its own files: bump `vim/VERSION`, add a `## X.Y.Z` section to `vim/CHANGELOG.md`, and merge to
`main`. [`release-vim.yml`](.github/workflows/release-vim.yml) publishes `vim-vX.Y.Z` with
`voltage-vim-X.Y.Z.tar.gz`, not marked "latest". The VS Code, nano and Vim/Neovim release streams are
independent: each is triggered only by its own version file.

### nano releases

nano is released independently of the VS Code extension. Bump `nano/VERSION`, add a matching
`## X.Y.Z` section to `nano/CHANGELOG.md`, and merge to `main`;
[`.github/workflows/release-nano.yml`](.github/workflows/release-nano.yml) publishes a release tagged
`nano-vX.Y.Z` with a `voltage-nano-X.Y.Z.tar.gz` attached. The same rules apply as above (idempotent, no
release without a version bump). Changes under `nano/` never trigger a VS Code release and vice versa.
The nano release is deliberately not marked "latest" so the VS Code updater script keeps working.

## Installing your own build

To test a change locally before it's released:

```
cd vscode
npx @vscode/vsce package
code --install-extension voltage-theme-<version>.vsix
```

For nano, run `./nano/install.sh` from your checkout (and `./nano/install.sh --uninstall` to remove it).
For Vim/Neovim, run `./vim/install.sh` from your checkout (`--uninstall` to remove).
