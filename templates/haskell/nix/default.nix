{ lib, haskellPackages }:
let
  name = "haskell";

  inherit (lib) fileset;
  sources = fileset.unions [
    ../${name}.cabal
    (fileset.maybeMissing ../app)
    (fileset.maybeMissing ../src)
  ];

  inherit (builtins) attrValues;
  pkgs' = haskellPackages.override {
    # If you ever get version mismatches, add cabal2nix overrides here.
    overrides = final: _: {
      # directory = final.callPackage ./generated/directory.nix { };
    };
  };
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
