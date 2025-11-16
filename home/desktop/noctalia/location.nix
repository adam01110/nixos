{
  vars,
  ...
}:

let
  inherit (vars)
    noctaliaFirstDayOfWeek
    noctaliaLocation
    ;
in
{
  # calendar locale and weather location.
  programs.noctalia-shell.settings.location = {
    analogClockInCalendar = false;
    firstDayOfWeek = noctaliaFirstDayOfWeek;
    name = noctaliaLocation;
    showCalendarEvents = true;
    showCalendarWeather = false;
    showWeekNumberInCalendar = true;
    use12hourFormat = false;
    useFahrenheit = false;
    weatherEnabled = true;
  };
}
