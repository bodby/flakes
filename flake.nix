{
  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forall = f: nixpkgs.lib.genAttrs systems (system:
        f nixpkgs.legacyPackages.${system});
    in {
      templates = {
        default = {
          path = ./templates/default;
          description = "Opinionated Nix boilerplate";
        };

        rust = {
          path = ./templates/rust;
          description = "Rust project using Cargo";
        };

        # nvim = {
        #   path = ./templates/nvim;
        #   description = "Neovim plugin";
        # };

        typst = {
          path = ./templates/typst;
          description = "Typst document using Typix";
        };

        haskell = {
          path = ./templates/haskell;
          description = "Haskell project using Cabal";
        };

        nixos = {
          path = ./templates/nixos;
          description = "NixOS module";
        };
      };

      devShells = forall (pkgs:
        let
          inherit (pkgs) lib callPackage;
        in
        lib.pipe (builtins.readDir ./shells) [
          (lib.filterAttrs (name: _:
            lib.hasSuffix ".nix" name))
          (lib.mapAttrs' (name: _: {
            name = lib.removeSuffix ".nix" name;
            value = callPackage ./shells/${name} { };
          }))
        ] // {
          default = callPackage ./shells/nix.nix { };
        });
    };
}
