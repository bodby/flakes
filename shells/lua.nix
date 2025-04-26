{
  mkShellNoCC,
  luajit,
  lua-language-server,
  stylua,
  luajitPackages,
}:
mkShellNoCC {
  name = "luajit";
  packages = [
    luajit
    lua-language-server
    stylua
    luajitPackages.luacheck
    luajitPackages.busted
  ];
}
