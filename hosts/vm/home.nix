{...}:
# per-host home manager overrides for the desktop.
{
  # configure the hosts monitors.
  hyprland.monitors."Virtual-1" = {
    resolution = "1920x1080@60";
    position = "0x0";
    scale = 1;
    vrr = 0;
  };

  zen-browser.commit-space = 6683;

  # enable the use of emulated gpus in zed.
  zed.isVm = true;
}
