# Xdg portal configuration module.
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    mkForce
    ;
in {
  xdg = {
    portal = {
      # Enable xdg-desktop-portal user services.
      enable = mkForce true;

      # Route `xdg-open` calls through the portal.
      xdgOpenUsePortal = true;

      config = {
        # Defaults used by any desktop.
        common = {
          # Prefer the gtk portal if nothing else claims a method.
          default = ["gtk"];

          # Use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];

          # Use termfilechooser for file picking.
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
        };

        # Desktop-specific overrides for hyprland.
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
      };

      # Provide the gtk and terminal file chooser portals.
      extraPortals = attrValues {
        inherit
          (pkgs)
          xdg-desktop-portal-gtk
          xdg-desktop-portal-termfilechooser
          ;
      };
    };

    configFile = {
      "xdg-desktop-portal-termfilechooser/config" = {
        text = let
          terminalCommand = getExe config.xdg.terminal-exec.package;
        in ''
          [filechooser]
          cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
          env=TERMCMD=${terminalCommand} --title=Termfilechooser
        '';
      };
    };
  };
}
