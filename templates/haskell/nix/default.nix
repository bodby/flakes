{ lib, haskellPackages }:
let
  inherit (lib) fileset;
  tracked = fileset.unions [
    ../src
    ../app
    ../test
    ../haskell.cabal
  ];
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (file:
      !file.hasExt "nix" &&
      file.name != "flake.lock" &&
      file.type == "regular") ../.) tracked;
  };
in
haskellPackages.callCabal2nix "haskell" src { }
