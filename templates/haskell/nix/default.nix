{ lib, haskellPackages }:
let
  inherit (lib) fileset;
  name = "haskell";
  tracked = fileset.unions [
    (fileset.maybeMissing ../src)
    (fileset.maybeMissing ../app)
    ../${name}.cabal
  ];

  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (file:
      !file.hasExt "nix"
      && file.name != "flake.lock"
      && file.type == "regular") ../.) tracked;
  };
in
haskellPackages.callCabal2nix name src { }
