{
  config,
  lib,
  pkgs,
  ...
}:

{
  hyprland.monitors."Virtual-1" = {
    resolution = "1920x1080@144";
    position = "0x0";
    scale = 1;
    vrr = 0;
  };

  zen-browser.commit-space = 6683;
}
