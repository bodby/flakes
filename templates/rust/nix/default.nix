{
  rustPlatform,
  lib,
}:
let
  inherit (lib) fileset;
  cargoAttrs = (builtins.fromTOML (builtins.readFile ../Cargo.toml)).package;
  tracked = fileset.unions [
    ../src
    ../Cargo.lock
    ../Cargo.toml
    (builtins.map fileset.maybeMissing [
      ../tests
      ../benches
      ../examples
      ../rustfmt.toml
      ../clippy.toml
      ../rust-toolchain.toml
      ../build.rs
    ])
  ];
in
rustPlatform.buildRustPackage {
  inherit (cargoAttrs) version;
  pname = cargoAttrs.name;
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.fileFilter (file:
      !file.hasExt "nix" && file.name != "flake.lock" &&
      builtins.elem file.name tracked) ../.;
  };
  cargoLock.lockFile = ../Cargo.lock;
}
