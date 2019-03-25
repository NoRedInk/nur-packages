#!/usr/bin/env bash
set -euo pipefail
set -x

PACKAGE="${1:-}"
VERSION="${2:-}"
ALIAS="${3:-$PACKAGE}"

if test -z "$PACKAGE"; then
    echo "USAGE: $0 PACKAGE VERSION [ALIAS]"
    exit 1
fi

PKG_DIR="./pkgs/${ALIAS}"
mkdir -p "$PKG_DIR"
cd "$PKG_DIR"

cat > package.json <<EOF
[
  { "$PACKAGE": "$VERSION" }
]
EOF

nix-shell --packages nodePackages.node2nix --command 'node2nix --input package.json --nodejs-8 --composition composition.nix'

cat > default.nix <<EOF
{ pkgs ? import <nixpkgs> {} }:

(pkgs.callPackage ./composition.nix { })."$PACKAGE-$VERSION"
EOF
