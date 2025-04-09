{ lib, stdenvNoCC }:
let
  inherit (lib) fileset;
  tracked = fileset.unions [
    # ../src
  ];
in
stdenvNoCC.mkDerivation {
  pname = "template";
  version = "0.1.0";
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (file:
      !file.hasExt "nix"
      && file.name != "flake.lock"
      && file.type == "regular") ../.) tracked;
  };
  installPhase = ''
    cp -r "$src" "$out"
  '';
}
