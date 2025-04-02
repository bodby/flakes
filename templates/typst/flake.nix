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
      call = f: nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          typix' = typix.lib.${system};
        in {
          default = pkgs.callPackage f { inherit typix'; };
        });
    in {
      packages = call ./nix/default.nix;
      devShells = call ./nix/shell.nix;
    };
}
