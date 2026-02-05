{
  config,
  lib,
  ...
}:
# Optional bluetooth service, toggled per host.
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
    # Enable experimental features needed by some devices.
    settings.General.Experimental = true;

    # Disable bluetooth power-on at boot to save battery.
    powerOnBoot = false;
  };
}
