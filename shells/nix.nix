{
  name,
  mkShell,
  nixd,
  ...
}:
mkShell {
  inherit name;
  packages = [ nixd ];
}
