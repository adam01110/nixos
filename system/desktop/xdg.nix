{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config = {
        common.default = [
          "kde"
        ];
        hyprland.default = [
          "hyprland"
          "kde"
        ];
      };
      extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
    };

    # Cursor theme Bibata cursor theme fallback
    icons.fallbackCursorThemes = [ "Bibata-Modern-Classic" ];
  };
}
