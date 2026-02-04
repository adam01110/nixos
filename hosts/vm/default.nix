_:
# vm host profile: virtualized services and optional defaults.
{
  networking.hostName = "vm";
  # system version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  # virtual disk device for disko partitioning.
  disko.selectedDisk = "/dev/vda";

  # vm-specific optional services.
  optServices = {
    ssh.enable = true;
    timezone = "automatic-timezoned";
  };

  # enable vm guest services for better integration.
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
