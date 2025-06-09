{
  pkgs ? import <nixpkgs> { },
}:
pkgs.callPackage (
  {
    mkShellNoCC,
    nixd,
    nixfmt-rfc-style,
  }:
  mkShellNoCC {
    name = "nix";
    packages = [
      nixd
      nixfmt-rfc-style
    ];
  }
) { }
