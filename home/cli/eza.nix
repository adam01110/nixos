{ ... }:

# configure eza ls replacement.
{
  programs.eza = {
    enable = true;

    # enable icons, theme, and formatting.
    colors = "always";
    icons = "always";
    extraOptions = [
      "--all"
      "--long"
      "--group-directories-first"
      "--mounts"
      "--context"
      "--time-style=long-iso"
    ];
  };
}
