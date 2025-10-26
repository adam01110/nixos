{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./noctalia.nix
    ./plymouth.nix
    ./sddm.nix
    ./stylix.nix
    ./xdg.nix
  ];
}
