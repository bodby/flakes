{
  stdenvNoCC,
  lib,
  ...
}:
let
  inherit (lib) fileset;
in
stdenvNoCC.mkDerivation {
  pname = "template";
  version = "0.1.0";
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.fileFilter (file:
      !file.hasExt "nix" && file.name != "flake.lock") ../.;
  };
  installPhase = ''
    cp -r $src $out
  '';
}
