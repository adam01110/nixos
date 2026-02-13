{osConfig, ...}: let
  cfgWifi = osConfig.optServices.wifi.enable;
in {
  # Propagate host wifi/bluetooth availability into noctalia menus.
  programs.noctalia-shell.settings.network = {
    wifiEnabled = cfgWifi;
    bluetoothHideUnnamedDevices = true;
    bluetoothRssiPollingEnabled = true;
  };
}
