{
  mkShellNoCC,
  rustPlatform,
  rustc,
  cargo,
  rust-analyzer,
  clippy,
  rustfmt,
}:
mkShellNoCC {
  name = "rust";
  env = {
    RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";
    RUST_BACKTRACE = 1;
  };
  packages = [
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
  ];
}
