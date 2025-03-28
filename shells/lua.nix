{
  name,
  mkShell,
  lua-language-server,
  luajitPackages,
  stylua,
  ...
}:
mkShell {
  inherit name;
  packages = [
    lua-language-server
    stylua
    luajitPackages.luacheck
  ];
}
