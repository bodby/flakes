{
  typix',
  tinymist,
  typstyle,
}:
typix'.devShell {
  name = "typst";
  packages = [
    tinymist
    typstyle
  ];
}
