{
  mkShell,
  rustPlatform,
  rustc,
  cargo,
  rust-analyzer,
  rustfmt,
  clippy,
}:
mkShell {
  name = "rust";
  packages = [
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
  ];

  env = {
    RUST_SRC_PATH = rustPlatform.rustLibSrc;
    RUST_BACKTRACE = 1;
  };
}
