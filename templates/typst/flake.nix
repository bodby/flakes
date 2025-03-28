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
      name = "typst";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      call = f: nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          typix' = typix.lib.${system};
        in {
          default = pkgs.callPackage f { inherit name typix'; };
        });
    in {
      packages = call ./nix/package.nix;
      devShells = call ./nix/shell.nix;
    };
}
