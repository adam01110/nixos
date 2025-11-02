{
  config,
  lib,
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

  config = mkIf config.optServices.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings.General.Experimental = true;
    };
  };
}
