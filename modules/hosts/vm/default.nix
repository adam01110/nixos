_: {
  networking.hostName = "vm";
  # System version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  # Virtual disk device for disko partitioning.
  disko.selectedDisk = "/dev/vda";

  # keep-sorted start block=yes newline_separated=yes
  # Vm-specific optional services.
  optServices = {
    # keep-sorted start
    ssh.enable = true;
    timezone = "automatic-timezoned";
    # keep-sorted end
  };

  # Enable vm guest services for better integration.
  services = {
    # keep-sorted start
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    # keep-sorted end
  };
  # keep-sorted end
}
