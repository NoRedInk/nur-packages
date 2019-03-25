{ pkgs ? import <nixpkgs> {} }:

(pkgs.callPackage ./composition.nix { })."@dillonkearns/elm-graphql-3.2.0"
