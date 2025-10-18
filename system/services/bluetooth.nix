{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgBluetooth = config.optServices.bluetooth.enable;
in
{
  options.optServices.bluetooth.enable = mkEnableOption "Enable bluetooth services.";

  config = mkIf cfgBluetooth {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings.General.Experimental = true;
    };
  };
}
