{ ... }:

# per-host home manager overrides for the desktop.
{
  # configure the hosts monitors.
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

  # show intel gpu stats in nvtop.
  nvtop.types = [ "intel" ];

  # extra zen profile tweaks when travelling.
  zen-browser = {
    travel.enable = true;
    commit-space = 13107;
  };

  # extra hardware toggles.
  noctalia.battery.enable = true;
  equibop.camera.enable = true;
}
