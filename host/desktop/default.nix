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
    type = "networkd";
    interface = "";
    hostName = "desktop";
  };
}
