{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./stylix.nix
    ./xdg.nix
  ];
}
