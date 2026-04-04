{
  config,
  lib,
  vars,
  ...
}:
# Calendar locale and weather location.
let
  inherit
    (lib)
    mkMerge
    mkIf
    mkOption
    types
    mkForce
    ;
  inherit (vars) noctaliaFirstDayOfWeek;

  cfgLocation = config.noctalia.location;
in {
  options.noctalia.location = mkOption {
    type = types.nullOr (types.enum ["autolocate" "sops"]);
    default = "autolocate";
    description = ''
      Configure the Noctalia location source.
      Set to "autolocate" to use automatic location detection, or to "sops"
      to read the location from the `noctalia/location` secret.
    '';
  };

  config = mkMerge [
    {
      programs.noctalia-shell.settings.location = {
        analogClockInCalendar = true;
        firstDayOfWeek = noctaliaFirstDayOfWeek;
        showCalendarWeather = false;
        showWeekNumberInCalendar = true;
        autoLocate = true;
      };
    }

    # Read the desktop weather location from sops at runtime.
    (let
      hostname = config.networking.hostName;
    in
      mkIf (cfgLocation == "sops") {
        sops.secrets."noctalia/location/${hostname}" = {};
        programs.noctalia-shell = {
          settings.location.autoLocate = mkForce false;
          systemd.locationFile = config.sops.secrets."noctalia/location".path;
        };
      })
  ];
}
