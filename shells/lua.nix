{
  mkShellNoCC,
  luajit,
  lua-language-server,
  stylua,
  luajitPackages,
}:
mkShellNoCC {
  name = "lua-jit";
  packages = [
    luajit
    lua-language-server
    stylua
    luajitPackages.luacheck
    luajitPackages.busted
  ];
}
