{
  osConfig,
  lib,
  pkgs,
  ...
}:
# install terminal wifi manager when wifi is enabled.
let
  inherit
    (lib)
    getExe'
    mkIf
    ;

  # tie enablement to the host wifi option.
  cfgWifi = osConfig.optServices.wifi.enable;
  pkg = pkgs.impala;
in
  mkIf cfgWifi {
    home.packages = [pkg];

    # create desktop entry to allow launching via launcher.
    xdg.desktopEntries.impala = {
      name = "Impala";
      genericName = "Terminal WiFi Manager";
      icon = "network-wireless";
      exec = getExe' pkg "impala";
      terminal = true;
      categories = [
        "Network"
        "Utility"
      ];
    };
  }
