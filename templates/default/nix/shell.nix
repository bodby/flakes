{
  pname,
  mkShell,
  ...
}:
mkShell {
  name = pname;
  packages = [ ];
  inputsFrom = [ ];
}
