{
  pkgs ?
    let
      lock = (builtins.fromJSON (builtins.readFile ../flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "${lock.url}/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs { },
}:
pkgs.callPackage (
  { lib, rustPlatform }:
  let
    toml = (lib.importTOML ../Cargo.toml).package;

    inherit (lib) fileset;
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
) { }
