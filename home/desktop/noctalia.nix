{
  config,
  osConfig,
  lib,
  pkgs,
  username,
  ...
}:

with lib;
let
  ghostty = "${getExe pkgs.ghostty}";

  enableWifi = osConfig.optServices.wifi.enable;
  enableBluetooth = config.noctalia.bluetooth.enable;
  enableBattery = config.noctalia.battery.enable;

  hyprMonitors = config.hyprland.monitors;
  monitorNames = builtins.attrNames hyprMonitors;

  monitorsScaling = map (n: {
    name = n;
    scale = if (hyprMonitors.${n} ? scale) then hyprMonitors.${n}.scale else 1.0;
  }) monitorNames;
in
{
  options.noctalia = {
    bluetooth.enable = mkEnableOption "Enable the bluetooth service & widgets.";
    wifi.enable = mkEnableOption "Enable the wifi service & widgets.";
    battery.enable = mkEnableOption "Enable the battery service & widgets.";
  };

  programs.noctalia-shell = {
    enable = true;

    settings = {
      appLauncher = {
        backgroundOpacity = 0.95;
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
            {
              id = "Brightness";
              displayMode = "onhover";
            }
          ]
          ++ (optionals enableWifi [ { id = "WiFi"; } ])
          ++ (optionals enableBluetooth [ { id = "Bluetooth"; } ])
          ++ [
            { id = "KeepAwake"; }
          ]
          ++ (optionals enableBattery [ { id = "Battery"; } ])
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
              icon = "";
              useDistroLogo = false;
            }
          ];
        };
      };

      colorschemes.generateTemplatesForPredefined = false;

      dock = {
        displayMode = "auto_hide";
        floatingRatio = 0.5;
        onlySameOutput = true;
        monitors = monitorNames;
      };

      general = {
        animationSpeed = 2;
        dimDesktop = false;
        radiusRatio = 0.50;
        screenRadiusRatio = 0.5;
        showScreenCorners = true;
      };

      location = {
        # TODO: name = "location";
        showWeekNumberInCalendar = true;
      };

      network = {
        wifiEnabled = enableWifi;
        bluetoothEnabled = enableBluetooth;
      };

      screenRecorder.videoCodec = "hevc";
    };

    ui.monitorsScaling = monitorsScaling;
  };
}
