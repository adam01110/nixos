# xdg desktop integration and mime type configuration module.
_: {
  # enable xdg integration.
  xdg.enable = true;

  # manage xdg userdirs and auto-create missing paths.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # enable gnome polkit for graphical authentication prompts.
  services.polkit-gnome.enable = true;
}
