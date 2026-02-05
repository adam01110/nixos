{config, ...}:
# Set global flatpak overrides.
let
  home = config.home.homeDirectory;
in {
  services.flatpak.overrides.global = {
    # Add icons and dconf to the extra files.
    Context.filesystems = [
      "${home}/.icons"
      "xdg-config/dconf:ro"
    ];

    # Export gtk, gdk, and qt variables.
    Environment = {
      GDK_BACKEND = "wayland,x11,*";
      GSK_RENDERER = "vulkan";
      GTK_USE_PORTAL = "1";
      GDK_DEBUG = "portals";
      GDK_SCALE = "1";

      QT_QPA_PLATFORM = "wayland;xcb";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };
}
