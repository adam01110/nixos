{config, ...}: {
  services.geoclue2 = {
    enable = true;

    # Use wi-fi positioning only when wi-fi is enabled in the system.
    enableWifi = config.optServices.wifi.enable;

    # Disable radio/serial backends to avoid unnecessary hardware usage.
    # keep-sorted start
    enable3G = false;
    enableCDMA = false;
    enableModemGPS = false;
    enableNmea = false;
    # keep-sorted end
  };
}
