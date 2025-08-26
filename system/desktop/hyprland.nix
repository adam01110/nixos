{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${system}.hyprland;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  };
}
