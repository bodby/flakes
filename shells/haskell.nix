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
  packages = p: [ ];
  nativeBuildInputs = [
    ghc
    cabal-install
    haskell-language-server
    hlint
    ormolu
  ];
}
