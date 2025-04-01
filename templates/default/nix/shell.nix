{
  mkShellNoCC,
  nixd,
}:
mkShellNoCC {
  name = "nix";
  packages = [ nixd ];
}
