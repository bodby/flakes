{
  outputs = { ... }: {
    templates = {
      default.path = ./default;
      rust.path = ./rust;
      # https://github.com/NixOS/nixpkgs/pull/369283
      # typst.path = ./typst;
      # haskell.path = ./haskell;
    };
  };
}
