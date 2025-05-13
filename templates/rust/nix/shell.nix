{
  mkShell,
  rustPlatform,
  rustc,
  cargo,
  rust-analyzer,
  clippy,
  rustfmt,
}:
mkShell {
  name = "rust";
  packages = [
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
  ];

  env = {
    RUST_SRC_PATH = rustPlatform.rustLibSrc;
    RUST_BACKTRACE = 1;
  };
}
