{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    let
      inherit (cargo.package) version;
      cargo = builtins.fromTOML (builtins.readFile ./Cargo.toml);
      pname = cargo.package.name;
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
