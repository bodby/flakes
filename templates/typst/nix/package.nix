{
  typix',
  cascadia-code,
  ...
}:
typix'.buildTypstProject {
  typstSource = "main.typ";
  src = typix'.cleanTypstSource ../.;
  typstOpts.format = "pdf";
  fontPaths = [
    "${cascadia-code}/share/fonts/truetype"
  ];
  virtualPaths = [
    # ../images
    # ../data
  ];
}
