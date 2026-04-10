{
  # keep-sorted start
  lib,
  osConfig,
  # keep-sorted end
  ...
}: let
  inherit (lib) optional;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  cfgWifi = osConfig.optServices.wifi.enable;
in {
  # Control center tiles and shortcuts surfaced from the bar.
  programs.noctalia-shell.settings.controlCenter = {
    # keep-sorted start block=yes newline_separated=yes
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

    position = "close_to_bar_button";

    shortcuts = {
      left =
        [{id = "Network";}]
        ++ (optional cfgBluetooth {id = "Bluetooth";})
        ++ [
          {id = "plugin:screen-recorder";}
          {id = "WallpaperSelector";}
        ];
      right =
        [
          {id = "Notifications";}
          {id = "PowerProfile";}
          {id = "KeepAwake";}
        ]
        ++ (optional cfgWifi {id = "AirplaneMode";});
    };
    # keep-sorted end
  };
}
