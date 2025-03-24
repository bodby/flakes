{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      cargoAttrs = builtins.fromTOML (builtins.readFile ./Cargo.toml);
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forall = f: nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; };
        in f pkgs system);
    in {
      packages = forall (pkgs: _: {
        default = pkgs.rustPlatform.buildRustPackage {
          inherit (cargoAttrs.package) version;
          pname = cargoAttrs.package.name;
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };
      });

      devShells = forall (pkgs: _: {
        default = pkgs.mkShell {
          inherit (cargoAttrs.package) name;
          packages = builtins.attrValues {
            inherit (pkgs) rustc cargo rust-analyzer clippy rustfmt;
          };
        };
      });
    };
}
