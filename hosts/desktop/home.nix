{ ... }:

# per-host home manager overrides for the desktop.
{
  # configure the hosts monitors.
  hyprland.monitors = {
    DP-2 = {
      resolution = "2560x1440@170";
      position = "0x0";
      scale = 1;
    };
    DP-1 = {
      resolution = "1920x1080@144";
      position = "-1920x96";
      scale = 1;
      vrr = 0;
    };
  };

  # gpu types in the system to install for nvtop.
  nvtop.types = [
    "amd"
    "intel"
  ];

  btop.gpuBackends = [ "rocm" ];

  zen-browser.commit-space = 25698;
  noctalia.enableGpu = true;
}
