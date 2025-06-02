{
  lib,
  mkDerivation,
  base,
}:
let
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

  isLibrary = true;
  isExecutable = true;

  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (
      file: !file.hasExt "nix" && file.name != "flake.lock"
    ) ../.) sources;
  };

  executableHaskellDepends = [ base ];

  license = "unknown";
}
