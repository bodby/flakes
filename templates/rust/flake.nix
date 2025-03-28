{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    let
      inherit (cargoAttrs) version;
      cargoAttrs = (builtins.fromTOML (builtins.readFile ./Cargo.toml)).package;
      pname = cargoAttrs.name;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      call = f: nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in {
          default = pkgs.callPackage f { inherit pname version; };
        });
    in {
      packages = call ./nix/package.nix;
      devShells = call ./nix/shell.nix;
    };
}
