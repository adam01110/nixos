{
  config,
  lib,
  ...
}:

let
  inherit (lib) optional;
in
{
  # noctalia top bar layout, density, and widget ordering.
  programs.noctalia-shell.settings.bar = {
    density = "compact";
    exclusive = true;
    floating = false;
    outerCorners = false;
    position = "top";
    showCapsule = true;

    widgets = {
      left = [
        {
          id = "SystemMonitor";
          showCpuTemp = true;
          showCpuUsage = true;
          showGpuTemp = true;
          showMemoryAsPercent = false;
          showMemoryUsage = true;
          showNetworkStats = false;
          usePrimaryColor = true;
        }
        { id = "plugin:privacy-indicator"; }
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
        }
      ];

      right = [
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
        {
          id = "Volume";
          displayMode = "onhover";
        }
        {
          id = "Microphone";
          displayMode = "onhover";
        }
        {
          id = "Brightness";
          displayMode = "onhover";
        }
      ]
      ++ [
        { id = "KeepAwake"; }
      ]
      ++ (optional config.noctalia.battery.enable { id = "Battery"; })
      ++ [
        {
          id = "NotificationHistory";
          hideWhenZero = true;
          showUnreadBadge = true;
        }
        {
          id = "Clock";
          formatHorizontal = "HH:mm yyyy-MM-dd";
          formatVertical = "HH mm - dd MM";
          useCustomFont = false;
          usePrimaryColor = true;
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
