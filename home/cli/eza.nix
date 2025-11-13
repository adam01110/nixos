{
  ezaStylix,
  ...
}:

# configure eza ls replacement.
{
  programs.eza = {
    enable = true;

    # enable icons, theme, and formatting.
    colors = "always";
    icons = "always";
    theme = ezaStylix;
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
