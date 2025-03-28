{
  pname,
  version,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage {
  inherit pname version;
  src = ../.;
  cargoLock.lockFile = ../Cargo.lock;
}
