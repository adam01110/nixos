{
  config,
  lib,
  pkgs,
  timezone,
  ...
}:

{
  imports = [
    ./applications
    ./desktop
    ./disk.nix
    ./network.nix
    ./nix.nix
    ./services.nix
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

  # enable realtimekit for pipewire
  security.rtkit.enable = true;

  time.timeZone = timezone;

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

  # enable sudo-rs in the future.
  # breaks starship.
  security = {
    sudo.enable = true;
    sudo-rs = {
      enable = false;
      execWheelOnly = true;
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tss
  ];
}
