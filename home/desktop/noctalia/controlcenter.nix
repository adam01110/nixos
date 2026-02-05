{
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optional;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
in {
  # Control center tiles and shortcuts surfaced from the bar.
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
        enabled = false;
      }
      {
        id = "brightness-card";
        enabled = false;
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
        [{id = "Network";}]
        ++ (optional cfgBluetooth {id = "Bluetooth";})
        ++ [
          {id = "plugin:screen-recorder";}
          {id = "WallpaperSelector";}
        ];
      right = [
        {id = "Notifications";}
        {id = "PowerProfile";}
        {id = "KeepAwake";}
      ];
    };
  };
}
