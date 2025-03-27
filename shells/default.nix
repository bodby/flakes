{
  mkShell,
  nixd,
  ...
}:
mkShell {
  name = "nix-shell";
  packages = [ nixd ];
}
