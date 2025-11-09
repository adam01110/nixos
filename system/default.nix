{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (builtins) attrValues;
  inherit (lib)
    mkEnableOption
    mkForce
    mkIf
    ;
in
{
  imports = [
    ./applications
    ./cli
    ./desktop
    ./services
    ./disk.nix
    ./locale.nix
    ./nix.nix
    ./oxidize.nix
    ./slim.nix
    ./sops.nix
    ./tweaks.nix
    ./user.nix
  ];

  options.hardware.roccat.enable = mkEnableOption "Enable the roccat libinput quirks";

  config = {
    system.stateVersion = "25.05";

    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos;
      initrd.services.udev.packages = [ pkgs.numworks-udev-rules ];

      loader = {
        timeout = 0;

        # bootloader with secure boot
        systemd-boot.enable = mkForce false;
        efi.canTouchEfiVariables = true;
      };

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    hardware.enableAllFirmware = true;

    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    networking.nftables.enable = true;

    environment = {
      etc."libinput/local-overrides.quirks" = mkIf config.hardware.roccat.enable {
        text = ''
          [ROCCAT ROCCAT Kain 100]
          MatchName=ROCCAT ROCCAT Kain 100
          ModelBouncingKeys=1
        '';
        mode = "0644";
        user = "root";
        group = "root";
      };

      # extra packages for secure boot and tpm luks
      systemPackages = attrValues {
        inherit (pkgs)
          sbctl
          tpm2-tss
          ;
      };
    };
  };
}
