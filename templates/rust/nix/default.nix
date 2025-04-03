{
  rustPlatform,
  lib,
}:
let
  inherit (lib) fileset;
  toml = (lib.importTOML ../Cargo.toml).package;
  # TODO: Are the optional filesets ever used?
  #       See buildRustPackage source.
  tracked = fileset.unions ([
    ../src
    ../Cargo.lock
    ../Cargo.toml
  ] ++ (builtins.map fileset.maybeMissing [
    ../tests
    ../benches
    ../examples
    ../rustfmt.toml
    ../clippy.toml
    ../rust-toolchain.toml
    ../build.rs
  ]));
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
