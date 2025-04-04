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
    in {
      templates = {
        default.path = ./templates/default;
        rust.path = ./templates/rust;
        # nvim.path = ./templates/nvim;
        typst.path = ./templates/typst;
        haskell.path = ./templates/haskell;
      };

      devShells = forall (pkgs:
        let
          inherit (pkgs) lib callPackage;
        in
        lib.pipe (builtins.readDir ./shells) [
          (lib.filterAttrs (name: _: lib.hasSuffix ".nix" name))
          (lib.mapAttrs' (name: _: {
            name = lib.removeSuffix ".nix" name;
            value = callPackage (./shells + "/${name}") { };
          }))
        ] // {
          default = callPackage ./shells/nix.nix { };
        });
    };
}
