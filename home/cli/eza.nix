_:
# Configure eza ls replacement.
{
  programs.eza = {
    enable = true;

    # Enable icons, theme, and formatting.
    colors = "always";
    icons = "always";
    extraOptions = [
      "--all"
      "--long"
      "--group-directories-first"
      "--mounts"
      "--time-style=long-iso"
    ];
  };
}
