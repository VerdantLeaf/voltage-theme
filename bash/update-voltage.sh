#!/usr/bin/env bash
set -euo pipefail

REPO="VerdantLeaf/voltage-theme"
API="https://api.github.com/repos/$REPO/releases?per_page=50"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$API" -o "$TMP/releases.json"

install_latest() {
  local kind="$1" tag version dir
  tag=$(grep -o "\"tag_name\": *\"$kind-v[^\"]*\"" "$TMP/releases.json" | head -n1 | sed 's/.*"\(.*\)"$/\1/') || true
  if [ -z "$tag" ]; then
    echo "No $kind release found, skipping." >&2
    return 0
  fi
  version="${tag#"$kind"-v}"
  dir="$TMP/$kind"
  mkdir -p "$dir"
  curl -fsSL "https://github.com/$REPO/releases/download/$tag/voltage-$kind-$version.tar.gz" | tar xz -C "$dir"
  echo "==> $kind $version"
  bash "$dir"/voltage-"$kind"-*/install.sh
}

if command -v nano >/dev/null 2>&1; then install_latest nano; else echo "nano not found, skipping."; fi
if command -v vim >/dev/null 2>&1 || command -v nvim >/dev/null 2>&1; then install_latest vim; else echo "vim/nvim not found, skipping."; fi
