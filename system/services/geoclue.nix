{config, ...}:
# Geoclue2 service using wifi positioning only.
{
  services.geoclue2 = {
    enable = true;

    # Use wi-fi positioning only when wi-fi is enabled in the system.
    enableWifi = config.optServices.wifi.enable;

    # Disable radio/serial backends to avoid unnecessary hardware usage.
    enableCDMA = false;
    enableModemGPS = false;
    enable3G = false;
    enableNmea = false;
  };
}
