{
  mkShellNoCC,
  clang-tools,
  cppcheck,
}:
mkShellNoCC {
  name = "c";
  packages = [
    clang-tools
    cppcheck
  ];
}
