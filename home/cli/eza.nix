{
  ezaStylix,
  ...
}:

{
  programs.eza = {
    enable = true;

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
