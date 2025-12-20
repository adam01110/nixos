{
  pkgs,
  ...
}:

# system xdg portal config and cursor fallback.
{
  xdg = {
    portal = {
      # enable the xdg-desktop-portal services.
      enable = true;
      # route `xdg-open` through the portal..
      xdgOpenUsePortal = true;

      config = {
        # defaults used by any desktop.
        common = {

          # prefer the gtk portal if nothing else claims a method.
          default = [
            "gtk"
          ];

          # use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };

        # desktop-specific overrides for hyprland.
        hyprland = {
          # use hyprland portal first, then gtk as a fallback.
          default = [
            "hyprland"
            "gtk"
          ];

          # prefer kde's file chooser.
          "org.freedesktop.impl.portal.FileChooser" = [
            "kde"
          ];

          # use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };

      # provide gtk and kde portals.
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        kdePackages.xdg-desktop-portal-kde
      ];
    };

    # fallback cursor to keep cursors.
    icons.fallbackCursorThemes = [ "Bibata-Modern-Classic" ];
  };

  environment = {
    # ensure the cursor theme is present system-wide.
    systemPackages = [ pkgs.nur.repos.adam0.bibata-modern-cursors-classic ];

    # weird thing that fixes something?, do not touch.
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
