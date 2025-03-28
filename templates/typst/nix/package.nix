{
  typix',
  # roboto,
  ...
}:
typix'.buildTypstProject {
  typstSource = "main.typ";
  src = typix'.cleanTypstSource ../.;
  typstOpts.format = "pdf";
  fontPaths = [
    # "${roboto}/share/fonts/truetype"
  ];
  virtualPaths = [
    # ../images
    # ../data
  ];
}
