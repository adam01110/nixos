{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.eza = {
    enable = true;

    colors = "always";
    icons = "always";
    extraOptions = [
      "--all"
      "--long"
      "--group-directories-first"
      "--mounts"
      "--context"
      "--time-style +%Y-%m-%d %H:%M"
    ];
  };
}
