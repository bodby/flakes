{
  pkgs ?
    let
      lock = (builtins.fromJSON (builtins.readFile ../flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "${lock.url}/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs { },
}:
pkgs.callPackage (
  {
    mkShellNoCC,
    luajit,
    lua-language-server,
    stylua,
  }:
  mkShellNoCC {
    name = "lua";
    packages = [
      luajit
      lua-language-server
      stylua
    ];
  }
) { }
