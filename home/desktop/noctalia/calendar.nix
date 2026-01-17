_:
# define card layout for the noctalia calendar widget.
{
  programs.noctalia-shell.settings.calendar.cards = [
    {
      id = "calendar-header-card";
      enabled = true;
    }
    {
      id = "weather-card";
      enabled = false;
    }
    {
      id = "calendar-month-card";
      enabled = true;
    }
  ];
}
