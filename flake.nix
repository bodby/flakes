{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forall = f: nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; }; in
        f pkgs system);
    in {
      templates = {
        default.path = ./templates/default;
        rust.path = ./templates/rust;
        # nvim.path = ./nvim;
        typst.path = ./templates/typst;
        # haskell.path = ./haskell;
      };

      devShells = forall (pkgs: _:
        let
          inherit (pkgs.lib) pipe filterAttrs hasSuffix removeSuffix mapAttrs';
          shells = pipe (builtins.readDir ./shells) [
            (filterAttrs (name: _: hasSuffix ".nix" name))
            (mapAttrs' (name: _: {
              name = removeSuffix ".nix" name;
              value = pkgs.callPackage (./shells + "/${name}") { };
            }))
          ];
        in
        shells // {
          default = pkgs.callPackage ./shells/nix.nix { };
        });
    };
}
