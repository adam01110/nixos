{
  config,
  lib,
  pkgs,
  ...
}:

{
  # TODO
  xdg = {
    # home manager xdg settings
    terminal-exec.enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config = {
        common.default = [
          "gtk"
        ];
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
      };

      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    # Cursor theme Bibata cursor theme fallback
    icons.fallbackCursorThemes = [ "Bibata-Modern-Classic" ];
  };

  environment.systemPackages = with pkgs.nur.repos.adam0; [ bibata-modern-cursors-classic ];
}
