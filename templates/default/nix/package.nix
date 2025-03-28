{
  pname,
  version,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  inherit pname version;
  src = ../.;
}
