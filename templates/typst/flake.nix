{
  inputs = {
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { typix, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forall = fn: nixpkgs.lib.genAttrs systems (system:
        fn nixpkgs.legacyPackages.${system} system);
      call = file: forall (pkgs: system: {
        default = pkgs.callPackage file { typix' = typix.lib.${system}; };
      });
    in {
      packages = call ./nix/default.nix;
      devShells = call ./nix/shell.nix;
    };
}
