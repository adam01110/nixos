{config, ...}: let
  inherit (config.xdg) configHome;
  inherit (config.xdg) cacheHome;
in {
  # user-level files and session environment.
  home = {
    # copy user avatar to ~/.face for display managers.
    file.".face".source = ../face.png;

    preferXdgDirectories = true;

    # wayland-first environment, renderers, and toolkit hints.
    sessionVariables = {
      MAGICK_OPENCL_DEVICE = "gpu";
      RUSTICL_ENABLE = "radeonsi";

      GDK_BACKEND = "wayland,x11,*";
      GSK_RENDERER = "vulkan";
      GTK_USE_PORTAL = 1;
      GDK_DEBUG = "portals";
      GDK_SCALE = 1;

      QT_QPA_PLATFORM = "wayland;xcb";
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";

      PROTON_NO_WM_DECORATION = 1;
      WINE_NO_WM_DECORATION = 1;

      NIXOS_OZONE_WL = 1;

      APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
      APP2UNIT_TYPE = "service";

      BIOME_CONFIG_PATH = "${configHome}/biome/biome.json";
      RUFF_CACHE_DIR = "${cacheHome}/ruff";
    };
  };

  # minimal dconf tweaks.
  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = "";
    "org/gnome/desktop/interface".gtk-enable-primary-paste = false;
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
