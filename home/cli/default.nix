{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fastfetch
    ./yazi
    ./atuin.nix
    ./btop.nix
    ./eza.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./nh.nix
    ./nvtop.nix
    ./other.nix
    ./starship.nix
    ./zoxide.nix
  ];
}
