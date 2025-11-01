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
  networking.hostName = "vm";

  imports = [ ./hardware.nix ];
  home-manager.users.${username}.imports = [ ./home.nix ];

  disko.selectedDisk = "/dev/vda";

  optServices = {
    ssh.enable = true;
    timezone = "automatic-timezoned";
  };
}
