{pkgs, ...}:
# System xdg portal config and cursor fallback.
{
  xdg = {
    portal = {
      # Enable the xdg-desktop-portal services.
      enable = true;
      # Route `xdg-open` through the portal.
      xdgOpenUsePortal = true;

      config = {
        # Defaults used by any desktop.
        common = {
          # Prefer the gtk portal if nothing else claims a method.
          default = [
            "gtk"
          ];

          # Use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };

        # Desktop-specific overrides for hyprland.
        hyprland = {
          # Use hyprland portal first, then gtk as a fallback.
          default = [
            "hyprland"
            "gtk"
          ];

          # Use gnome-keyring for the secret portal backend.
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };

      # Provide the gtk portal.
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    # Fallback cursor to keep cursors.
    icons.fallbackCursorThemes = ["Bibata-Modern-Classic"];
  };

  environment = {
    # Ensure the cursor theme is present system-wide.
    systemPackages = [pkgs.nur.repos.adam0.bibata-modern-cursors-classic];

    # Work around portal path discovery, do not touch.
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
