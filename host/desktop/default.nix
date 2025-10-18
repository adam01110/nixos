{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  geoLongitude = config.sops.secrets."geoclue2_static/desktop/longitude";
  geoLatitude = config.sops.secrets."geoclue2_static/desktop/latitude";
  geoAltitude = config.sops.secrets."geoclue2_static/desktop/altitude";
in
{
  sops.secrets = {
    "geoclue2_static/desktop/longitude" = { };
    "geoclue2_static/desktop/latitude" = { };
    "geoclue2_static/desktop/altitude" = { };
  };

  imports = [ ./hardware.nix ];
  home-manager.users.${username}.imports = [ ./home.nix ];

  disko.selectedDisk = "/dev/nvme0n1";

  optServices = {
    geoclue2.static = {
      enable = true;

      longitude = geoLongitude;
      latitude = geoLatitude;
      altitude = geoAltitude;
    };
    timezone = "Europe/Amsterdam";
  };

  wooting.enable = true;
}
