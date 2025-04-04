{
  haskellPackages,
  ghc,
  cabal-install,
  haskell-language-server,
  hlint,
  ormolu,
}:
haskellPackages.shellFor {
  name = "haskell";
  packages = p: [
    (p.callPackage ./default.nix { })
  ];
  nativeBuildInputs = [
    ghc
    cabal-install
    haskell-language-server
    hlint
    ormolu
  ];
}
