{...}:
# per-host home manager overrides for the desktop.
{
  # configure dual monitor setup.
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

  # gpu monitoring support for multi-gpu desktop.
  nvtop.types = [
    "amd"
    "intel"
  ];

  # enable rocm gpu backend for system monitoring.
  btop.gpuBackends = ["rocm"];

  # browser memory allocation for desktop usage.
  zen-browser.commit-space = 25698;

  # enable gpu acceleration for noctalia.
  noctalia.enableGpu = true;
}
