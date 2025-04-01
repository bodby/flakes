{
  pname,
  version,
  stdenvNoCC,
  lib,
  ...
}:
let inherit (lib.fileset) fileFilter toSource; in
stdenvNoCC.mkDerivation {
  inherit pname version;
  src = toSource {
    root = ../.;
    fileset = fileFilter (file:
      !file.hasExt "nix" && file.name != "flake.lock") ../.;
  };
  installPhase = ''
    cp -r $src $out
  '';
}
