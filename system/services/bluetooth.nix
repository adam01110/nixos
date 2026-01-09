{
  config,
  lib,
  ...
}:
# optional bluetooth service, toggled per host.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
in {
  options.optServices.bluetooth.enable = mkEnableOption "Enable bluetooth services.";

  config.hardware.bluetooth = mkIf config.optServices.bluetooth.enable {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };
}
