{
  mkShell,
  clang-tools,
  cppcheck,
}:
mkShell {
  name = "c";
  packages = [
    clang-tools
    cppcheck
  ];
}
