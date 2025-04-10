{
  inputs = {
    typix = {
      url = "git+https://github.com/loqusion/typix?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
  };
  outputs = { typix, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forall = fn: nixpkgs.lib.attrsets.genAttrs systems (system:
        fn nixpkgs.legacyPackages.${system} system);
      call = file: forall (pkgs: system: {
        default = pkgs.callPackage file { typix' = typix.lib.${system}; };
      });
    in {
      packages = call ./nix/default.nix;
      devShells = call ./nix/shell.nix;
    };
}
