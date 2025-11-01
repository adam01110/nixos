{
  config,
  lib,
  pkgs,
  ...
}:

{
  hyprland = {
    brightness.enable = true;
    touch.enable = true;

    monitors = {
      eDP-1 = {
        resolution = "1920x1080@60";
        position = "0x0";
        scale = 1;
      };
      Unknown-1 = {
        disabled = 1;
      };
    };
  };

  nvtop.types = [ "intel" ];

  zen-browser = {
    travel.enable = true;
    commit-space = 13107;
  };

  noctalia.battery.enable = true;
  equibop.camera.enable = true;
}
