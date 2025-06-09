{
  pkgs ? import <nixpkgs> { },
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
