_: {
  # System version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  networking.hostName = "desktop";

  # Primary nvme disk for disko partitioning.
  disko.selectedDisk = "/dev/nvme0n1";

  # keep-sorted start block=yes newline_separated=yes
  # Enable specialized hardware support.
  hardware = {
    # keep-sorted start
    roccat.enable = true;
    wooting.enable = true;
    # keep-sorted end
  };

  # Enable amd rocm support for gpu.
  nixpkgs.config.rocmSupport = true;

  # Desktop-specific optional services.
  optServices.timezone = "Europe/Amsterdam";
  # keep-sorted end
}
