{
  overlays = [
    (_: prev: {
      haskellPackages = prev.haskellPackages.override {
        # If you ever get version mismatches, add overrides here using cabal2nix.
        overrides = final: _: {
          # directory = final.callPackage ./generated/directory.nix { };
        };
      };
    })
  ];
}
