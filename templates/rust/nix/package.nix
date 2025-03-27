{
  name,
  version,
  rustPlatform,
  ...
}:
rustPlatform.buildRustPackage {
  inherit version;
  pname = name;
  src = ./.;
  cargoLock.lockFile = ../Cargo.lock;
}
