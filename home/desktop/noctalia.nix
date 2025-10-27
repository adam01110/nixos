{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    getExe
    mkEnableOption
    optionals
    ;

  ghostty = getExe pkgs.ghostty;

  cfgBattery = config.noctalia.battery.enable;
  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  cfgWifi = osConfig.optServices.wifi.enable;

  monitorNames = builtins.attrNames config.hyprland.monitors;
in
{
  options.noctalia.battery.enable = mkEnableOption "Enable the battery service & widgets.";

  config.programs.noctalia-shell = {
    enable = true;

    settings = {
      appLauncher = {
        backgroundOpacity = 0.95;
        enableClipboardHistory = true;
        terminalCommand = "${ghostty} -e";
        useApp2Unit = true;
      };

      bar = {
        widgets = {
          left = [
            {
              id = "SystemMonitor";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = true;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
            }
            {
              id = "ActiveWindow";
              autoHide = true;
              scrollingMode = "hover";
              showIcon = true;
            }
            {
              id = "MediaMini";
              autoHide = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showVisualizer = false;
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
            { id = "Tray"; }
            { id = "Microphone"; }
            { id = "Volume"; }
            {
              id = "Brightness";
              displayMode = "onhover";
            }
          ]
          ++ [
            { id = "KeepAwake"; }
          ]
          ++ (optionals cfgBattery [ { id = "Battery"; } ])
          ++ [
            {
              id = "NotificationHistory";
              hideWhenZero = true;
              showUnreadBadge = true;
            }
            {
              id = "Clock";
              customFont = "";
              formatHorizontal = "HH:mm yyyy-MM-dd";
              formatVertical = "HH mm - dd MM";
              useCustomFont = false;
              usePrimaryColor = true;
            }
            {
              id = "ControlCenter";
              customIconPath = "";
              # Todo: icon
              # icon = "";
              useDistroLogo = false;
            }
          ];
        };
      };

      colorschemes.generateTemplatesForPredefined = false;

      controlCenter = {
        position = "close_to_bar_button";
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

      dock = {
        displayMode = "auto_hide";
        floatingRatio = 0.5;
        onlySameOutput = true;
        monitors = monitorNames;
        size = 0.5;
      };

      general = {
        animationSpeed = 2;
        compactLockScreen = true;
        dimDesktop = false;
        radiusRatio = 0.50;
        scaleRatio = 0.8;
        screenRadiusRatio = 0.5;
        showScreenCorners = true;
      };

      location.showWeekNumberInCalendar = true;

      network = {
        wifiEnabled = cfgWifi;
        bluetoothEnabled = cfgBluetooth;
      };

      screenRecorder.videoCodec = "hevc";
    };
  };
}
