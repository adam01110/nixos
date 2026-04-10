{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    # keep-sorted start block=yes newline_separated=yes
    # Enable laptop hardware features.
    equibop.camera.enable = true;

    # Enable laptop-specific hyprland features.
    hyprland = {
      # keep-sorted start block=yes newline_separated=yes
      monitors.eDP-1 = {
        resolution = "1920x1080@60";
        position = "0x0";
        scale = 1;
      };

      touch.enable = true;
      # keep-sorted end
    };

    # Enable laptop-specific noctalia features.
    noctalia = {
      battery.enable = true;
      idle = {
        # keep-sorted start
        brightness.enable = true;
        suspend.enable = true;
        # keep-sorted end
      };
    };

    # Gpu monitoring for intel integrated graphics.
    nvtop.types = ["intel"];

    # Travel mode configuration for mobile usage.
    zen-browser = {
      # keep-sorted start
      commit-space = 13107;
      travel.enable = true;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
