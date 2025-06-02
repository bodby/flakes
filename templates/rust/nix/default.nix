{ lib, rustPlatform }:
let
  inherit (lib) fileset;
  toml = (lib.importTOML ../Cargo.toml).package;

  sources = fileset.unions [
    ../Cargo.toml
    ../Cargo.lock
    (fileset.maybeMissing ../build.rs)
  ];
in
rustPlatform.buildRustPackage {
  inherit (toml) version;
  pname = toml.name;

  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (
      file: !file.hasExt "nix" && file.name != "flake.lock"
    ) ../.) sources;
  };

  cargoLock.lockFile = ../Cargo.lock;
}
