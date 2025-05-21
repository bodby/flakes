{
  mkShellNoCC,
  nixd,
  nixfmt-rfc-style,
  statix,
  nurl,
}:
mkShellNoCC {
  name = "nix";
  packages = [
    nixd
    nixfmt-rfc-style
    statix
    nurl
  ];
}
