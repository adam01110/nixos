{vars, ...}:
# Per-host home manager overrides for the laptop.
let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    # Enable laptop-specific hyprland features.
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

    # Gpu monitoring for intel integrated graphics.
    nvtop.types = ["intel"];

    # Travel mode configuration for mobile usage.
    zen-browser = {
      travel.enable = true;
      commit-space = 13107;
    };

    # Enable laptop hardware features.
    noctalia.battery.enable = true;
    equibop.camera.enable = true;
  };
}
