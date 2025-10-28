{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.optServices.bluetooth.enable = mkEnableOption "Enable bluetooth services.";

  config =
    let
      cfgBluetooth = config.optServices.bluetooth.enable;
    in
    mkIf cfgBluetooth {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
        settings.General.Experimental = true;
      };
    };
}
