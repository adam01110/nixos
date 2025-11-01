{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.preferXdgDirectories = true;

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  home.sessionVariables = {
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

    APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
  };

  dconf.settings."/org/gnome/desktop/wm/preferences".button-layout = "";
}
