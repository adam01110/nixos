{
  config,
  lib,
  vars,
  ...
}:

# optional virt-manager install for libvirt management.
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  inherit (vars) username;
in
{
  options.optServices.virtManager.enable = mkEnableOption "Enable virt-manager for VMs.";

  config =
    let
      cfgVirtManager = config.optServices.virtManager.enable;
    in
    mkIf cfgVirtManager {
      users.users.${username}.extraGroups = [ "libvirtd" ];

      programs.virt-manager.enable = true;

      virtualisation.libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
    };
}
