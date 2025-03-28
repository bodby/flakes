{
  name,
  typix',
  tinymist,
  ...
}:
typix'.devShell {
  inherit name;
  packages = [ tinymist ];
}
