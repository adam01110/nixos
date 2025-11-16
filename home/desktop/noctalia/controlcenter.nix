{
  osConfig,
  lib,
  ...
}:

let
  inherit (lib) optionals;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  cfgWifi = osConfig.optServices.wifi.enable;
in
{
  # control center tiles and shortcuts surfaced from the bar.
  programs.noctalia-shell.settings.controlCenter = {
    position = "close_to_bar_button";

    cards = [
      {
        id = "profile-card";
        enabled = true;
      }
      {
        id = "shortcuts-card";
        enabled = true;
      }
      {
        id = "audio-card";
        enabled = true;
      }
      {
        id = "weather-card";
        enabled = true;
      }
      {
        id = "media-sysmon-card";
        enabled = true;
      }
    ];

    shortcuts = {
      left =
        (optionals cfgWifi [ { id = "WiFi"; } ])
        ++ (optionals cfgBluetooth [ { id = "Bluetooth"; } ])
        ++ [
          { id = "ScreenRecorder"; }
          { id = "WallpaperSelector"; }
        ];
      right = [
        { id = "Notifications"; }
        { id = "PowerProfile"; }
        { id = "KeepAwake"; }
      ];
    };
  };
}
