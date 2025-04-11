# About
Nix flake template and dev shells.

## Usage

### Flakes
Add this repo as a flake input to your NixOS configuration:

```nix
# flake.nix
{
  inputs = {
    # Use either the GitHub or Codeberg repo.
    flakes = {
      url = "git+https://github.com/bodby/weeee?shallow=1";
      url = "git+https://codeberg.org/bodby/weeee?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
  };
}
```

Then either create a new template or enter a dev shell, replacing `<...>` with the template or shell name:

```bash
nix flake init -t flakes#<template>
nix develop flakes#<shell>
```

If this doesn't work, then please open an issue; it is probably related to `$NIX_PATH`.

### No flakes
Just clone the repo.

Then you can use any shell in `shells/` (replacing `<shell>` with the file you want) by running:

```bash
nix-shell -E 'let pkgs = import <nixpkgs> { }; in pkgs.callPackage ./shells/<shell>.nix { }'
```

Or templates by `cp -r`'ing them. When you want to build their package, go into the directory you just copied to and run:

```bash
nix-build -E 'let pkgs = import <nixpkgs> { }; in pkgs.callPackage ./nix { }'
```