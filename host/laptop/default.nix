{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [ ./hardware.nix ];
  home-manager.users.${username}.imports = [ ./home.nix ];

  disko.selectedDisk = "/dev/nvme0n1";

  networking = {
    type = "networkmanager";
    hostName = "laptop";
  };

  optServices = {
    printing.enable = true;
    bluetooth.enable = true;
    fwupd.enable = true;
  };

  tmp.type = "zram";
}
