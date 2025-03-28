{
  mkShell,
  lua-language-server,
  luajitPackages,
  stylua,
  ...
}:
mkShell {
  name = "lua-shell";
  packages = [
    lua-language-server
    stylua
    luajitPackages.luacheck
  ];
}
