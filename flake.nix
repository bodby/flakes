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
      };

      devShells = forall (pkgs:
        let
          inherit (pkgs) lib callPackage;
        in
        lib.trivial.pipe (builtins.readDir ./shells) [
          (lib.attrsets.filterAttrs (name: _:
            lib.strings.hasSuffix ".nix" name))
          (lib.attrsets.mapAttrs' (name: _: {
            name = lib.strings.removeSuffix ".nix" name;
            value = callPackage (./shells + "/${name}") { };
          }))
        ] // {
          default = callPackage ./shells/nix.nix { };
        });
    };
}
