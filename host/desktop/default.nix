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

  optServices = {
    geoclue2.static.enable = true;
    timezone = "Europe/Amsterdam";
  };

  wooting.enable = true;
  roccat.enable = true;
}
