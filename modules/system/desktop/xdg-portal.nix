{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
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

          # keep-sorted start

          # Use termfilechooser for file picking.
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          # Use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
          # keep-sorted end
        };

        # Desktop-specific overrides for hyprland.
        hyprland = {
          default = [
            # keep-sorted start
            "gtk"
            "hyprland"
            # keep-sorted end
          ];

          # keep-sorted start

          # Use termfilechooser for file picking.
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
          # Use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
          # keep-sorted end
        };
      };

      # Provide the gtk and terminal file chooser portals.
      extraPortals = attrValues {
        inherit
          (pkgs)
          # keep-sorted start
          xdg-desktop-portal-gtk
          xdg-desktop-portal-termfilechooser
          # keep-sorted end
          ;
      };
    };
  };

  systemd.user.services.xdg-desktop-portal = {
    after = mkAfter ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
  };
}
