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
      forall = fn: nixpkgs.lib.attrsets.genAttrs systems (system:
        fn nixpkgs.legacyPackages.${system});
    in {
      templates = {
        default.path = ./templates/default;
        rust.path = ./templates/rust;
        # nvim.path = ./templates/nvim;
        typst.path = ./templates/typst;
        haskell.path = ./templates/haskell;
        nixosModule.path = ./templates/nixos;
      };

      devShells = forall (pkgs:
        let
          inherit (pkgs) lib callPackage;
          inherit (lib) attrsets strings;
        in
        lib.trivial.pipe (builtins.readDir ./shells) [
          (attrsets.filterAttrs (name: _:
            strings.hasSuffix ".nix" name))
          (attrsets.mapAttrs' (name: _: {
            name = strings.removeSuffix ".nix" name;
            value = callPackage (./shells/${name}) { };
          }))
        ] // {
          default = callPackage ./shells/nix.nix { };
        });
    };
}
