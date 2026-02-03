{inputs}: final: _prev:
# expose packages from flake inputs under pkgs.*.
let
  inherit (final.stdenv.hostPlatform) system;
in
  with inputs; {
    determinate-nix = determinate.packages.${system}.default;
    neovim-nightly = neovim-nightly-overlay.packages.${system}.default;
  }
