{
  haskellPackages,
  ghc,
  cabal-install,
  haskell-language-server,
  ormolu,
  hlint,
}:
haskellPackages.shellFor {
  name = "haskell";
  packages = p: [ ];
  nativeBuildInputs = [
    ghc
    cabal-install
    haskell-language-server
    ormolu
    hlint
  ];
}
