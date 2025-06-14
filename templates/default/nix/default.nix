{
  pkgs ?
    let
      lock = (builtins.fromJSON (builtins.readFile ../flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "${lock.url}/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs { },
}:
pkgs.callPackage (
  { lib, stdenvNoCC }:
  let
    inherit (lib) fileset;
    sources = fileset.unions [ ];
  in
  stdenvNoCC.mkDerivation {
    pname = "default";
    version = "0.1.0";

    src = fileset.toSource {
      root = ../.;
      fileset = fileset.intersection (fileset.fileFilter (
        file: !file.hasExt "nix" && file.name != "flake.lock"
      ) ../.) sources;
    };
  }
) { }
