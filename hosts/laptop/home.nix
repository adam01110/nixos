{...}:
# per-host home manager overrides for the laptop.
{
  # enable laptop-specific hyprland features.
  hyprland = {
    brightness.enable = true;
    suspend.enable = true;
    touch.enable = true;

    monitors.eDP-1 = {
      resolution = "1920x1080@60";
      position = "0x0";
      scale = 1;
    };
  };

  # gpu monitoring for intel integrated graphics.
  nvtop.types = ["intel"];

  # travel mode configuration for mobile usage.
  zen-browser = {
    travel.enable = true;
    commit-space = 13107;
  };

  # enable laptop hardware features.
  noctalia.battery.enable = true;
  equibop.camera.enable = true;
}
