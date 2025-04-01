{
  pname,
  version,
  rustPlatform,
  lib,
  ...
}:
let
  inherit (lib.fileset) toSource unions maybeMissing fileFilter;
  tracked = unions [
    ../src
    ../Cargo.lock
    ../Cargo.toml
    (builtins.map maybeMissing [
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
  inherit pname version;
  src = toSource {
    root = ../.;
    fileset = fileFilter (file:
      !file.hasExt "nix" && file.name != "flake.lock" &&
      builtins.elem file.name tracked) ../.;
  };
  cargoLock.lockFile = ../Cargo.lock;
}
