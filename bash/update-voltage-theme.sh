#!/usr/bin/env bash
set -e

REPO="VerdantLeaf/voltage-theme"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

gh release download --repo "$REPO" --pattern '*.vsix' --clobber -D "$TMP_DIR"
code --install-extension "$TMP_DIR"/*.vsix
