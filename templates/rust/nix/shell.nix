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
  name = name + "-shell";
  RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";
  packages = [
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
  ];
}
