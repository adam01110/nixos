{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

let
  inherit (vars) username;
in
{
  networking.hostName = "desktop";

  imports = [ ./hardware.nix ];
  home-manager.users.${username}.imports = [ ./home.nix ];

  disko.selectedDisk = "/dev/nvme0n1";

  optServices = {
    geoclue2.static.enable = true;
    timezone = "Europe/Amsterdam";
  };

  hardware = {
    wooting.enable = true;
    roccat.enable = true;
  };
}
