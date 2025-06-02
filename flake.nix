{
  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
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

      forSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      templates = {
        default = {
          path = ./templates/default;
          description = "Trivial Nix boilerplate";
        };

        haskell = {
          path = ./templates/haskell;
          description = "Haskell project using Cabal";
        };

        meta = {
          path = ./templates/meta;
          description = "Repository boilerplate";
        };

        rust = {
          path = ./templates/rust;
          description = "Rust project using Cargo";
        };

        # typst = {
        #   path = ./templates/typst;
        #   description = "Typst document";
        # };
      };

      devShells = forSystems (pkgs: {
        default = pkgs.callPackage ./shells/nix.nix { };
        lua = pkgs.callPackage ./shells/lua.nix { };
        nix = pkgs.callPackage ./shells/nix.nix { };
        rust = pkgs.callPackage ./shells/rust.nix { };
      });
    };
}
