{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkForce
    mkIf
    ;
in
{
  imports = [
    ./applications
    ./desktop
    ./services
    ./disk.nix
    ./locale.nix
    ./nix.nix
    ./oxidize.nix
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

      # bootloader with secure boot
      loader = {
        systemd-boot.enable = mkForce false;
        efi.canTouchEfiVariables = true;
      };

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    programs.nix-ld.enable = true;
    hardware.enableAllFirmware = true;

    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    environment = {
      etc."libinput/local-overrides.quirks" =
        let
          cfgRoccat = config.hardware.roccat.enable;
        in
        mkIf cfgRoccat {
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
      systemPackages = builtins.attrValues {
        inherit (pkgs)
          sbctl
          tpm2-tss
          ;
      };
    };
  };
}
