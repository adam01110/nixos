{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./plymouth.nix
    ./sddm.nix
    ./stylix.nix
    ./xdg.nix
  ];
}
