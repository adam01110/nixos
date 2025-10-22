{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.portal = {
    enable = true;

    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];

      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
      ];
    };

    extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
