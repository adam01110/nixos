# Xdg desktop integration and mime type configuration module.
_: {
  # Enable xdg integration.
  xdg.enable = true;

  # Manage xdg userdirs and auto-create missing paths.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Enable gnome polkit for graphical authentication prompts.
  services.polkit-gnome.enable = true;
}
