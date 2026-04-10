{vars, ...}:
# Per-host home manager overrides for the desktop.
let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    # keep-sorted start block=yes newline_separated=yes
    # Enable rocm gpu backend for system monitoring.
    btop.gpuBackends = ["rocm"];

    # Configure dual monitor setup.
    hyprland.monitors = {
      # keep-sorted start block=yes numeric=yes newline_separated=yes
      DP-1 = {
        resolution = "1920x1080@144";
        position = "-1920x96";
        scale = 1;
        vrr = 0;
      };

      DP-2 = {
        resolution = "2560x1440@170";
        position = "0x0";
        scale = 1;
      };
      # keep-sorted end
    };

    noctalia = {
      # keep-sorted start newline_separated=yes
      # Enable gpu acceleration for noctalia.
      enableGpu = true;

      # Keep the desktop weather location in sops.
      location = "sops";
      # keep-sorted end
    };

    # Gpu monitoring support for multi-gpu desktop.
    nvtop.types = [
      # keep-sorted start
      "amd"
      "intel"
      # keep-sorted end
    ];

    # Browser memory allocation for desktop usage.
    zen-browser.commit-space = 25698;
    # keep-sorted end
  };
}
