_:
# desktop host profile: optional services and hardware tweaks.
{
  # system version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  networking.hostName = "desktop";

  # primary nvme disk for disko partitioning.
  disko.selectedDisk = "/dev/nvme0n1";

  # desktop-specific optional services.
  optServices.timezone = "Europe/Amsterdam";

  # enable specialized hardware support.
  hardware = {
    wooting.enable = true;
    roccat.enable = true;
  };

  # enable amd rocm support for gpu.
  nixpkgs.config.rocmSupport = true;
}
