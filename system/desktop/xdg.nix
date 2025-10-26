{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg = {
    terminal-exec.enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config = {
        common = {
          default = [
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
      };

      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    # Cursor theme Bibata cursor theme fallback
    icons.fallbackCursorThemes = [ "Bibata-Modern-Classic" ];
  };

  environment = {
    systemPackages = [ pkgs.nur.repos.adam0.bibata-modern-cursors-classic ];

    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
