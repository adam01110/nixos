{
  osConfig,
  lib,
  pkgs,
  ...
}:
# Install terminal bluetooth manager when bluetooth is enabled.
let
  inherit (lib) optional;
  cfgBluetooth = osConfig.optServices.bluetooth.enable;
in {
  # Only install when bluetooth is enabled.
  home.packages = optional cfgBluetooth pkgs.bluetui;
}
