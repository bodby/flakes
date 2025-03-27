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
      forall = f: nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; };
        in f pkgs system);
    in {
      templates = {
        default.path = ./default;
        rust.path = ./rust;
        nvim.path = ./nvim;
        typst.path = ./typst;
        # haskell.path = ./haskell;
      };

      # TODO: Make this automatically import all files in shells/.
      devShells = forall (pkgs: _:
        let nix = ./shells/default.nix;
        in builtins.mapAttrs (_: value: pkgs.callPackage value { }) {
          inherit nix;
          default = nix;
          lua = ./shells/lua.nix;
          rust = ./shells/rust.nix;
        });
    };
}
