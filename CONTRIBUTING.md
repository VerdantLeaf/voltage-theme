# Contributing

Thanks for considering a change to Voltage. Bug fixes, new language token rules, and
palette tweaks are all welcome — open a PR against `main`. While we are open to and welcome changes and additions, I cannot guarantee that they will be accepted and/or persisted for all time.
At the end of the day, this is the theme that I use everyday, it needs to look good to me.

## Making a theme change

The theme lives at `vscode/themes/voltage-color-theme.json`. If you add or change a
color, also update the swatch table in `docs/palette.md` so the palette stays
documented in one place.

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

## VSCode Marketplace

I am currently considering whether to put Voltage on the VSCode marketplace. 

## Installing your own build

To test a change locally before it's released:

```
cd vscode
npx @vscode/vsce package
code --install-extension voltage-theme-<version>.vsix
```
