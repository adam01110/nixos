_: {
  # Create missing user dirs and export their session variables.
  xdg = {
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
