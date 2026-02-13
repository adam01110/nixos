{
  config,
  osConfig,
  lib,
  ...
}:
# Noctalia top bar.
let
  inherit (lib) optional;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
in {
  programs.noctalia-shell.settings.bar = {
    density = "compact";
    floating = false;
    outerCorners = false;
    position = "top";
    showCapsule = true;
    useSeparateOpacity = true;
    backgroundOpacity = 1;

    widgets = {
      left = [
        {
          id = "SystemMonitor";
          showCpuFreq = true;
          showCpuTemp = true;
          showCpuUsage = true;
          showGpuTemp = config.noctalia.enableGpu;
          showMemoryAsPercent = false;
          showMemoryUsage = true;
          showNetworkStats = false;
          showSwapUsage = true;
        }
        {id = "plugin:privacy-indicator";}
        {
          id = "LockKeys";
          capsLockIcon = "circle-dashed-letter-c";
          numLockIcon = "circle-dotted-letter-n";
          scrollLockIcon = "circle-dotted-letter-s";
          showCapsLock = true;
          showNumLock = false;
          showScrollLock = false;
        }
        {
          id = "ActiveWindow";
          colorizeIcons = false;
          hideMode = "hidden";
          maxWidth = 145;
          scrollingMode = "hover";
          showIcon = true;
          useFixedWidth = false;
        }
        {
          id = "MediaMini";
          hideMode = "hidden";
          hideWhenIdle = false;
          maxWidth = 145;
          scrollingMode = "hover";
          showAlbumArt = true;
          showVisualizer = false;
          useFixedWidth = false;
          visualizerType = "linear";
        }
      ];

      center = [
        {
          id = "Workspace";
          hideUnoccupied = true;
          labelMode = "none";
          followFocusedScreen = true;
        }
      ];

      right = let
        wiremix = config.xdg.desktopEntries.wiremix.exec;
      in
        [
          {
            id = "Tray";
            colorizeIcons = false;
            drawerEnabled = true;
            pinned = [
              "Equibop"
              "Beeper"
              "spotify-client"
              "steam"
            ];
          }
          {
            id = "VPN";
            displayMode = "onhover";
          }
          {id = "NoctaliaPerformance";}
          {
            id = "Volume";
            displayMode = "onhover";
            middleClickCommand = wiremix;
          }
          {
            id = "Microphone";
            displayMode = "onhover";
            middleClickCommand = wiremix;
          }
        ]
        ++ (optional cfgBluetooth {id = "Bluetooth";})
        ++ [
          {id = "Network";}
          {
            id = "Brightness";
            displayMode = "onhover";
          }
        ]
        ++ [
          {id = "KeepAwake";}
        ]
        # Show the battery widget when enabled.
        ++ (optional config.noctalia.battery.enable {
          id = "Battery";
          showPowerProfiles = true;
          DisplayMode = "icon-hover";
        })
        ++ [
          {id = "plugin:github-feed";}
          {
            id = "NotificationHistory";
            showUnreadBadge = true;
          }
          {
            id = "Clock";
            formatHorizontal = "yyyy-MM-dd HH:mm";
            formatVertical = "HH mm - dd MM";
            tooltipFormat = "ddd, MMM dd HH:mm";
            useCustomFont = false;
            clockColor = "primary";
          }
          {
            id = "ControlCenter";
            colorizeSystemIcon = "tertiary";
            enableColorization = true;
            useDistroLogo = true;
          }
        ];
    };
  };
}
