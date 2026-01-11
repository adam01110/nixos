{vars, ...}:
# vm host profile: hardware, home manager imports, and optional services.
let
  inherit (vars) username;
in {
  networking.hostName = "vm";
  # system version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  # import vm-specific hardware configuration.
  imports = [./hardware.nix];
  home-manager.users.${username}.imports = [./home.nix];

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
