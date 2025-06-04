{ lib, haskellPackages }:
let
  inherit (builtins) attrValues;

  # If you ever get version mismatches, add cabal2nix overrides here.
  pkgs' = haskellPackages.override {
    overrides = final: _: {
      # directory = final.callPackage ./generated/directory.nix { };
    };
  };

  name = "haskell";

  inherit (lib) fileset;
  sources = fileset.unions [
    ../${name}.cabal
    (fileset.maybeMissing ../app)
    (fileset.maybeMissing ../src)
  ];
in
haskellPackages.mkDerivation {
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
