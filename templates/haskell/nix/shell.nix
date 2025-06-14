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
  {
    haskellPackages,
    cabal-install,
    haskell-language-server,
    ormolu,
    cabal2nix,
  }:
  haskellPackages.shellFor {
    name = "haskell";

    packages = p: [
      (p.callPackage ./default.nix { })
    ];

    nativeBuildInputs = [
      cabal-install
      haskell-language-server
      ormolu
      haskellPackages.cabal-gild
      cabal2nix
    ];
  }
) { }
