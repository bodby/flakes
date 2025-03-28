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
        let pkgs = import nixpkgs { inherit system; }; in
        f pkgs system);
    in {
      packages = forall (pkgs: _: {
        default = pkgs.stdenv.mkDerivation { };
      });

      devShells = forall (pkgs: _: {
        default = pkgs.mkShell {
          name = "";
          packages = [ ];
          inputsFrom = [ ];
        };
      });
    };
}
