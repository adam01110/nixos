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
  # only install when bluetooth is enabled.
  home.packages = optional cfgBluetooth pkgs.bluetui;
}
