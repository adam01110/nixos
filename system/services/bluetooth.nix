{
  config,
  lib,
  ...
}:

# optional bluetooth service, toggled per host.
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

    # bluetooth applet and helpers (tray bluetooth manager).
    services.blueman.enable = true;
  };
}
