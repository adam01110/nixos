{
  osConfig,
  lib,
  pkgs,
  ...
}:
# install terminal bluetooth manager when bluetooth is enabled.
let
  inherit (lib) optional;
  cfgBluetooth = osConfig.optServices.bluetooth.enable;
in {
  home.packages = optional cfgBluetooth pkgs.bluetui;
}
