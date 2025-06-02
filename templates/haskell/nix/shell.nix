{
  shellFor,
  cabal-install,
  haskell-language-server,
  ormolu,
  cabal-fmt,
  cabal2nix,
}:
shellFor {
  name = "haskell";

  packages = p: [
    (p.callPackage ./default.nix { })
  ];

  nativeBuildInputs = [
    cabal-install
    haskell-language-server
    ormolu
    cabal-fmt
    cabal2nix
  ];
}
