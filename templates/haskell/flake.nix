{
  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      pkgs =
        system:
        import nixpkgs {
          inherit system;
          config = import ./nix/overrides.nix;
        };

      forSystems = f: nixpkgs.lib.genAttrs systems (system: f (pkgs system));
      call =
        file:
        forSystems (pkgs: {
          default = pkgs.haskellPackages.callPackage file { };
        });
    in
    {
      packages = call ./nix/default.nix;
      devShells = call ./nix/shell.nix;
    };
}
