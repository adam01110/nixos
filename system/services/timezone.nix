{
  config,
  lib,
  ...
}:

# time zone configuration with optional automatic mode.
let
  inherit (lib)
    mkIf
    mkMerge
    mkOption
    types
    ;
in
{
  options.optServices.timezone = mkOption {
    type = types.nullOr types.str;
    default = null;
    example = "Europe/Amsterdam";
    description = ''
      configure the system time zone or enable automatic adjustment.
      set to a time zone string (for example "europe/amsterdam") to use a fixed time zone,
      or to "automatic-timezoned" to enable the automatic-timezoned service.
    '';
  };

  # choose between a fixed time zone or automatic-timezoned service.
  config =
    let
      cfgTimezone = config.optServices.timezone;
    in
    mkMerge [
      (mkIf (cfgTimezone != null && cfgTimezone != "automatic-timezoned") {
        time.timeZone = cfgTimezone;
      })
      (mkIf (cfgTimezone == "automatic-timezoned") {
        services.automatic-timezoned.enable = true;
      })
    ];
}
