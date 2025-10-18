{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgWifi = config.optServices.wifi.enable;
  cfgStatic = config.optServices.geoclue2.static.enable;

  cfgLongitude = config.optServices.geoclue2.static.longitude;
  cfgLatitude = config.optServices.geoclue2.static.latitude;
  cfgAltitude = config.optServices.geoclue2.static.altitude;
in
{
  options.optServices.geoclue2.static = {
    enable = mkEnableOption "Enable geoclue2 static location services.";

    longitude = mkOption {
      type = types.float;
      description = "Static longitude coordinate";
    };

    latitude = mkOption {
      type = types.float;
      description = "Static latitude coordinate";
    };

    altitude = mkOption {
      type = types.either types.float types.int;
      description = "Static altitude coordinate";
    };
  };

  services.geoclue2 = {
    enable = !cfgStatic;
    enableWifi = cfgWifi;
    enableCDMA = false;
    enableModemGPS = false;
    enable3G = false;

    enableStatic = cfgStatic;
    staticLongitude = cfgLongitude;
    staticLatitude = cfgLatitude;
    staticAltitude = cfgAltitude;
  };
}
