_:
# Desktop host profile: optional services and hardware tweaks.
{
  # System version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  networking.hostName = "desktop";

  # Primary nvme disk for disko partitioning.
  disko.selectedDisk = "/dev/nvme0n1";

  # Desktop-specific optional services.
  optServices.timezone = "Europe/Amsterdam";

  # Enable specialized hardware support.
  hardware = {
    wooting.enable = true;
    roccat.enable = true;
  };

  # Enable amd rocm support for gpu.
  nixpkgs.config.rocmSupport = true;
}
