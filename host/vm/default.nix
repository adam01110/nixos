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

  disko.selectedDisk = "/dev/vda";

  networking = {
    type = "networkd";
    interface = "enp1s0";
    hostName = "vm";
  };

  optServices.ssh.enable = true;

  tmp.type = "zram";
}
