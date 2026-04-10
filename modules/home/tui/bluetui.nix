{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}:
# Install terminal bluetooth manager when bluetooth is enabled.
let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    mkIf
    # keep-sorted end
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
        # keep-sorted start
        bluetui = getExe' pkg "bluetui";
        terminalCommand = getExe config.xdg.terminal-exec.package;
        # keep-sorted end
      in "${terminalCommand} --title=Bluetui ${bluetui}";

      categories = [
        # keep-sorted start
        "ConsoleOnly"
        "HardwareSettings"
        "Settings"
        # keep-sorted end
      ];
    };
  }
