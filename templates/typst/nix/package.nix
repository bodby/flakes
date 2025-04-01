{
  typix',
  lib,
  cascadia-code,
  ...
}:
let
  inherit (lib) fileset;
  virtualPaths = [
    # ../images
    # ../data
  ];
in
typix'.buildTypstProject {
  inherit virtualPaths;
  typstSource = "main.typ";
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.union (fileset.fileFilter (file:
      file.hasExt "typ" ||
      builtins.elem file.name [ "typst.toml" "metadata.toml" ]) ../.)
      (fileset.unions (builtins.map fileset.maybeMissing virtualPaths));
  };
  typstOpts.format = "pdf";
  fontPaths = [
    "${cascadia-code}/share/fonts/truetype"
  ];
}
