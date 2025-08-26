{
  config,
  lib,
  pkgs,
  ...
}:

{
  hyprland.monitors = {
    "DP-2" = {
      resolution = "2560x1440@170";
      position = "0x0";
      scale = 1;
    };
    "DP-1" = {
      resolution = "1920x1080@144";
      position = "-1920x96";
      scale = 1;
      vrr = 0;
    };
  };

  sober.fps = 170;

  nvtop.types = [
    "amd"
    "intel"
  ];
}
