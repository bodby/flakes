{
  pkgs ? import <nixpkgs> { },
}:
pkgs.callPackage (
  {
    mkShell,
    rustPlatform,
    rustc,
    cargo,
    rust-analyzer,
    rustfmt,
  }:
  mkShell {
    name = "rust";
    packages = [
      rustc
      cargo
      rust-analyzer
      rustfmt
    ];

    env = {
      RUST_SRC_PATH = rustPlatform.rustLibSrc;
      RUST_BACKTRACE = 1;
    };
  }
) { }
