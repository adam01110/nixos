_:
# Vm host profile: virtualized services and optional defaults.
{
  networking.hostName = "vm";
  # System version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  # Virtual disk device for disko partitioning.
  disko.selectedDisk = "/dev/vda";

  # Vm-specific optional services.
  optServices = {
    ssh.enable = true;
    timezone = "automatic-timezoned";
  };

  # Enable vm guest services for better integration.
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
