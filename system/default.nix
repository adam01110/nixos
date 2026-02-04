# system-wide configuration entry point for nixos.
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    mkEnableOption
    mkForce
    mkIf
    ;
in {
  # custom option gate for roccat kain 100 mouse hardware quirks.
  options.hardware.roccat.enable = mkEnableOption "Enable the roccat libinput quirks";

  config = {
    # bootloader, kernel, and initrd configuration.
    boot = {
      # use cachyos kernel for performance optimizations.
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
      initrd = {
        # use numworks udev package for calculator.
        services.udev.packages = [pkgs.numworks-udev-rules];

        systemd.enable = true;
      };

      loader = {
        # skip bootloader timeout for faster boot.
        timeout = 0;

        # secure boot is handled via lanzaboote below.
        systemd-boot.enable = mkForce false;
        efi.canTouchEfiVariables = true;
      };

      lanzaboote = {
        enable = true;

        autoGenerateKeys.enable = true;
        autoEnrollKeys = {
          enable = true;
          autoReboot = true;
        };

        pkiBundle = "/var/lib/sbctl";
      };
    };

    # firmware, polkit, rtkit and other core security niceties.
    hardware.enableAllFirmware = true;

    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    programs = {
      # enable nix-ld to allow the use of dynamic libraries.
      nix-ld.enable = true;

      # enable support for appimages.
      appimage = {
        enable = true;
        binfmt = true;
      };
    };

    # use nftables; individual services will add rules if needed.
    networking.nftables.enable = true;

    environment = {
      # optional libinput quirk for specific roccat mouse.
      etc."libinput/local-overrides.quirks" = let
        name = "ROCCAT ROCCAT Kain 100";
      in
        mkIf config.hardware.roccat.enable {
          text = ''
            [${name}]
            MatchName=${name}
            ModelBouncingKeys=1
          '';
          mode = "0644";
          user = "root";
          group = "root";
        };

      # extra packages for lanzaboote.
      systemPackages = attrValues {
        inherit
          (pkgs)
          sbctl
          tpm2-tss
          ;
      };
    };
  };
}
