{vars, ...}:
# laptop host profile: hardware, home manager imports, and optional services.
let
  inherit (vars) username;
in {
  networking.hostName = "vm";
  # dont change.
  system.stateVersion = "25.05";

  # import vm hardware profile.
  imports = [./hardware.nix];
  home-manager.users.${username}.imports = [./home.nix];

  # vm disk device for disko.
  disko.selectedDisk = "/dev/vda";

  # per-host optional services and settings.
  optServices = {
    ssh.enable = true;
    timezone = "automatic-timezoned";
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
