{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    bpftune.enable = true;
    envfs.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
