{osConfig, ...}: let
  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  cfgWifi = osConfig.optServices.wifi.enable;
in {
  # Propagate host wifi/bluetooth availability into noctalia menus.
  programs.noctalia-shell.settings.network = {
    wifiEnabled = cfgWifi;
    bluetoothEnabled = cfgBluetooth;
    bluetoothHideUnnamedDevices = true;
    bluetoothRssiPollingEnabled = true;
  };
}
