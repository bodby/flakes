{
  typix',
  typst,
  tinymist,
  typstyle,
}:
typix'.devShell {
  name = "typst";
  packages = [
    typst
    tinymist
    typstyle
  ];
}
