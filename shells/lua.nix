{
  mkShellNoCC,
  luajit,
  lua-language-server,
  luajitPackages,
  stylua,
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
