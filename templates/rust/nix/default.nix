{ lib, rustPlatform }:
let
  inherit (lib) fileset;
  toml = (lib.importTOML ../Cargo.toml).package;
  tracked = fileset.unions [
    ../src
    ../Cargo.lock
    ../Cargo.toml
    (fileset.maybeMissing ../build.rs)
  ];
in
rustPlatform.buildRustPackage {
  inherit (toml) version;
  pname = toml.name;
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.intersection (fileset.fileFilter (file:
      !file.hasExt "nix" &&
      file.name != "flake.lock" &&
      file.type == "regular") ../.) tracked;
  };
  cargoLock.lockFile = ../Cargo.lock;
}
