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
  {
    mkShell,
    rustPlatform,
    rustc,
    cargo,
    rust-analyzer,
    rustfmt,
  }:
  mkShell {
    name = "rust";
    packages = [
      rustc
      cargo
      rust-analyzer
      rustfmt
    ];

    env = {
      RUST_SRC_PATH = rustPlatform.rustLibSrc;
      RUST_BACKTRACE = 1;
    };
  }
) { }
