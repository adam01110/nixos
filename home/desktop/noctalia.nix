{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  vars,
  noctaliaStylix,
  ...
}:

let
  inherit (lib)
    getExe
    mkEnableOption
    optionals
    ;
  inherit (vars) noctaliaLocation noctaliaFirstDayOfWeek;

  stylixFonts = noctaliaStylix.fonts;

  picturesDir = config.xdg.userDirs.pictures;
  videosDir = config.xdg.userDirs.videos;
in
{
  options.noctalia.battery.enable = mkEnableOption "Enable the battery service & widgets.";

  config.programs.noctalia-shell =
    let
      cfgBluetooth = osConfig.optServices.bluetooth.enable;
      cfgWifi = osConfig.optServices.wifi.enable;
    in
    {
      enable = true;
      systemd.enable = true;

      package = inputs.noctalia.packages.${system}.default;
      app2unit.package = pkgs.app2unit;

      settings = {
        appLauncher = {
          backgroundOpacity = 0.95;
          enableClipboardHistory = true;
          terminalCommand = "${getExe config.programs.ghostty.package} -e";
          useApp2Unit = true;
        };

        audio = {
          visualizerQuality = "low";
          visualizerType = "mirrored";
        };

        bar = {
          density = "compact";
          widgets = {
            left = [
              {
                id = "SystemMonitor";
                showCpuTemp = true;
                showCpuUsage = true;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                usePrimaryColor = true;
              }
              {
                id = "LockKeys";
                indicatorStyle = "circle-dash";
                showNumLock = false;
                showScrollLock = false;
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
              {
                id = "Tray";
                favorites = [
                  "Equibop"
                  "Beeper"
                ];
              }
              { id = "Volume"; }
              { id = "Microphone"; }
              {
                id = "Brightness";
                displayMode = "onhover";
              }
            ]
            ++ [
              { id = "KeepAwake"; }
            ]
            ++ (optionals config.noctalia.battery.enable [ { id = "Battery"; } ])
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
                colorizeDistroLogo = true;
                useDistroLogo = true;
              }
            ];
          };
        };

        brightness = {
          enableDdcSupport = true;
          enforceMinimum = false;
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
          size = 0.5;
        };

        general = {
          animationSpeed = 2;
          dimDesktop = false;
          radiusRatio = 0.50;
          scaleRatio = 0.8;
          screenRadiusRatio = 0.5;
          shadowDirection = "center";
          showScreenCorners = true;
        };

        location = {
          firstDayOfWeek = noctaliaFirstDayOfWeek;
          name = noctaliaLocation;
          showCalendarWeather = false;
          showWeekNumberInCalendar = true;
        };

        network = {
          wifiEnabled = cfgWifi;
          bluetoothEnabled = cfgBluetooth;
        };

        screenRecorder = {
          directory = "${videosDir}/Recordings";
          videoCodec = "hevc";
        };

        ui = {
          fontDefault = stylixFonts.default;
          fontDefaultScale = 0.9;
          fontFixed = stylixFonts.fixed;
          fontFixedScale = 0.9;
          panelsAttachedToBar = false;
        };

        wallpaper = {
          directory = "${picturesDir}/Wallpapers";
          randomEnabled = true;
          randomIntervalSec = 14400;
          panelPosition = "center";
        };
      };
    };
}
