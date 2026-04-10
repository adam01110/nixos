{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}:
# Install terminal wifi manager when wifi is enabled.
let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    mkIf
    # keep-sorted end
    ;

  cfgWifi = osConfig.optServices.wifi.enable;
  pkg = pkgs.impala;
in
  # Only install when wifi is enabled to avoid unnecessary packages on desktops.
  mkIf cfgWifi {
    home.packages = [pkg];

    # Create desktop entry to allow launching via launcher.
    xdg.desktopEntries.impala = {
      name = "Impala";
      genericName = "Terminal WiFi Manager";
      icon = "network-wireless";

      exec = let
        # keep-sorted start
        impala = getExe' pkg "impala";
        terminalCommand = getExe config.xdg.terminal-exec.package;
        # keep-sorted end
      in "${terminalCommand} --title=Impala ${impala}";

      categories = [
        # keep-sorted start
        "ConsoleOnly"
        "Network"
        # keep-sorted end
      ];
    };
  }
