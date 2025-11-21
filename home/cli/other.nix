{
  osConfig,
  lib,
  pkgs,
  ...
}:

# install additional utilities.
let
  inherit (builtins) attrValues;
  inherit (lib) optional;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  cfgWifi = osConfig.optServices.wifi.enable;
in
{
  home.packages =
    attrValues {
      inherit (pkgs)
        gitfetch
        speedtest-go
        tokei
        wiremix
        ;
    }
    ++ optional cfgWifi pkgs.impala
    ++ optional cfgBluetooth pkgs.bluetui;

  programs = {
    ripgrep.enable = true;
    nix-index.enable = true;
  };
}
