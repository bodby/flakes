{
  name,
  typix',
  tinymist,
  ...
}:
typix'.devShell {
  name = name + "-shell";
  packages = [ tinymist ];
}
