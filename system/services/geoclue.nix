{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  enableWifi = osConfig.optServices.wifi.enable;
in
{
  services.geoclue2 = {
    enable = true;
    enableWifi = enableWifi;
    enableCDMA = false;
    enableModemGPS = false;
    enable3G = false;

    # TODO: static
    # enableStatic = ;
    # staticLongitude = ;
    # staticLatitude = ;
    # staticAltitude = ;
  };
}
