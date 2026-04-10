{osConfig, ...}: let
  cfgWifi = osConfig.optServices.wifi.enable;
in {
  # Propagate host wifi/bluetooth availability into noctalia menus.
  programs.noctalia-shell.settings.network = {
    # keep-sorted start
    bluetoothAutoConnect = false;
    bluetoothHideUnnamedDevices = true;
    bluetoothRssiPollingEnabled = true;
    wifiEnabled = cfgWifi;
    # keep-sorted end
  };
}
