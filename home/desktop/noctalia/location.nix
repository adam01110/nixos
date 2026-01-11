{vars, ...}:
# calendar locale and weather location.
let
  inherit
    (vars)
    noctaliaFirstDayOfWeek
    noctaliaLocation
    ;
in {
  programs.noctalia-shell.settings.location = {
    analogClockInCalendar = true;
    firstDayOfWeek = noctaliaFirstDayOfWeek;
    name = noctaliaLocation;
    showCalendarWeather = false;
    showWeekNumberInCalendar = true;
  };
}
