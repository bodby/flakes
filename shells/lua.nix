{
  mkShell,
  lua-langauge-server,
  luajitPackages,
  stylua,
  ...
}:
mkShell {
  name = "lua-shell";
  packages = [
    lua-langauge-server
    stylua
    luajitPackages.luacheck
  ];
}
