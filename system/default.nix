{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgWooting = config.wooting.enable;
  cfgRoccat = config.roccat.enable;
in
{
  options = {
    wooting.enable = mkEnableOption "Enable the wooting udev rules";
    roccat.enable = mkEnableOption "Enable the roccat libinput quirks";
  };

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

  system.stateVersion = "25.05";

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    # bootloader with secure boot
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    initrd.services.udev.packages = with pkgs; [ numworks-udev-rules ];
  };

  programs.nix-ld.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    wooting.enable = cfgWooting;
  };

  environment = mkif cfgRoccat {
    etc."libinput/local-overrides.quirks" = {
      text = ''
        [ROCCAT ROCCAT Kain 100]
        MatchName=ROCCAT ROCCAT Kain 100
        ModelBouncingKeys=1
      '';
      mode = "0644";
      user = "root";
      group = "root";
    };

    systemPackages = with pkgs; [
      sbctl
      tpm2-tss
    ];
  };
}
