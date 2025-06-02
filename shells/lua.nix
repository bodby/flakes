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
