{
  config,
  lib,
  pkgs,
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
      # groups for libvirt access.
      users.users.${username}.extraGroups = [
        "libvirtd"
        "kvm"
      ];

      # enable virt-manager UI.
      programs.virt-manager.enable = true;

      virtualisation.libvirtd = {
        # configure libvirtd with qemu swtpm.
        enable = true;
        qemu = {
          # allow the use of emulated tpm.
          swtpm.enable = true;

          # use qemu_kvm package to save disk space.
          package = pkgs.qemu_kvm;
        };

        # keep VMs off at boot.
        onBoot = "ignore";
      };

      # allow the default libvirt bridge and leave it unmanaged by NetworkManager.
      networking = {
        firewall.trustedInterfaces = [ "virbr0" ];
        networkmanager.unmanaged = [ "virbr0" ];
      };
    };
}
