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

      forSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
      call =
        file:
        forSystems (pkgs: {
          default = import file { inherit pkgs; };
        });
    in
    {
      packages = call ./nix/default.nix;
      devShells = call ./nix/shell.nix;
    };
}
