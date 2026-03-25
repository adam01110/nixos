{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# Install terminal wifi manager when wifi is enabled.
let
  inherit
    (lib)
    getExe
    getExe'
    mkIf
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
        terminalCommand = getExe config.xdg.terminal-exec.package;
        impala = getExe' pkg "impala";
      in "${terminalCommand} --title=Impala ${impala}";
      categories = [
        "Network"
        "Utility"
      ];
    };
  }
