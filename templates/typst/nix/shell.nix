{
  typix',
  typst,
  tinymist,
}:
typix'.devShell {
  name = "typst";
  packages = [ typst tinymist ];
}
