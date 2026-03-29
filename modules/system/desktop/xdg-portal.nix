{
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) mkAfter;
in {
  xdg = {
    portal = {
      # Enable xdg-desktop-portal services.
      enable = true;

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
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];

          # Use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];

          # Use termfilechooser for file picking.
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
        };
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
  };

  systemd.user.services.xdg-desktop-portal = {
    after = mkAfter ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
  };
}
