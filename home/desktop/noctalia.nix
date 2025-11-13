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
  # define an option to toggle battery widgets and services.
  options.noctalia.battery.enable = mkEnableOption "Enable the battery service & widgets.";

  # enable noctalia shell and set system integration.
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

      # configure all widget panels and behavior.
      settings = {
        # application launcher behavior and appearance.
        appLauncher = {
          enableClipboardHistory = true;
          terminalCommand = "${getExe config.programs.ghostty.package} -e";
          useApp2Unit = true;
        };

        # audio visualizer quality and type.
        audio = {
          visualizerQuality = "low";
          visualizerType = "mirrored";
        };

        # top bar density and widget layout.
        bar = {
          density = "compact";
          widgets = {
            # widgets aligned to the left side.
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
            # widgets centered in the bar.
            center = [
              {
                id = "Workspace";
                hideUnoccupied = true;
                labelMode = "none";
              }
            ];
            # widgets aligned to the right side.
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
            # quick toggle for keep awake.
            ++ [
              { id = "KeepAwake"; }
            ]
            # add battery widget when enabled.
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

        # enable ddcci for external monitor brightness control.
        brightness = {
          enableDdcSupport = true;
          enforceMinimum = false;
        };

        # do not generate templates for predefined schemes.
        colorschemes.generateTemplatesForPredefined = false;

        # control center placement and shortcuts.
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

        # auto hiding dock with proportional sizing.
        dock = {
          displayMode = "auto_hide";
          floatingRatio = 0.5;
          onlySameOutput = true;
          size = 0.5;
        };

        # global animation and scaling preferences.
        general = {
          animationSpeed = 2;
          dimDesktop = false;
          radiusRatio = 0.50;
          scaleRatio = 0.8;
          screenRadiusRatio = 0.5;
          shadowDirection = "center";
          showScreenCorners = true;
        };

        # locale and calendar behavior.
        location = {
          firstDayOfWeek = noctaliaFirstDayOfWeek;
          name = noctaliaLocation;
          showCalendarWeather = false;
          showWeekNumberInCalendar = true;
        };

        # initial state for radios.
        network = {
          wifiEnabled = cfgWifi;
          bluetoothEnabled = cfgBluetooth;
        };

        # screen recording defaults and destination.
        screenRecorder = {
          directory = "${videosDir}/Recordings";
          videoCodec = "hevc";
        };

        # fonts and ui scaling for noctalia panels.
        ui = {
          fontDefault = stylixFonts.default;
          fontDefaultScale = 0.9;
          fontFixed = stylixFonts.fixed;
          fontFixedScale = 0.9;
          panelsAttachedToBar = false;
        };

        # wallpaper directory and rotation interval.
        wallpaper = {
          directory = "${picturesDir}/Wallpapers";
          randomEnabled = true;
          randomIntervalSec = 14400;
          panelPosition = "center";
        };
      };
    };
}
