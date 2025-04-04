{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forall = fn: nixpkgs.lib.genAttrs systems (system:
        fn nixpkgs.legacyPackages.${system});
      call = file: forall (pkgs: {
        default = pkgs.callPackage file { };
      });
    in {
      packages = call ./nix/default.nix;
      devShells = call ./nix/shell.nix;
    };
}
