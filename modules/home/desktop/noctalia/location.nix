{
  config,
  vars,
  ...
}:
# Calendar locale and weather location.
let
  inherit (vars) noctaliaFirstDayOfWeek;
in {
  sops.secrets."noctalia/location" = {};

  programs.noctalia-shell = {
    systemd.locationFile = config.sops.secrets."noctalia/location".path;

    settings.location = {
      analogClockInCalendar = true;
      firstDayOfWeek = noctaliaFirstDayOfWeek;
      showCalendarWeather = false;
      showWeekNumberInCalendar = true;
    };
  };
}
