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
    haskellPackages.cabal-fmt
    cabal2nix
  ];
}
