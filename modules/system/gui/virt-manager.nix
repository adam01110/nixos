{
  # keep-sorted start
  config,
  lib,
  pkgs,
  vars,
  # keep-sorted end
  ...
}:
# Optional virt-manager install for libvirt management.
let
  inherit
    (lib)
    # keep-sorted start
    mkEnableOption
    mkIf
    # keep-sorted end
    ;
  inherit (vars) username;
in {
  options.optServices.virtManager.enable = mkEnableOption "Enable virt-manager for VMs.";

  config = let
    cfgVirtManager = config.optServices.virtManager.enable;
  in
    mkIf cfgVirtManager {
      # keep-sorted start block=yes newline_separated=yes
      # Enable virt-manager UI.
      programs.virt-manager.enable = true;

      # Groups for libvirt access.
      users.users.${username}.extraGroups = [
        # keep-sorted start
        "kvm"
        "libvirtd"
        # keep-sorted end
      ];

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
      # keep-sorted end

      # Allow the default libvirt bridge and leave it unmanaged by NetworkManager.
      networking = let
        interface = ["virbr0"];
      in {
        # keep-sorted start
        firewall.trustedInterfaces = interface;
        networkmanager.unmanaged = interface;
        # keep-sorted end
      };
    };
}
