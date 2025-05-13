{
  lib,
  typix',
  cascadia-code,
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
  src = fileset.toSource {
    root = ../.;
    fileset = fileset.union (fileset.fileFilter (file:
      file.hasExt "typ"
      || builtins.elem file.name [ "typst.toml" "metadata.toml" ]) ../.)
      (fileset.unions virtualPaths);
  };

  typstSource = "main.typ";
  typstOpts = {
    format = "pdf";
  };

  fontPaths = [
    "${cascadia-code}/share/fonts/truetype"
  ];
}
