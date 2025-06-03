{ lib, mkDerivation }@pkgs:
let
  inherit (builtins) attrValues;
  pkgs' = import ./overrides.nix pkgs;

  inherit (lib) fileset;
  name = "haskell";

  sources = fileset.unions [
    ../${name}.cabal
    (fileset.maybeMissing ../app)
    (fileset.maybeMissing ../src)
  ];
in
mkDerivation {
  pname = name;
  version = "0.1.0.0";

  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (
      file: !file.hasExt "nix" && file.name != "flake.lock"
    ) ../.) sources;
  };

  executableHaskellDepends = attrValues {
    inherit (pkgs') base;
  };

  libraryHaskellDepends = attrValues {
    inherit (pkgs') base;
  };

  isLibrary = true;
  isExecutable = true;

  license = "unknown";
}
