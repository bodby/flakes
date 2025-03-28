{
  name,
  mkShell,
  rustPlatform,
  rustc,
  cargo,
  rust-analyzer,
  clippy,
  rustfmt,
  ...
}:
mkShell {
  inherit name;
  RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";
  packages = [
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
  ];
}
