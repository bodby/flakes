{
  mkShellNoCC,
  nixd,
  nixfmt,
  statix,
  nurl,
}:
mkShellNoCC {
  name = "nix";
  packages = [
    nixd
    nixfmt
    statix
    nurl
  ];
}
