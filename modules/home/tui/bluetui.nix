{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# Install terminal bluetooth manager when bluetooth is enabled.
let
  inherit
    (lib)
    getExe
    getExe'
    mkIf
    ;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  pkg = pkgs.bluetui;
in
  # Only install when bluetooth is enabled.
  mkIf cfgBluetooth {
    home.packages = [pkg];

    # Create desktop entry to allow launching via launcher.
    xdg.desktopEntries.bluetui = {
      name = "Bluetui";
      genericName = "Terminal Bluetooth Manager";
      icon = "bluetooth";
      exec = let
        terminalCommand = getExe config.xdg.terminal-exec.package;
        bluetui = getExe' pkg "bluetui";
      in "${terminalCommand} --title=Bluetui ${bluetui}";
      categories = [
        "Utility"
        "System"
        "Settings"
        "HardwareSettings"
      ];
    };
  }
