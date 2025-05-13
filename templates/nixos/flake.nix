{
  outputs = _: {
    nixosModules = {
      default = ./.;
      named = ./.;
    };
  };
}
