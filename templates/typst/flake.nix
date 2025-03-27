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
      forall = f: nixpkgs.lib.genAttrs systems (system:
        let pkgs = import nixpkgs { inherit system; };
        in f pkgs system);
    in {
      packages = forall (pkgs: system:
        let
          typix' = typix.lib.${system};
        in {
          default = typix'.buildTypstProject {
            typstSource = "main.typ";
            src = typix'.cleanTypstSource ./.;
          };
        });

      devShells = forall (pkgs: _: {
        default = pkgs.mkShell {
          name = "typst-shell";
          packages = [ pkgs.tinymist ];
        };
      });
    };
}
