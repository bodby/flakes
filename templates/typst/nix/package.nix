{
  typix',
  lib,
  cascadia-code,
  ...
}:
let
  inherit (lib.fileset)
    fileFilter
    toSource
    maybeMissing
    union
    unions;
  virtualPaths = [
    # ../images
    # ../data
  ];
in
typix'.buildTypstProject {
  inherit virtualPaths;
  typstSource = "main.typ";
  src = toSource {
    root = ../.;
    fileset = union (fileFilter (file:
      file.hasExt "typ" ||
      builtins.elem file.name [ "typst.toml" "metadata.toml" ]) ../.)
      (unions (builtins.map maybeMissing virtualPaths));
  };
  typstOpts.format = "pdf";
  fontPaths = [
    "${cascadia-code}/share/fonts/truetype"
  ];
}
