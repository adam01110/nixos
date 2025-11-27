{ ... }:

{
  programs.noctalia-shell.settings.calendar.cards = [
    {
      id = "banner-card";
      enabled = true;
    }
    {
      id = "weather-card";
      enabled = false;
    }
    {
      id = "calendar-card";
      enabled = true;
    }
    {
      id = "timer-card";
      enabled = false;
    }
  ];
}
