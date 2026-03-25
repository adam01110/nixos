{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
# Optional virt-manager install for libvirt management.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  inherit (vars) username;
in {
  options.optServices.virtManager.enable = mkEnableOption "Enable virt-manager for VMs.";

  config = let
    cfgVirtManager = config.optServices.virtManager.enable;
  in
    mkIf cfgVirtManager {
      # Groups for libvirt access.
      users.users.${username}.extraGroups = [
        "libvirtd"
        "kvm"
      ];

      # Enable virt-manager UI.
      programs.virt-manager.enable = true;

      virtualisation.libvirtd = {
        # Configure libvirtd with qemu swtpm.
        enable = true;
        qemu = {
          # Allow the use of emulated tpm.
          swtpm.enable = true;

          # Use qemu_kvm package to save disk space.
          package = pkgs.qemu_kvm;
        };

        # Keep VMs off at boot.
        onBoot = "ignore";
      };

      # Allow the default libvirt bridge and leave it unmanaged by NetworkManager.
      networking = {
        firewall.trustedInterfaces = ["virbr0"];
        networkmanager.unmanaged = ["virbr0"];
      };
    };
}
