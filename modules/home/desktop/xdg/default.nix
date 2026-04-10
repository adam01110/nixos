# Xdg desktop integration and mime type configuration module.
_: {
  # Manage xdg userdirs and auto-create missing paths.
  xdg = {
    # Enable xdg integration.
    enable = true;

    userDirs = {
      enable = true;

      # keep-sorted start
      createDirectories = true;
      setSessionVariables = true;
      # keep-sorted end
    };
  };

  # Enable gnome polkit for graphical authentication prompts.
  services.polkit-gnome.enable = true;
}
