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
    ./slim.nix
    ./sops.nix
    ./tweaks.nix
    ./user.nix
  ];

  # custom option gate for roccat kain 100 mouse hardware quirks.
  options.hardware.roccat.enable = mkEnableOption "Enable the roccat libinput quirks";

  config = {
    # dont change.
    system.stateVersion = "25.05";

    # bootloader, kernel, and initrd configuration.
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos-lto;
      initrd = {
        services.udev.packages = [ pkgs.numworks-udev-rules ];

        systemd.enable = true;
      };

      loader = {
        timeout = 0;

        # secure boot is handled via lanzaboote below.
        systemd-boot.enable = mkForce false;
        efi.canTouchEfiVariables = true;
      };

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    # firmware, polkit, rtkit and other core security niceties.
    hardware.enableAllFirmware = true;

    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    # enable nix-ld to allow the use of dynamic libraries
    programs.nix-ld.enable = true;

    # use nftables; individual services will add rules if needed.
    networking.nftables.enable = true;

    environment = {
      # optional libinput quirk for specific roccat mouse.
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

      # extra packages for lanzaboote.
      systemPackages = attrValues {
        inherit (pkgs)
          sbctl
          tpm2-tss
          ;
      };
    };
  };
}
