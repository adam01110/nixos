{config, ...}: let
  inherit
    (config.xdg)
    # keep-sorted start
    cacheHome
    configHome
    # keep-sorted end
    ;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Minimal dconf tweaks.
  dconf.settings = {
    # keep-sorted start
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    "org/gnome/desktop/interface".gtk-enable-primary-paste = false;
    "org/gnome/desktop/wm/preferences".button-layout = "";
    # keep-sorted end
  };

  # User-level files and session environment.
  home = {
    # keep-sorted start block=yes newline_separated=yes
    # Copy user avatar to ~/.face for display managers.
    file.".face".source = ../../face.png;

    preferXdgDirectories = true;

    # Wayland-first environment, renderers, and toolkit hints.
    sessionVariables = {
      DO_NOT_TRACK = true;

      # keep-sorted start
      MAGICK_OPENCL_DEVICE = "gpu";
      RUSTICL_ENABLE = "radeonsi";
      # keep-sorted end

      # keep-sorted start
      GDK_BACKEND = "wayland,x11,*";
      GDK_DEBUG = "portals";
      GDK_SCALE = 1;
      GSK_RENDERER = "vulkan";
      GTK_USE_PORTAL = 1;
      # keep-sorted end

      # keep-sorted start
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      # keep-sorted end

      # keep-sorted start
      CLUTTER_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      # keep-sorted end

      # keep-sorted start
      PROTON_NO_WM_DECORATION = 1;
      WINE_NO_WM_DECORATION = 1;
      # keep-sorted end

      NIXOS_OZONE_WL = 1;

      # keep-sorted start
      APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
      APP2UNIT_TYPE = "service";
      # keep-sorted end

      # keep-sorted start
      BIOME_CONFIG_PATH = "${configHome}/biome/biome.json";
      RUFF_CACHE_DIR = "${cacheHome}/ruff";
      # keep-sorted end
    };
    # keep-sorted end
  };
  # keep-sorted end
}
