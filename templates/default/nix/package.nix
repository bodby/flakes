{
  stdenvNoCC,
  lib,
  ...
}:
let inherit (lib.fileset) fileFilter toSource; in
stdenvNoCC.mkDerivation {
  pname = "template";
  version = "0.1.0";
  src = toSource {
    root = ../.;
    fileset = fileFilter (file:
      !file.hasExt "nix" && file.name != "flake.lock") ../.;
  };
  installPhase = ''
    cp -r $src $out
  '';
}
