_:
# Configure eza ls replacement.
{
  programs.eza = {
    enable = true;

    # Enable icons, theme, and formatting.
    colors = "always";
    icons = "always";
    extraOptions = [
      # keep-sorted start
      "--all"
      "--group-directories-first"
      "--long"
      "--mounts"
      "--time-style=long-iso"
      # keep-sorted end
    ];
  };
}
