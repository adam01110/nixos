{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfgWooting = config.wooting.enable;
in
{
  options.wooting.enable = lib.mkEnableOption "Enable the wooting udev rules";

  imports = [
    ./applications
    ./desktop
    ./services
    ./disk.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
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

  # enable realtimekit for pipewire
  security.rtkit.enable = true;

  hardware = {
    enableAllFirmware = true;
    wooting.enable = cfgWooting;
  };

  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tss
  ];
}
