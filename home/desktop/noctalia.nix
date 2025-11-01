{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  noctaliaStylix,
  ...
}:

let
  inherit (lib)
    getExe
    mkEnableOption
    optionals
    ;

  stylixColors = noctaliaStylix.colors;
  stylixFonts = noctaliaStylix.fonts;

  monitorNames = builtins.attrNames config.hyprland.monitors;
  cfg = osConfig.services.noctalia-shell;
in
{
  options.noctalia.battery.enable = mkEnableOption "Enable the battery service & widgets.";

  config = {
    programs.noctalia-shell =
      let
        cfgBluetooth = osConfig.optServices.bluetooth.enable;
        cfgWifi = osConfig.optServices.wifi.enable;
      in
      {
        enable = true;

        package = inputs.noctalia.packages.${system}.default;
        app2unit.package = pkgs.app2unit;

        settings = {
          colors = stylixColors;

          appLauncher = {
            backgroundOpacity = 0.95;
            enableClipboardHistory = true;
            terminalCommand = "${getExe pkgs.ghostty} -e";
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
                  icon = "moon-stars";
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

          ui = {
            fontDefault = stylixFonts.default;
            fontDefaultScale = 0.9;
            fontFixed = stylixFonts.fixed;
            fontFixedScale = 0.9;
            panelsAttachedToBar = false;
          };
        };
      };

    systemd.user.services.noctalia-shell = {
      Unit = {
        Description = "Noctalia Shell - Wayland desktop shell";
        Documentation = "https://github.com/noctalia-dev/noctalia-shell";
        After = [ cfg.target ];
        PartOf = [ cfg.target ];
        StartLimitIntervalSec = 60;
        StartLimitBurst = 3;
      };

      Service = {
        ExecStart = "${cfg.package}/bin/noctalia-shell";
        Restart = "on-failure";
        RestartSec = 3;
        TimeoutStartSec = 10;
        TimeoutStopSec = 5;
        Environment = [
          "PATH="
          "NOCTALIA_SETTINGS_FALLBACK=%h/.config/noctalia/gui-settings.json"
        ];
      };

      Install = {
        WantedBy = [ cfg.target ];
      };
    };
  };
}
