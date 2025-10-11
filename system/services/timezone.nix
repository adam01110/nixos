{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgTimezone = config.optServices.timezone;
in
{
  options.optServices.timezone = mkOption {
    type = types.nullOr types.str;
    default = null;
    example = "Europe/Amsterdam";
    description = ''
      Configure the system time zone or enable automatic adjustment.
      Set to a time zone string (for example "Europe/Amsterdam") to use a fixed time zone,
      or to "automatic-timezoned" to enable the automatic-timezoned service.
    '';
  };

  config = mkMerge [
    (mkIf (cfgTimezone != null && cfgTimezone != "automatic-timezoned") {
      time.timeZone = cfgTimezone;
    })
    (mkIf (cfgTimezone == "automatic-timezoned") {
      services.automatic-timezoned.enable = true;
    })
  ];
}
