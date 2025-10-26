{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkForce;
in
{
  xdg.portal = {
    enable = mkForce true;

    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];

      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
      ];
    };

    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };
}
