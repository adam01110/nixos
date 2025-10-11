{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./applications
    ./desktop
    ./services
    ./disk.nix
    ./nix.nix
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

    # udev rules for numworks calculator
    initrd.services.udev.packages = with pkgs; [ numworks-udev-rules ];
  };

  programs.nix-ld.enable = true;

  # enable realtimekit for pipewire
  security.rtkit.enable = true;

  # enable mesa-git
  chaotic.mesa-git.enable = true;

  hardware.enableAllFirmware = true;

  # locale.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tss
  ];
}
